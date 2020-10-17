#
# Cookbook Name:: apache
# Recipe:: webserver
#
# Copyright (c) 2020 The Authors, All Rights Reserved.
cookbook_file "Web Page" do
    source "index.html"
    path "/var/www/html/index.html"
    action :create
end
