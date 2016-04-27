#
# Cookbook Name:: db2
# Recipe:: default
#
# Copyright 2016, rohit company
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


binary_dir = "#{Chef::Config[:file_cache_path]}"


group "#{node['db2']['db2fence1-group']}" do
action :create
end

user "#{node['db2']['db2fence1-user']}" do
  group "#{node['db2']['db2fence1-group']}"
  home "#{node['db2']['db2fence1-home']}"
  action :create
end

group "#{node['db2']['db2inst1-group']}" do
action :create
end

user "#{node['db2']['db2inst1-user']}" do
  group "#{node['db2']['db2inst1-group']}"
  home "#{node['db2']['db2inst1-home']}"
  action :create
  password "$1$dqaVML9L$0ZGltm8AbRO6IkbhmHmYT1"
end

directory "#{node['db2']['db2fence1-home']}" do
  owner "#{node['db2']['db2fence1-user']}"
  group "#{node['db2']['db2fence1-group']}"
  mode '0755'
  action :create
end

directory "#{node['db2']['db2inst1-home']}" do
  owner "#{node['db2']['db2inst1-user']}"
  group "#{node['db2']['db2inst1-group']}"
  mode '0755'
  action :create
end


template "#{binary_dir}/#{node['db2']['db2inst1-INS']}" do
  source 'db2inst1-INS.erb'
  variables(
  file: "#{node['db2']['db2_install_dir']}",
  install_type: "#{node['db2']['install_type']}",
  db2password: "#{node['db2']['db2_password']}"
  )
  owner 'root'
  group 'root'
  mode '0644'
  #notifies :run, 'execute[install-db2]', :immediately
end

execute 'create-instance' do
  command "#{node['db2']['db2_install_dir']}/instance/db2isetup -r #{binary_dir}/#{node['db2']['db2inst1-INS']}"
  cwd binary_dir
  action :run
end

