name "load-balancer"
description "This is a role for load balancer myhaproxy cookbook"
run_list "recipe[mychef-client]","recipe[myhaproxy]"