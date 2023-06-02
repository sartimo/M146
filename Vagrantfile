# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("3") do |config|
  # Configure OPNsense VM
  config.vm.define "opnsense" do |opnsense|
    opnsense.vm.box = "opnsense/opnsense"
    opnsense.vm.box_version = "21.7.3"
    opnsense.vm.network "private_network", ip: "192.168.1.1" # LAN network
    opnsense.vm.network "private_network", ip: "192.168.2.1" # DMZ network
    opnsense.vm.network "private_network", ip: "192.168.3.1" # WAN network
    opnsense.vm.provision "shell", inline: <<-SHELL
      # Any additional provisioning commands for OPNsense
    SHELL
  end

  # Configure client VM
  config.vm.define "client" do |client|
    client.vm.box = "ubuntu/bionic64"
    client.vm.network "private_network", ip: "192.168.1.2", virtualbox__intnet: "lan" # Connect to LAN network
    client.vm.provision "shell", inline: <<-SHELL
      # Any additional provisioning commands for the client machine
    SHELL
  end
  
  # Configure server VM
  config.vm.define "server" do |client|
    client.vm.box = "ubuntu/bionic64"
    client.vm.network "private_network", ip: "192.168.2.2", virtualbox__intnet: "dmz" # Connect to DMZ network
    client.vm.provision "shell", inline: <<-SHELL
      # Any additional provisioning commands for the client machine
    SHELL
  end
end
