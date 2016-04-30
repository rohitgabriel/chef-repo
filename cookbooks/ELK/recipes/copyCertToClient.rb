Chef::Log.info("Setting up passwordless ssh to #{node['ELK']['clientIP']}")

execute 'update-packages' do
  command "apt-get update; apt-mark hold grub-pc; apt-get -y upgrade"
  action :run
end

apt_package 'sshpass' do
  action :install
end

execute 'passwordless-ssh' do
  action :run
  command "yes | ssh-keygen -f /root/.ssh/id_rsa -t rsa -N ''; sshpass -p #{node['ELK']['ftploginpwd']} ssh -o 'StrictHostKeyChecking no' #{node['ELK']['ftploginuser']}@#{node['ELK']['clientIP']} mkdir -p .ssh; cat /root/.ssh/id_rsa.pub | sshpass -p #{node['ELK']['ftploginpwd']} ssh -o 'StrictHostKeyChecking no' #{node['ELK']['ftploginuser']}@#{node['ELK']['clientIP']} 'cat >> .ssh/authorized_keys'"
end

execute 'CopyCert-To-Client' do
  command "scp /etc/pki/tls/certs/logstash-forwarder.crt #{node['ELK']['ftploginuser']}@#{node['ELK']['clientIP']}:/tmp"
  action :run
end
