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


#Pre Installation tasks for WebSphereBPM
#include_recipe 'InstallationManager::default'


bpmbinary_dir = "#{Chef::Config[:file_cache_path]}/BPMbinaries"
binaries = [ "#{node['WebSphereBPM']['package-name-1']}", "#{node['WebSphereBPM']['package-name-2']}", "#{node['WebSphereBPM']['package-name-3']}"]
checksums = [ "#{node['WebSphereBPM']['package1-sha256sum']}", "#{node['WebSphereBPM']['package2-sha256sum']}", "#{node['WebSphereBPM']['package3-sha256sum']}"]

was_dir = "#{node['WebSphereBPM']['was_install_dir']}"
im_dir = "#{node['WebSphereBPM']['imcl_install_dir']}"
imagentdata_dir = "#{node['WebSphereBPM']['imagentdata_install_dir']}"
imshared_dir = "#{node['WebSphereBPM']['imshared_install_dir']}"
bpmuserhome = "#{node['WebSphereBPM']['bpmuserhome']}"
ssh_dir = "/root/.ssh"


Chef::Log.info("Updating limits.conf file")
execute 'limitsconf' do
  command "for x in '* soft stack 32768' '* hard stack 32768' '* soft nofile 65536' '* hard nofile 65536' '* soft nproc 16384' '* hard nproc 16384' ; do echo '$x' >> /etc/security/limits.conf; done"
  action :run
end


directory bpmbinary_dir do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

directory 'was_dir' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

directory 'bpmuserhome' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

directory 'ssh_dir' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

Chef::Log.info("Creating OS group bpmgrp: #{node['WebSphereBPM']['bpmgroup']} ")
group "#{node['WebSphereBPM']['bpmgroup']}" do
action :create
end

Chef::Log.info("Creating OS user bpmuser and adding to bpmgrp")
user "#{node['WebSphereBPM']['bpmuser']}" do
  group "#{node['WebSphereBPM']['bpmgroup']}"
  home "#{node['WebSphereBPM']['bpmuserhome']}"
  action :create
end

count = 0

binaries.each { | package_name |
	# remote_file "#{wasbinary_dir}/#{package_name}" do
	#   owner 'root'
	#   group 'root'
	#   mode '0644'
	#   source "#{node['WebSphereBPM']['webserver']}/#{package_name}"
	# end  
Chef::Log.info("copying packages")
	execute 'copy-BPM' do
	  action :run
      command "scp #{node['WebSphereBPM']['ftploginuser']}@#{node['WebSphereBPM']['binaryhost']}:/opt/ibm/HTTPServer/docroot/#{package_name} #{bpmbinary_dir}"
	  cwd bpmbinary_dir
	end

  ruby_block "Validate Package Checksum" do
    action :run
    block do
      require 'digest'
      checksum = Digest::SHA256.file("#{bpmbinary_dir}/#{package_name}").hexdigest
      if checksum != checksums[count]
        raise "#{package_name} #{count} Downloaded package Checksum #{checksum} does not match known checksum #{checksums[count]}"
      end
      count += 1
    end
  end

	execute 'extract-BPM' do
	  action :run
      command "tar -xvzf #{package_name}"
      # command "cat #{package_name} >> looptest"
	  cwd bpmbinary_dir
	end
}

template "#{bpmbinary_dir}/#{node['WebSphereBPM']['bpm-responsefile']}" do
  source 'BPM-responsefile.erb'
  variables(
  bpminstallpath: "#{node['WebSphereBPM']['bpm-installpath']}",
  imsharedpath: "#{node['WebSphereBPM']['imshared_install_dir']}",
  repolocation: "#{bpmbinary_dir}"
  )
  owner 'root'
  group 'root'
  mode '0644'
  #notifies :run, 'execute[install-bpm]', :immediately
end

# execute 'install-bpm' do
#   command "#{node['WebSphereBPM']['imcl-path']} -acceptLicense -showProgress input '#{wasbinary_dir}/#{node['WebSphereBPM']['was-responsefile']}' -dataLocation '#{node['WebSphereBPM']['imagentdata_install_dir']}' -log '#{wasbinary_dir}/WAS85NDinstall.log'"
#   cwd wasbinary_dir
#   action :run
# end