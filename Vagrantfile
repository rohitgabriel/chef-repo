Vagrant.configure("2") do |config|
config.vm.box = "opscode-ubuntu-15.04"
config.vm.box_url = "file:///home/roxo/Downloads/opscode_ubuntu-15.04_chef-provisionerless.box"
config.omnibus.chef_version = :latest
config.vm.provision :chef_client do |chef|
chef.provisioning_path = "/etc/chef"
chef.chef_server_url = "https://api.chef.io/organizations/cheftested"
chef.validation_key_path = "/home/roxo/git/chef-repo/.chef/cheftested-validator.pem"
chef.validation_client_name = "cheftested-validator"
chef.node_name = "BPMNode"
config.berkshelf.enabled = true
end
end
