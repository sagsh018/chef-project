package "ntp" do
    action :install
end

package "tree" do
    action :install
end

file "/etc/motd" do
    action :create
    content "This server is property of Sagar"
    owner 'root'
    group 'root'
end
