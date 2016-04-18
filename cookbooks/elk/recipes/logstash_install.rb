#
# Cookbook Name:: elk
# Recipe:: logstash_install

######################################################
# https://supermarket.chef.io/cookbooks/logstash#readme
node.default['logstash']['instance_default']['version'] = \
node['elk']['logstash_version']
node.default['logstash']['instance_default']['java_home'] = \
'/usr/lib/jvm/java-8-oracle-amd64'
node.default['logstash']['instance_default']['init_method'] = 'native'

template '/etc/init.d/logstash_server' do
  source 'logstash_initscript.erb'
  mode 0755
end

#include_recipe 'logstash::source'
# include_recipe 'logstash::server'

name = 'server'

logstash_instance name do
  action :create
end

logstash_service name do
  action [:enable]
end

logstash_config name do
  action [:create]
  notifies :restart, "logstash_service[#{name}]"
end

logstash_pattern name do
  action [:create]
end

logstash_curator 'server' do
  action [:create]
end

#include_recipe 'logstash::agent'
