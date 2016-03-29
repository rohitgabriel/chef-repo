#
# Cookbook Name:: my_cookbook
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
include_recipe "chef-client"
include_recipe "apt"
include_recipe "ntp"
file "/tmp/local_mode.txt" do
content "created by chef client local mode"
end
message = node['my_cookbook']['message']
Chef::Log.info("** Saying what I was told to say: #{message}")
xname = node['my_cookbook']['xname']
Chef::Log.info("** Lets see: #{xname}")

template '/tmp/message' do
  source 'message.erb'
  owner 'vagrant'
  group 'vagrant'
  mode '0644'
  variables(
	hi: 'Hola',
	world: 'Earth',
	from: node['fqdn']
	)

end


template '/tmp/fqdn' do
  source 'fqdn.erb'
  owner 'vagrant'
  group 'root'
  mode '0755'
  variables(
  	fqdn: node['fqdn']
  	)
end


capistrano_deploy_dirs do
deploy_to "/srv"
end
