directory "/etc/pki/tls/certs" do
  owner "root"
  group "root"
  mode '0755'
  recursive true
  action :create
end

execute 'passwordless-ssh' do
  action :run
  command "cp /tmp/logstash-forwarder.crt /etc/pki/tls/certs/; chown root:root /etc/pki/tls/certs/logstash-forwarder.crt"
end

execute 'create-filebeat-sourcelist' do
  action :run
  command "echo 'deb https://packages.elastic.co/beats/apt stable main' |  sudo tee -a /etc/apt/sources.list.d/beats.list"
end

execute 'import-elasticsearch-gpgkey' do
  action :run
  command "wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add -"
end
execute 'apt-get-update' do
  action :run
  command "apt-get update"
end

execute 'install-filebeat' do
  action :run
    command "apt-get -y install filebeat"
end

template "/etc/filebeat/filebeat.yml" do
  source 'filebeat.erb'
  #variables(
  #file: "#{node['db2']['db2_install_dir']}",
  #install_type: "#{node['db2']['install_type']}",
  #db2password: "#{node['db2']['db2_password']}"
  #)
  owner 'root'
  group 'root'
  mode '0644'
end

execute 'start-on-bootup' do
  action :run
    command "update-rc.d filebeat defaults 95 10"
end

service 'filebeat' do
  action :restart
end
