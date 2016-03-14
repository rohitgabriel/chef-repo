# See http://docs.chef.io/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "rohitphoenix"
client_key               "#{current_dir}/rohitphoenix.pem"
validation_client_name   "cheftested-validator"
validation_key           "#{current_dir}/cheftested-validator.pem"
chef_server_url          "https://api.chef.io/organizations/cheftested"
cookbook_path            ["#{current_dir}/../cookbooks"]



cookbook_copyright "rohit company"
cookbook_license "apachev2"
cookbook_email "rohit.phoenix@gmail.com"

