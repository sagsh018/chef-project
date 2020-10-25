# See https://docs.getchef.com/config_rb.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "sharmasag018"
client_key               "#{current_dir}/sharmasag018.pem"
chef_server_url          "https://chefserver/organizations/skylights"
cookbook_path            ["#{current_dir}/../cookbooks"]
