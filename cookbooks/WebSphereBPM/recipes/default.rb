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
Chef::Log.info("Updating limits.conf file")
execute 'limitsconf' do
  command "for x in "* soft stack 32768" "* hard stack 32768" "* soft nofile 65536" "* hard nofile 65536" "* soft nproc 16384" "* hard nproc 16384" ; do echo "$x" >> /etc/security/limits.conf; done"
  action :run
end

