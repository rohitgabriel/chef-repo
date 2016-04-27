
execute 'hosts' do
  command "chmod 755 /opt/ibm/db2/10.1/adm/*; /opt/ibm/db2/10.1/adm/db2start; /opt/IBM/WebSphere/BPM/v8.5/profiles/Dmgr/bin/startManager.sh; /opt/IBM/WebSphere/BPM/v8.5/profiles/ManagedAppServers/bin/syncNode.sh localhost 8879; /opt/IBM/WebSphere/BPM/v8.5/profiles/ManagedAppServers/bin/startNode.sh; /opt/IBM/WebSphere/BPM/v8.5/profiles/ManagedAppServers/bin/startServer.sh Messaging_A_1; /opt/IBM/WebSphere/BPM/v8.5/profiles/ManagedAppServers/bin/startServer.sh Support_A_1; /opt/IBM/WebSphere/BPM/v8.5/profiles/ManagedAppServers/bin/startServer.sh AppTarget_A_1 "
  cwd "/"
  action :run
end
