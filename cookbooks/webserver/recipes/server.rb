#
# Cookbook Name:: webserver
# Recipe:: server
#
# Copyright (c) 2020 The Authors, All Rights Reserved.
package "httpd" do
    action :install
end

=begin

Notice that this part of code is commented for future use of template resource in this
cookbook

file "/var/www/html/index.html" do
    action :create
    content "<h1>Hello World..!</h1>
    <h2>HOSTNAME :: #{node['hostname']}</h2>
    <h2>IPADDRESS :: #{node['ipaddress']}</h2>
    "
end

=end

template "WEB PAGE" do
    source "index.html.erb"
    path "/var/www/html/index.html"

    variables (
        { :name => "Sagar" }
    )
    action :create
end

service "httpd" do
    action [:enable, :start]
end