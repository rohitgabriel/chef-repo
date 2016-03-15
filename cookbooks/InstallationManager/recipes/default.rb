#
# Cookbook Name:: InstallationManager
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

binary_dir = "#{Chef::Config[:file_cache_path]}/IMbinaries"
binary_path = "#{binary_dir}/node[InstallationManager][package-name]"
base_dir = "/opt/IBM"
im_dir = "/opt/IBM/InstallationManager"
imagentdata_dir = "/opt/IBM/IMAgentData"
imshared_dir = "/opt/IBM/IMShared"


directory binary_dir do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

directory base_dir do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end


directory im_dir do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

directory imagentdata_dir do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

directory imshared_dir do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

execute 'unzip' do
  command 'apt-get install unzip'
  creates 'unzip installer'
  action :run
end

remote_file binary_path do
  owner 'root'
  group 'root'
  mode '0644'
  source "http://192.168.1.4/agent.installer.linux.gtk.x86_64_1.8.3000.20150606_0047.zip"
  action :create
  notifies :run, 'execute[extract-InstallationManager]', :immediately
end

execute 'extract-InstallationManager' do
  command "unzip #{binary_path}"
  cwd binary_dir
  # Only run after notified by remote_file download
  action :nothing
end

template "#{binary_dir}/#{node['InstallationManager']['im-responsefile']}" do
  source 'IM-responsefile.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :run, 'execute[install-InstallationManager]', :immediately
end

execute 'install-InstallationManager' do
  command "#{binary_dir}/userinstc -log #{binary_dir}/instman.log -acceptLicense -dataLocation /opt/IBM/IMAgentData"
  cwd binary_dir
  action :run
end

