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

remote_file "My FB image" do
    source "https://scontent.fdel33-1.fna.fbcdn.net/v/t1.0-9/52961230_2102800463100481_5485985113277726720_n.jpg?_nc_cat=108&_nc_sid=85a577&_nc_ohc=rE2LPLIuf3wAX9tjy-F&_nc_ht=scontent.fdel33-1.fna&oh=7fc551da51dcd213cff3757708dc52b8&oe=5FB20654"
    path "/var/www/html/my_image.png"
end

template "WEB PAGE" do
    source "index.html.erb"
    path "/var/www/html/index.html"

    variables (
        { :name => "Sagar" }
    )
    action :create

    # notifies :restart, 'service[httpd]', :immediately 
end

=begin
bash "inline script" do
    user "root"
    code "mkdir -p /var/www/mysites && chown -R apache /var/www/mysites" 
    # not_if "[ -d /var/www/mysites/ ]"  # you can use either of this way or the ruby block of do end as written below.
    not_if do
        File.directory?("/var/www/mysites")
    end
end
=end

execute "run commands" do
    user "root"
    command <<-EOH
        mkdir -p /var/www/mysites/
        chown -R apache /var/www/mysites
    EOH
    not_if do
        File.directory?("/var/www/mysites")
    end
end

=begin --> commenting this section to to kitchen converge
execute "run script" do
    user "root"
    command <<-EOH
        cd /vagrant
        ./create_dir.sh
    EOH
    not_if do
        File.directory?("/var/www/html/othersites/")
    end
end
=end

directory "creates directory" do
    path "/var/www/html/othersites"
    owner "apache"
    recursive true
    mode 0755
end

service "httpd" do
    action [:enable, :start]

    subscribes :restart, "template[/var/www/html/index.html]", :immediately
end