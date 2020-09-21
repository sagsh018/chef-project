#
# Cookbook Name:: workstation
# Recipe:: setup
#
# Copyright (c) 2020 The Authors, All Rights Reserved.

package "ntp"
package "tree" do
    action :install
end

package "git" do
    action :install
end

# Example to print statment  "I have 4 apples" using a variable named as apple_count
# ======================================
# apple_count = 4 # variable is defined
# puts "I have #{apple_count} apples"
# ======================================
# notice that whenever we want to have a variable expension in our string, we always surround that strin with double
# quotes.

# example of how to get the values from the node object 
# =======================
# node['ipaddress']
# node['memory']['total']
# =======================
# So notice whenever we want to access the sub-attribute as well we make use of double square bracket.

# Now lets go ahead and add the required code in our file resource under content section

file "/etc/motd" do
content "This server is resource of sagar
    HOSTNAME : #{node['hostname']}
    IP ADDRESS : #{node['ipaddress']}
    CPU SPEED : #{node['cpu']['0']['mhz']}
    Total Memory : #{node['memory']['total']}
"
    owner "root"
    group "root"
end

service "ntpd" do
    action [:enable, :start]
end