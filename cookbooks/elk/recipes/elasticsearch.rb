# -*- encoding: utf-8 -*-
#
# Cookbook Name:: elk
# Recipe:: elasticsearch
#
######################################################

include_recipe 'elk::elasticsearch_install'

service 'elasticsearch' do
  action [:enable, :start]
end
