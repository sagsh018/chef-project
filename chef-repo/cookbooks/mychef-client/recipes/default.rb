#
# Cookbook:: mychef-client
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

node.default['chef-client']['interval'] = '300'
node.default['chef-client']['splay'] = '60'

include_recipe 'chef-client::default'