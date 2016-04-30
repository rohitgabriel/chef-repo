service 'elasticsearch' do
  action :start
end

service 'kibana' do
  action :start
end

service 'logstash' do
  action :start
end

service 'nginx' do
  action :start
end
