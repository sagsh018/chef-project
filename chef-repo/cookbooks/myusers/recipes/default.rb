#
# Cookbook:: myusers
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

=begin
Note that we are commenting this portion of the recipe, because we don't want to create the users and the groups
on node by using chef resources such as user and group, rather we would like to make use of data stored inside 
data bag to create users and groups on node.
user 'user1' do
    comment
    uid
    gid '1'
    home
    shell
    action: create
end

group 'group1' do
    members 'user1'
end
=end

search("users", "platform:centos").each do |user_data|
    user user_data['id'] do
        comment user_data['comment']
        uid user_data['uid']
        gid user_data['gid']
        home user_data['home']
        shell user_data['shell']
    end
end

search("groups", "platform:centos").each do |group_data|
    group group_data["id"] do
        gid group_data["gid"]
        members group_data["members"]
    end
end