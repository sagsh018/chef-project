# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "chefserver" do |chefserver|
    chefserver.vm.box = "bento/centos-7.2"
    chefserver.vm.network "private_network", ip: "192.168.10.21"
    chefserver.vm.hostname = "chefserver"
    chefserver.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "4096"]
      vb.customize ["modifyvm", :id, "--cpus", "2"]
      end
    chefserver.vm.provision "shell", inline: <<-SHELL
      sudo echo "192.168.10.22 workstation" | sudo tee -a /etc/hosts
      sudo echo "192.168.10.23 node" | sudo tee -a /etc/hosts
      sudo systemctl enable firewalld
      sudo systemctl start firewalld
      sudo firewall-cmd --permanent --zone=public --add-port=8140/tcp 
      sudo yum -y install ntp
      sudo timedatectl set-timezone America/New_York
      sudo systemctl start ntpd
      sudo firewall-cmd --add-service=ntp --permanent
      sudo firewall-cmd --reload         
    SHELL
  end

  config.vm.define "workstation" do |workstation|
    workstation.vm.box = "bento/centos-7.2"
    workstation.vm.network "private_network", ip: "192.168.10.22"
    workstation.vm.hostname = "workstation"
    workstation.vm.provision "shell", inline: <<-SHELL
       sudo echo "192.168.10.21 chefserver" | sudo tee -a /etc/hosts
       sudo timedatectl set-timezone America/New_York
    SHELL
    end

    config.vm.define "node" do |node|
      node.vm.box = "bento/centos-7.2"
      node.vm.network "private_network", ip: "192.168.10.23"
      node.vm.hostname = "node"
      node.vm.provision "shell", inline: <<-SHELL
       sudo echo "192.168.10.21 chefserver" | sudo tee -a /etc/hosts
       sudo timedatectl set-timezone America/New_York
    SHELL
  end
end
