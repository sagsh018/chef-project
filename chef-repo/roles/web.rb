name "web"
description "Web server role"
run_list "role[base]","recipe[workstation]","recipe[webserver]"
default_attributes "apache_test" => {
    "attribute1" => "Hello from attribute 1",
    "attribute2" => "you are great"
}