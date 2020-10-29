#
# Cookbook:: myhaproxy
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

haproxy_install 'package'

haproxy_frontend 'http-in' do
  bind '*:80'
  default_backend 'servers'
end

haproxy_backend 'servers' do
    server [
      'web1 192.168.10.43:80 maxconn 32'
    ]
    # notifies :reload, 'haproxy_service[haproxy]', :immediately
    # but this notifies is not going to work, as there is a open issue going on with this community cookbook.
    # So we will using the reverse way to getting the service haproxy to be restarted when there are new web servers
    # added to the above array of servers.
    # and that will be subscribe notifications in the haproxy_service resource.
end

haproxy_service 'haproxy' do
    subscribes :reload, 'template[/etc/haproxy/haproxy.cfg]', :immediately
    # Notice that instead of giving the resource name "haproxy_backend" we are giving template resource name
    # that is because if you open the haproxy_backend resource and look inside that, it is ultimately made up
    # of template resource we are refering to.
    # so when we are going to add new web servers the template will get modify and hence this service resource is
    # listening to that.
end