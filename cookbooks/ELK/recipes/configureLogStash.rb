template "/etc/logstash/conf.d/02-beats-input.conf" do
  source '02-beats-input-conf.erb'
  #variables(
  #file: "#{node['db2']['db2_install_dir']}",
  #install_type: "#{node['db2']['install_type']}",
  #db2password: "#{node['db2']['db2_password']}"
  #)
  owner 'root'
  group 'root'
  mode '0644'
end

template "/etc/logstash/conf.d/10-syslog-filter.conf" do
  source '10-syslog-filter-conf.erb'
  #variables(
  #file: "#{node['db2']['db2_install_dir']}",
  #install_type: "#{node['db2']['install_type']}",
  #db2password: "#{node['db2']['db2_password']}"
  #)
  owner 'root'
  group 'root'
  mode '0644'
end

template "/etc/logstash/conf.d/30-elasticsearch-output.conf" do
  source '30-elasticsearch-output-conf.erb'
  #variables(
  #file: "#{node['db2']['db2_install_dir']}",
  #install_type: "#{node['db2']['install_type']}",
  #db2password: "#{node['db2']['db2_password']}"
  #)
  owner 'root'
  group 'root'
  mode '0644'
end

execute 'config-test' do
  action :run
  command "service logstash configtest"
end

service 'logstash' do
  action :restart
end

execute 'start-on-bootup' do
  action :run
  command "update-rc.d logstash defaults 96 9"
end
