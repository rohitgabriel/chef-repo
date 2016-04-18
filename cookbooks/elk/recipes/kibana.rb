#
# Cookbook Name:: elk
# Recipe:: kibana

include_recipe 'elk::kibana_install'

service 'kibana' do
  supports status: true, restart: false
  action [:enable]
end
