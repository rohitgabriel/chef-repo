temp_dir = "#{Chef::Config[:file_cache_path]}/kibana-dashboards"
load_dir = "#{temp_dir}/beats-dashboards-1.1.0"
directory temp_dir do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

execute 'install-unzip' do
  action :run
  command "apt-get -y install unzip"
end

execute 'download-dashboards' do
  action :run
  cwd temp_dir
  command "curl -L -O https://download.elastic.co/beats/dashboards/beats-dashboards-1.1.0.zip"
end

execute 'extract-dashboards' do
  action :run
  cwd temp_dir
  command "unzip -o beats-dashboards-*.zip"
end

execute 'load-dashboards' do
  action :run
  command "./load.sh"
  cwd load_dir
end

execute 'download-filebeat-index-template' do
  action :run
  command "curl -O https://gist.githubusercontent.com/thisismitch/3429023e8438cc25b86c/raw/d8c479e2a1adcea8b1fe86570e42abab0f10f364/filebeat-index-template.json"
  cwd temp_dir
end

execute 'load-filebeat-index-template' do
  action :run
  command "curl -XPUT 'http://localhost:9200/_template/filebeat?pretty' -d@filebeat-index-template.json"
  cwd temp_dir
end
