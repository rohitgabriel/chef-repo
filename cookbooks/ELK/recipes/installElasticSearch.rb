
execute 'import-elasticsearch-gpgkey' do
  action :run
    command "wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add -"
end

execute 'create-elasticsearch-sourcelist' do
  action :run
    command "echo 'deb http://packages.elastic.co/elasticsearch/2.x/debian stable main' | sudo tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list"
end

execute 'apt-get-update' do
  action :run
    command "apt-get update"
end

execute 'install-elasticsearch' do
  action :run
    command "apt-get -y install elasticsearch"
end


template "/etc/elasticsearch/elasticsearch.yml" do
  source 'elasticsearch-yml.erb'
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
    command "update-rc.d elasticsearch defaults 95 10"
end

service 'elasticsearch' do
  action :start
end
