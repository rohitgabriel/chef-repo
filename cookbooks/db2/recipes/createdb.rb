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


db2bin_dir = "/opt/ibm/db2/10.1/bin"

package ['whois'] do
  action :install
end


directory "#{node['db2']['db2user1-home']}" do
  owner "root"
  group "root"
  mode '0755'
  action :create
end


group "#{node['db2']['db2user1-group']}" do
action :create
end

user "#{node['db2']['db2user1-user']}" do
  group "#{node['db2']['db2user1-group']}"
  home "#{node['db2']['db2user1-home']}"
  action :create
end

directory "#{node['db2']['db2user1-home']}" do
  owner "#{node['db2']['db2user1-user']}"
  group "#{node['db2']['db2user1-group']}"
  mode '0755'
  action :create
end

template "#{node['db2']['db2inst1-home']}/.bashrc" do
  source 'db2-bashrc.erb'
  variables(
  path: "#{node['db2']['db2_install_dir']}/bin",
  install_type: "#{node['db2']['install_type']}",
  db2password: "#{node['db2']['db2_password']}"
  )
  owner "#{node['db2']['db2inst1-user']}"
  group "#{node['db2']['db2user1-group']}"
  mode '0644'
end

template "#{node['db2']['db2inst1-home']}/.bashprofile" do
  source 'db2-bashrc.erb'
  variables(
  path: "#{node['db2']['db2_install_dir']}/bin",
  install_type: "#{node['db2']['install_type']}",
  db2password: "#{node['db2']['db2_password']}"
  )
  owner "#{node['db2']['db2inst1-user']}"
  group "#{node['db2']['db2user1-group']}"
  mode '0644'
end

execute 'create-db' do
command 'su - db2inst1 -c "/opt/ibm/db2/10.1/bin/db2 create database BPMDB automatic storage yes using codeset UTF-8 territory NZ pagesize 32768; /opt/ibm/db2/10.1/bin/db2 create database PDWDB automatic storage yes using codeset UTF-8 territory NZ pagesize 32768; /opt/ibm/db2/10.1/bin/db2 create database CMNDB automatic storage yes using codeset UTF-8 territory NZ pagesize 32768; /opt/ibm/db2/10.1/bin/db2 connect to BPMDB; /opt/ibm/db2/10.1/bin/db2 grant dbadm on database to user bpmuser; /opt/ibm/db2/10.1/bin/db2 UPDATE DB CFG FOR BPMDB USING LOGFILSIZ 16384 DEFERRED;/opt/ibm/db2/10.1/bin/db2 UPDATE DB CFG FOR BPMDB USING LOGSECOND 64 DEFERRED; /opt/ibm/db2/10.1/bin/db2 connect reset; /opt/ibm/db2/10.1/bin/db2 connect to PDWDB; /opt/ibm/db2/10.1/bin/db2 grant dbadm on database to user bpmuser; /opt/ibm/db2/10.1/bin/db2 UPDATE DB CFG FOR PDWDB USING LOGFILSIZ 16384 DEFERRED;/opt/ibm/db2/10.1/bin/db2 UPDATE DB CFG FOR PDWDB USING LOGSECOND 64 DEFERRED; /opt/ibm/db2/10.1/bin/db2 connect reset; /opt/ibm/db2/10.1/bin/db2 connect to CMNDB; /opt/ibm/db2/10.1/bin/db2 grant dbadm on database to user bpmuser; /opt/ibm/db2/10.1/bin/db2 UPDATE DB CFG FOR CMNDB USING LOGFILSIZ 16384 DEFERRED;/opt/ibm/db2/10.1/bin/db2 UPDATE DB CFG FOR CMNDB USING LOGSECOND 64 DEFERRED; /opt/ibm/db2/10.1/bin/db2 connect reset;"' 
  cwd db2bin_dir 
  action :run
end


