#
# Cookbook Name:: FTPlogin
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


# wastest_dir = "#{Chef::Config[:file_cache_path]}/was-test"
# wastestfile = "#{wastest_dir}/WAS_V8.5.5_1_OF_3"
# ssh_dir = "/root/.ssh"
# authkeys = "#{ssh_dir}/authorized_keys"
# knownhosts = "#{ssh_dir}/known_hosts"

# directory wastest_dir do
#   owner 'root'
#   group 'root'
#   mode '0755'
#   action :create
# end


# file '/root/.netrc' do
#   action :create
#   owner 'root'
#   group 'root'
#   mode '0600'
# end

# execute 'netrc' do
#   command 'echo "machine 9.191.4.227 login ftplogin passwd W1zplay11" > /root/.netrc'
# end

# file '/home/vagrant/.netrc' do
#   action :create
#   owner 'vagrant'
#   group 'root'
#   mode '0600'
# end

# execute 'vnetrc' do
#   command 'echo "machine 9.191.4.227 login ftplogin passwd W1zplay11" > /home/vagrant/.netrc'
# end

# remote_file wastestfile do
#   owner 'root'
#   group 'root'
#   mode '0644'
#   ftp_active_mode false
#   #source "http://9.191.4.193/agent.installer.linux.gtk.x86_64_1.8.3000.20150606_0047.zip"
#   source "#{node['FTPlogin']['ftp-host']}/WAS_V8.5.5_1_OF_3"
# end

# directory ssh_dir do
#   owner 'root'
#   group 'root'
#   mode '0700'
#   action :create
# end

# remote_file authkeys do
#   owner 'root'
#   group 'root'
#   mode '0640'
#   #source "http://9.191.4.193/agent.installer.linux.gtk.x86_64_1.8.3000.20150606_0047.zip"
#   source "#{node['FTPlogin']['webserver']}/authorized_keys"
# end

# remote_file knownhosts do
#   owner 'root'
#   group 'root'
#   mode '0640'
#   #source "http://9.191.4.193/agent.installer.linux.gtk.x86_64_1.8.3000.20150606_0047.zip"
#   source "#{node['FTPlogin']['webserver']}/known_hosts"
# end

# execute 'filetransfer' do
#   command 'scp ftplogin@9.191.4.227:/opt/IBM/HTTPServer/docroot/WAS_V8.5.5_1_OF_3 /'
#   action :run
# end

Chef::Log.info("This VM has IP address #{node["ipaddress"]} and hostname: #{node["hostname"]};  WAS binary bath is #{node['FTPlogin']['wasbinpath']}")

# execute 'filetransfer' do
#   command "./versionInfo.sh > #{wastestfile}"
#   cwd "#{node['FTPlogin']['wasbinpath']}"
#   action :run
# end

