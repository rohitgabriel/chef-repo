
execute 'apt-get-update' do
  action :run
    command "apt-get update"
end

execute 'install-nginx' do
  action :run
    command "apt-get -y install nginx apache2-utils"
end

execute 'create-adminuser' do
  action :run
    command "htpasswd -c /etc/nginx/htpasswd.users wizplay -P wizplay"
end

template "/etc/nginx/sites-available/default" do
  source 'default.erb'
  #variables(
  #file: "#{node['db2']['db2_install_dir']}",
  #install_type: "#{node['db2']['install_type']}",
  #db2password: "#{node['db2']['db2_password']}"
  #)
  owner 'root'
  group 'root'
  mode '0644'
end

service 'nginx' do
  action :start
end
