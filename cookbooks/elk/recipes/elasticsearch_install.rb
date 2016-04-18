# -*- encoding: utf-8 -*-
#
# Cookbook Name:: elk
# Recipe:: elasticsearch_install
#
######################################################

%w(lsof).each do |x|
  package x do
    action :install
    not_if "dpkg -l #{x} | grep -E '^ii'"
  end
end

# https://supermarket.chef.io/cookbooks/elasticsearch
node.default['elasticsearch']['allocated_memory'] = \
node['elk']['allocated_memory']

node.default['elasticsearch']['cluster']['name'] = \
node['elk']['elasticsearch_cluster_name']

node.default['elasticsearch']['version'] = node['elk']['elasticsearch_version']

node.default['elasticsearch']['http']['port'] = \
node['elk']['elasticsearch_port']

# TODO: customize elasticsearch flagfile
node.default['elasticsearch']['pid_file'] = \
'/usr/local/var/run/vagrant_ubuntu_trusty_64.pid'

include_recipe 'elasticsearch::default'
include_recipe 'elasticsearch::plugins'

# TODO: integrate developer's customization of elasticsearch.yml
# template 'elasticsearch.yml' do
# path "#{node.elasticsearch[:path][:conf]}/elasticsearch.yml"
# source 'authright_elasticsearch.yml.erb'
# owner node.elasticsearch[:user]
# group node.elasticsearch[:user] and mode 0755
# notifies :restart, 'service[elasticsearch]'
# unless node.elasticsearch[:skip_restart]
# end
