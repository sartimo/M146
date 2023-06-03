# M146
Vagrantfiles for provisioning our OPNsense Infrastructure for M146 at BBZW Sursee

## Overview

### LAN (192.168.200.0 /24)

- VBox Internal Network
- Firewall and Ubuntu Client (LANWS) are connected
- Firewall is the DHCP server and default gateway in this network
- LANWS is the DHCP client

## DMZ (192.168.100.0 /24)

- VBox Internal Network
- Firewall and Ubuntu Server (DMZSRV) are connected
- Firewall is DHCP Server and default gateway in this network
- DMZSRC is the DHCP client

## WAN (10.0.4.15 /24)

- Only Firewall is connected to this network

## DHCP Konfiguration for LAN

DHCP LAN: https://github.com/0xtimosarkar/M146/blob/776bb1a502dcf7c5edf8317887286c450b0b9cae/config/config.xml#L350-L383

## DHCP Konfiguration for DMZ

Definition opt1 = DMZ: https://github.com/0xtimosarkar/M146/blob/776bb1a502dcf7c5edf8317887286c450b0b9cae/config/config.xml#L314-L322
OPT1 DMZ: https://github.com/0xtimosarkar/M146/blob/776bb1a502dcf7c5edf8317887286c450b0b9cae/config/config.xml#L367-L382

## Machine Overview

- **OPNsense Firewall**: DHCP Server and Default Gateway for ```LAN``` and ```DMZ```
- **LANWS**: Ubuntu Terminal Client for Testing Purposes
- **DMZSRV**: Ubuntu Server with NGINX/Apache Web Server for zone routing purposes


### Testing on Windows 11 22H2 virtualbox (works)

1. Download virtualbox latest: https://download.virtualbox.org/virtualbox/7.0.8/VirtualBox-7.0.8-156879-Win.exe
2. Download vagrant latest: https://releases.hashicorp.com/vagrant/2.3.6/vagrant_2.3.6_windows_amd64.msi

#### Pre-Requesities

```bash
setx /m VBOX_INSTALL_PATH "C:\Program Files \Oracle\Virtualbox"
refreshenv
git clone https://github.com/mcree/vagrant-opnsense.git
cd vagrant-opnsense
cd test
```

#### (In main Terminal) boot firewall

Username: vagrant

Password: opnsense

```bash
vagrant up fw --provider virtualbox
```

3. Login to the Firewall. User: root, PW: opnsense. You may also connect to the Web Dashboard which is bridged on 127.0.0.1:10443


#### (In a new terminal) Boot LAN Workstation

Username: vagrant

Password: vagrant

```bash
vagrant up lanws --provider virtualbox
```


#### (In a new terminal) Boot DMZ Server

Username: vagrant

Password: vagrant

```bash
vagrant up dmzsrv
```

