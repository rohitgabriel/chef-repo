directory "/etc/pki/tls/certs" do
  owner "root"
  group "root"
  mode '0755'
  recursive true
  action :create
end

directory "/etc/pki/tls/private" do
  owner "root"
  group "root"
  mode '0755'
  recursive true
  action :create
end

template "/etc/ssl/openssl.cnf" do
  source 'openssl-cnf.erb'
  #variables(
  #file: "#{node['db2']['db2_install_dir']}",
  #install_type: "#{node['db2']['install_type']}",
  #db2password: "#{node['db2']['db2_password']}"
  #)
  owner 'root'
  group 'root'
  mode '0644'
end

execute 'generate-ssl-cert' do
  action :run
  command "openssl req -subj '/CN=elk.local/' -x509 -days 3650 -batch -nodes -newkey rsa:2048 -keyout private/logstash-forwarder.key -out certs/logstash-forwarder.crt"
  cwd '/etc/pki/tls'
end
