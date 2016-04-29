execute 'import-functions' do
  action :run
    command "apt-get -y install software-properties-common python-software-properties"
end

execute 'add-apt-repo' do
  action :run
    command "add-apt-repository -y ppa:webupd8team/java"
end

execute 'accept-license' do
  action :run
    command "echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections"
end

execute 'license' do
  action :run
    command "echo debconf shared/accepted-oracle-license-v1-1 seen true | /usr/bin/debconf-set-selections"
end

execute 'apt-get-update' do
  action :run
    command "apt-get update"
end

execute 'install-java' do
  action :run
    command "apt-get -y install oracle-java8-installer"
end
