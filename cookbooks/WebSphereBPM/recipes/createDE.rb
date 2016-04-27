#
# Cookbook Name:: WebSphereBPM
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

bpmprop_dir = "#{Chef::Config[:file_cache_path]}"

execute 'bash' do
  environment 'LANG' => "en_US.UTF-8", 'LANGUAGE' => "en_US.UTF-8", 'LC_ALL' => "en_US.UTF-8"
  command "unlink sh; ln -s /bin/bash sh; env > /tmp/chefenv2"
  cwd "/bin"
  action :run
end

template "#{bpmprop_dir}/#{node['WebSphereBPM']['Advanced-PS-ThreeClusters-DB2-props']}" do
  source 'Advanced-PS-ThreeClusters-DB2.erb'
  variables(
  hostname: "#{node['hostname']}",
  db2password: "#{node['WebSphereBPM']['db2password']}",
  bpmuser: "#{node['WebSphereBPM']['bpmuser']}",
  bpmpassword: "#{node['WebSphereBPM']['bpmpassword']}",
  bpmdmgrnodename: "#{node['WebSphereBPM']['bpmdmgrnodename']}",
  bpmcellname: "#{node['WebSphereBPM']['bpmcellname']}",
  bpmdmgrpath: "#{node['WebSphereBPM']['bpmdmgrpath']}",
  bpminstallpath: "#{node['WebSphereBPM']['bpm-installpath']}",
  bpmdmgrname: "#{node['WebSphereBPM']['bpmdmgrname']}",
  bpmdmgrsoapport: "#{node['WebSphereBPM']['bpmdmgrsoapport']}",
  bpmnodename: "#{node['WebSphereBPM']['bpmnodename']}"
)
  owner 'root'
  group 'root'
  mode '0644'
  #notifies :run, 'execute[install-bpm]', :immediately
end

execute 'hosts' do
  command "echo '127.0.0.1       #{node["hostname"]}  localhost' >> /etc/hosts  "
  cwd "/etc"
  action :run
end

execute 'createDE' do
  command "ulimit -n 65536; '#{node['WebSphereBPM']['bpm-path']}'/BPMConfig.sh -create -de #{Chef::Config[:file_cache_path]}/#{node['WebSphereBPM']['Advanced-PS-ThreeClusters-DB2-props']}"
  environment 'LANG' => "en_US.UTF-8", 'LANGUAGE' => "en_US.UTF-8", 'LC_ALL' => "en_US.UTF-8"
   cwd bpmprop_dir
   timeout 15000
   action :run
end

template "#{node['WebSphereBPM']['bpm-installpath']}/profiles/#{node['WebSphereBPM']['bpmdmgrname']}/properties/soap.client.props" do
  source 'soap-client-props.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

template "#{node['WebSphereBPM']['bpm-installpath']}/profiles/#{node['WebSphereBPM']['bpmnodename']}/properties/soap.client.props" do
  source 'soap-client-props.erb'
  owner 'root'
  group 'root'
  mode '0644'
end
