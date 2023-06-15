# Multi machine Vagrant configuration
Vagrant.configure(2) do |config|

  config.winrm.timeout = 120
  config.winrm.retry_limit = 100

  # Firewall VM
  config.vm.define :fw do |fw|
    fw.vm.box = "mcree/opnsense"

    fw.vm.provider 'virtualbox' do |vb|
      vb.memory = 1024
      vb.cpus = 1
      vb.gui = true # want gui for testing
      #vb.customize ['modifyvm', :id, '--nic1', 'nat'] # don't touch this interface!

      # Setup firewall port assignments
      vb.customize ['modifyvm', :id, '--nic2', 'intnet']
      vb.customize ['modifyvm', :id, '--intnet2', 'LAN']
      vb.customize ['modifyvm', :id, '--nic3', 'nat']
      vb.customize ['modifyvm', :id, '--intnet3', 'WAN']
      vb.customize ['modifyvm', :id, '--nic4', 'intnet']
      vb.customize ['modifyvm', :id, '--intnet4', 'DMZ']
    end

    fw.vm.network :forwarded_port, guest: 22, host: 10022, id: "ssh", auto_correct: true

    fw.vm.provision "file", source: "./config.xml", destination: "/conf/config.xml" # copy default config to firewall
    fw.vm.provision "shell", inline: "opnsense-shell reload" # apply configuration
    #fw.vm.provision "shell", inline: "opnsense-update -r 20.7 -u -P"
    #fw.vm.provision "shell", inline: "opnsense-update"
  end

  # LAN Workstation VM
  config.vm.define :lanws do |lanws|
    lanws.vm.box = "ubuntu/trusty64"
    lanws.vm.provider 'virtualbox' do |vb|
      vb.memory = 4096
      vb.cpus = 2
      vb.gui = true
    end

    lanws.vm.boot_timeout = 1200

    # Network port assignment
    lanws.vm.network "private_network", type: "dhcp", virtualbox__intnet: "LAN"
    lanws.vm.network :forwarded_port, guest: 22, host: 10023, id: "ssh", auto_correct: true
    # lanws.vm.provision "shell", inline: "cp /vagrant/ubuntu-netplan.yaml /etc/netplan/90-disable-double-gw.yaml && netplan apply"
    
    # remove default gateway
    lanws.vm.provision "shell", inline: "ip route delete default"

    # add default gateway 192.168.200.1
    lanws.vm.provision "shell", inline: "ip route add default via 192.168.200.1 dev eth1"

  end

  # WAN Workstation VM
  # begin config.vm.define :wanws do |wanws|
  #   wanws.vm.box = "ubuntu/trusty64"
  #   wanws.vm.provider 'virtualbox' do |vb|
  #     vb.memory = 4096
  #     vb.cpus = 2
  #     vb.gui = true
  #   end

  #   wanws.vm.boot_timeout = 1200

    # Network port assignment
  #   wanws.vm.network "private_network", type: "dhcp", virtualbox__intnet: "WAN"
  #   wanws.vm.network :forwarded_port, guest: 22, host: 10023, id: "ssh", auto_correct: true
  #   # wanws.vm.provision "shell", inline: "cp /vagrant/ubuntu-netplan.yaml /etc/netplan/90-disable-double-gw.yaml && netplan apply"
    
  #   # remove default gateway
  #   wanws.vm.provision "shell", inline: "ip route delete default"

  #   # add default gateway 10.0.4.15
  #   wanws.vm.provision "shell", inline: "ip route add default via 10.0.4.15 dev eth1"
  # end 
  
  # DMZ Server VM
  config.vm.define :dmzsrv do |dmzsrv|
    dmzsrv.vm.box = "ubuntu/trusty64"
    dmzsrv.vm.provider 'virtualbox' do |vb|
      vb.memory = 1024
      vb.cpus = 1
      vb.gui = true
    end
    # Network port assignment
    dmzsrv.vm.network "private_network", type: "dhcp", virtualbox__intnet: "DMZ"

    dmzsrv.vm.network :forwarded_port, guest: 22, host: 10023, id: "ssh", auto_correct: true

    # Disable automatically acquired default gateway on Vagrant's default NAT interface
    # dmzsrv.vm.provision "shell", inline: "cp /vagrant/ubuntu-netplan.yaml /etc/netplan/90-disable-double-gw.yaml && netplan apply"
    
    # remove default gateway
    dmzsrv.vm.provision "shell", inline: "ip route delete default"

    # add default gateway 192.168.100.1
    dmzsrv.vm.provision "shell", inline: "ip route add default via 192.168.100.1 dev eth1"
    
    # boot an nginx server pointing to localhost -> 192.168.100.100:80
    dmzsrv.vm.provision "shell", inline: "sudo apt-get update && sudo apt-get install -y nginx && echo 'server {\n  listen 80;\n  root /var/www/html;\n  index index.html index.htm;\n\n  location / {\n    try_files $uri $uri/ =404;\n  }\n}' | sudo tee /etc/nginx/sites-available/default && sudo service nginx restart"
  end
end
