# M146
Vagrantfiles for provisioning our OPNsense Infrastructure for M146 at BBZW Sursee

## Overview

- [ ] Anforderungen GL:
    - [x] Load Balancing
    - [x] Web Server in DMZ: erreichbar aus LAN und WAN
    - [ ] Kein Zugriff von WAN in DMZ außer Web Server
- [ ] Anforderungen Firewall LAB:
    - [x] Drei Interfaces erstellt: LAN, WAN, DMZ
    - [x] In jedem Netz ein Host
    - [x] Verbindung Hosts zu Firewall funktioniert
    - [x] Verbindung Firewall zu Internet funktioniert
    - [x] IP-Addressierung sinnvoll und korrekt
    - [x] Internet von LAN und DMZ aus
    - [ ] Keine Verbindung von WAN ins LAN
    - [ ] LAN Verbindung nur zu Webserver und sonst nichts
    - [ ] Webfilter für gewisse Webseiten Kategorien
    - [x] Installation Webserver im DMZ
    - [x] Verbindung von DMZ zu LAN (open up DNS)

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
- **Website pointing to 192.168.100.100:80**

## WAN (10.0.4.15 /24)

- Only Firewall is connected to this network


## Machine Overview

- **OPNsense Firewall**: DHCP Server and Default Gateway for ```LAN``` and ```DMZ```
- **LANWS**: Ubuntu Terminal Client for Testing Purposes
- **DMZSRV**: Ubuntu Server with NGINX/Apache Web Server for zone routing purposes
- **WANWS**: Ubuntu Trusty64 Client connected to WAN for Testing Purposes


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

Username: root

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

