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


Chef::Log.info("Setting up passwordless ssh to #{node['FTPlogin']['binaryhost']}")
execute 'update-packages' do
  command "apt-get update; apt-mark hold grub-pc; apt-get -y upgrade"
  action :run
end

  apt_package 'sshpass' do
    action :install
  end
  execute 'passwordless-ssh' do
    action :run
      command "yes | ssh-keygen -f /root/.ssh/id_rsa -t rsa -N ''; sshpass -p #{node['FTPlogin']['ftploginpwd']} ssh -o 'StrictHostKeyChecking no' #{node['FTPlogin']['ftploginuser']}@#{node['FTPlogin']['binaryhost']} mkdir -p .ssh; cat /root/.ssh/id_rsa.pub | sshpass -p #{node['FTPlogin']['ftploginpwd']} ssh -o 'StrictHostKeyChecking no' #{node['FTPlogin']['ftploginuser']}@#{node['FTPlogin']['binaryhost']} 'cat >> .ssh/authorized_keys'"
  end
