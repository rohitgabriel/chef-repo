execute 'create-elasticsearch-logstash' do
  action :run
    command "echo 'deb http://packages.elastic.co/logstash/2.2/debian stable main' | sudo tee /etc/apt/sources.list.d/logstash-2.2.x.list"
end

execute 'apt-get-update' do
  action :run
    command "apt-get update"
end

execute 'install-logstash' do
  action :run
    command "apt-get -y install logstash"
end
