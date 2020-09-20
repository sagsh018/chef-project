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

file "/etc/motd" do
    content "This server is resource of sagar"
    owner "root"
    group "root"
end

service "ntpd" do
    action [:enable, :start]
end