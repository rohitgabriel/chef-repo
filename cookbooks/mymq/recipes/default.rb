#
# Cookbook Name:: mymq
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
ibm_mq_installation 'Installation1' do
  source 'http://9.191.4.193/WS_MQ_LINUX_ON_X86_64_V8.0_IMG.tar.gz'
  accept_license true
  primary true
end

ibm_mq_queue_manager 'qm1' do
  action [:create, :start]
end

execute 'runmqsc' do
  command "echo 'define qlocal(foo) replace' | runmqsc qm1"
  user 'mqm'
  group 'mqm'
end