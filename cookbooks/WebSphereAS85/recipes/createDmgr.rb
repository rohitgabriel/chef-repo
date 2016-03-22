
Chef::Log.info("This VM has IP address #{node["ipaddress"]} and hostname: #{node["hostname"]};  WAS binary bath is ")

execute 'bash' do
  environment 'LANG' => "en_US.UTF-8", 'LANGUAGE' => "en_US.UTF-8", 'LC_ALL' => "en_US.UTF-8"
  command "unlink sh; ln -s /bin/bash sh; env > /tmp/chefenv2"
  cwd "/bin"
  action :run
end

# execute 'createDmgr' do
#   environment 'LANG' => "en_US.UTF-8", 'LANGUAGE' => "en_US.UTF-8", 'LC_ALL' => "en_US.UTF-8"
#   command "#{node['WebSphereAS85']['was85-binpath']}/manageprofiles.sh -create -profileName #{node['WebSphereAS85']['was85-dmgrname']} -profilePath #{node['WebSphereAS85']['was85-installpath']}/profiles/#{node['WebSphereAS85']['was85-dmgrname']} -templatePath #{node['WebSphereAS85']['was85-installpath']}/profileTemplates/management -nodeName #{node['WebSphereAS85']['was85-dmgrname']}Node -cellName #{node["hostname"]}Cell -hostname 10.0.2.15 -adminUserName wasuser -adminPassword wasuser -enableAdminSecurity true"
#   cwd "#{node['WebSphereAS85']['was85-binpath']}"
#   action :run
# end

# template "#{node['WebSphereAS85']['was85-installpath']}/profiles/#{node['WebSphereAS85']['was85-dmgrname']}/properties/soap.client.props" do
#   source 'soap-client-props.erb'
#   owner 'root'
#   group 'root'
#   mode '0644'
# end

execute 'startDmgr' do
  environment 'LANG' => "en_US.UTF-8", 'LANGUAGE' => "en_US.UTF-8", 'LC_ALL' => "en_US.UTF-8"
  command "#{node['WebSphereAS85']['was85-installpath']}/profiles/#{node['WebSphereAS85']['was85-dmgrname']}/bin/startManager.sh"
  cwd "#{node['WebSphereAS85']['was85-installpath']}/profiles/#{node['WebSphereAS85']['was85-dmgrname']}/bin"
  action :run
end