Vagrant.configure("2") do |config|
#config.vm.box = "ElasticSearch"
#config.vm.box_url = "file:///home/roxo/Downloads/opscode_ubuntu-15.04_chef-provisionerless.box"
#config.omnibus.chef_version = :latest
config.vm.define "elk" do |elk|
elk.vm.box = "elk-server"
elk.vm.box_url = "file:///home/roxo/Downloads/opscode_ubuntu-15.04_chef-provisionerless.box"
end

config.vm.provision :chef_client do |chef|
chef.provisioning_path = "/etc/chef"
chef.chef_server_url = "https://api.chef.io/organizations/cheftested"
chef.validation_key_path = "/home/roxo/git/chef-repo/.chef/cheftested-validator.pem"
chef.validation_client_name = "cheftested-validator"
chef.node_name = "ESNode"
config.vm.network "public_network", ip: "192.168.1.102", :mac => "0800275E27C2"
config.vm.provider "virtualbox" do |v|
  v.memory = 2048 
  v.cpus = 1 
end
end
end
