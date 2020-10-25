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

# Notce that we are commenting this below file resource becuase later on in this video we will be doing this task
# with the help of template resource, which are added below as well.

=begin
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
=end

template "Message Of The Day" do
    source "motd.erb"
    path "/etc/motd"
    owner "root"
    group "root"
    mode "755"
    variables (
        {:name => "Sagar"}
    )
    action :create
end

user "user1" do
    comment "test user 1"
    uid 1234
    home "/home/user1"
    shell "/bin/bash"
end

group "admins" do
    members "user1" # here we could also pass in the array of users if want to give multiple users.
end

service "ntpd" do
    action [:enable, :start]
end