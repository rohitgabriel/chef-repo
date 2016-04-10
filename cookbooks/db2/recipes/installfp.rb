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


db2fixpack_dir = "#{Chef::Config[:file_cache_path]}/DB2fixpack"
fpbinaries = [ "#{node['db2']['packagefp1-name-1']}"]
checksums = [ "#{node['db2']['packagefp1-sha256sum']}"]
base_dir = "/opt/ibm/db2"

package ['rpm','libaio1'] do
  action :install
end

directory db2fixpack_dir do
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

fpbinaries.each { | package_name |
Chef::Log.info("copying packages")
  execute 'copy-db2' do
    action :run
      command "scp #{node['db2']['ftploginuser']}@#{node['db2']['binaryhost']}:#{node['db2']['ftppath']}/#{package_name} #{db2fixpack_dir}"
    cwd db2fixpack_dir
  end

  ruby_block "Validate Package Checksum" do
    action :run
    block do
      require 'digest'
      checksum = Digest::SHA256.file("#{db2fixpack_dir}/#{package_name}").hexdigest
      if checksum != checksums[count]
        raise "#{package_name} #{count} Downloaded package Checksum #{checksum} does not match known checksum #{checksums[count]}"
      end
      count += 1
    end
  end

  execute 'extract-db2' do
    action :run
      command "tar -xvzf #{package_name}"
    cwd db2fixpack_dir
  end
}


execute 'install-db2' do
  command "#{db2fixpack_dir}/server/installFixPack -b #{base_dir}/10.1"
  cwd db2fixpack_dir
  action :run
end


directory db2fixpack_dir do
  action :delete
  recursive true
end
