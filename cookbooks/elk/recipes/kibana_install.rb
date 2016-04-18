#
# Cookbook Name:: elk
# Recipe:: kibana_install

# include_recipe 'chef-sugar::default'
include_recipe 'ark'

ark_prefix_root = '/usr/local'
ark_prefix_home = '/usr/local'

# Create user and group
#
group 'kibana group' do
  group_name 'kibana'
  action :create
  system true
end

user 'kibana user' do
  username 'kibana'
  comment 'Kibana User'
  home '/usr/local/kibana'
  shell '/bin/bash'
  gid 'kibana'
  supports manage_home: false
  action :create
  system true
end

# Create ES directories
#
['/usr/local/etc/kibana', '/usr/local/var/log/kibana'].each do |path|
  directory path do
    owner 'kibana'
    group 'kibana'
    mode 0755
    recursive true
    action :create
  end
end

directory 'create directory for kibana pid file' do
  path '/usr/local/var/run'
  mode 00755
  recursive true
end

# Create service
#
template '/etc/init.d/kibana' do
  source 'kibana_initscript.erb'
  owner 'root'
  mode 0755
end

# Download, extract, symlink the kibana libraries and binaries
#
download_url = node['elk']['kibana_download_url']

ark 'kibana' do
  url download_url
  owner 'kibana'
  group 'kibana'
  version node['elk']['kibana_version']
  has_binaries ['bin/kibana']
  checksum node['elk']['kibana_checksum']
  prefix_root ark_prefix_root
  prefix_home ark_prefix_home

  not_if do
    link   = '/usr/local/kibana'
    target = "/usr/local/kibana-#{node['elk']['kibana_version']}"
    binary = "#{target}/bin/kibana"

    ::File.directory?(link) && ::File.symlink?(link) && ::File.readlink(link) == target && ::File.exist?(binary)
  end
end

# Create ES config file
#
template 'kibana.yml' do
  path '/usr/local/etc/kibana/kibana.yml'
  source 'kibana.yml.erb'
  owner 'kibana'
  group 'kibana'
  mode 0755
end

# Fix: Workaround for hardcoded 512m memory requirement.
# This will probably be configured in future beta versions of Kibana 4.
#
replace_or_add 'Change hardcoded JAVA_OPTS in Kibana binary' do
  path '/usr/local/bin/kibana'
  pattern '^JAVA_OPTS=.*'
  line "JAVA_OPTS=\"#{node['elk']['kibana_java_opts']}\""
end

kibana_config_original = '/usr/local/kibana/config/kibana.yml'
file "Remove original kibana config - #{kibana_config_original}" do
  path kibana_config_original
  action :delete
end

link 'Link kibana configuration file' do
  target_file kibana_config_original
  to '/usr/local/etc/kibana/kibana.yml'
end
