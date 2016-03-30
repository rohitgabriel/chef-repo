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


db2binary_dir = "#{Chef::Config[:file_cache_path]}/DB2binaries"
binaries = [ "#{node['db2']['package-name-1']}"]
checksums = [ "#{node['db2']['package1-sha256sum']}"]
base_dir = "/opt/ibm/db2"

package ['rpm','libaio1','libaio1-dev'] do
  action :install
end

directory db2binary_dir do
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
  recursive true
end

count = 0

binaries.each { | package_name |
Chef::Log.info("copying packages")
  execute 'copy-db2' do
    action :run
      command "scp #{node['db2']['ftploginuser']}@#{node['db2']['binaryhost']}:#{node['db2']['ftppath']}/#{package_name} #{db2binary_dir}"
    cwd db2binary_dir
  end

  ruby_block "Validate Package Checksum" do
    action :run
    block do
      require 'digest'
      checksum = Digest::SHA256.file("#{db2binary_dir}/#{package_name}").hexdigest
      if checksum != checksums[count]
        raise "#{package_name} #{count} Downloaded package Checksum #{checksum} does not match known checksum #{checksums[count]}"
      end
      count += 1
    end
  end

  execute 'extract-db2' do
    action :run
      command "tar -xvzf #{package_name}"
    cwd db2binary_dir
  end
}


template "#{db2binary_dir}/#{node['db2']['db2-responsefile']}" do
  source 'db2-responsefile.erb'
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

execute 'install-db2' do
  command "#{db2binary_dir}/ese/db2setup -r #{db2binary_dir}/#{node['db2']['db2-responsefile']}"
  cwd db2binary_dir
  action :run
end


directory db2binary_dir do
  action :delete
  recursive true
end
