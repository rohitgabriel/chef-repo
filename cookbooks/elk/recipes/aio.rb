# -*- encoding: utf-8 -*-
#
# Cookbook Name:: elk
# Recipe:: aio
#
include_recipe 'elk::elasticsearch'
include_recipe 'elk::kibana'

# TODO: only enable logstash in log agent machines
include_recipe 'elk::logstash'
