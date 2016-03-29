# See http://docs.chef.io/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "rohitwestpac"
client_key               "#{current_dir}/rohitwestpac.pem"
validation_client_name   "chef-player-validator"
validation_key           "#{current_dir}/chef-player-validator.pem"
chef_server_url          "https://api.chef.io/organizations/chef-player"
cookbook_path            ["#{current_dir}/../cookbooks"]
