# M146
Vagrantfiles for provisioning our OPNsense Infrastructure for M146 at BBZW Sursee

## Overview

- [x] Anforderungen GL:
    - [ ] Load Balancing
    - [x] Web Server in DMZ: erreichbar aus LAN und WAN
    - [x] Kein Zugriff von WAN in DMZ außer Web Server
- [ ] Anforderungen Firewall LAB:
    - [x] Drei Interfaces erstellt: LAN, WAN, DMZ
    - [ ] In jedem Netz ein Host
    - [x] Verbindung Hosts zu Firewall funktioniert
    - [x] Verbindung Firewall zu Internet funktioniert
    - [x] IP-Addressierung sinnvoll und korrekt
    - [x] Internet von LAN und DMZ aus
    - [x] Keine Verbindung von WAN ins LAN
    - [x] LAN Verbindung nur zu Webserver und sonst nichts
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


# Setup


1. Download virtualbox latest: https://download.virtualbox.org/virtualbox/7.0.8/VirtualBox-7.0.8-156879-Win.exe
2. Download vagrant latest: https://releases.hashicorp.com/vagrant/2.3.6/vagrant_2.3.6_windows_amd64.msi

#### Pre-Requesities

Remember: run using hotspot since WAN access is bridged and traffic may be blocked by the host network of WAN.

```bash
setx /m VBOX_INSTALL_PATH "C:\Program Files \Oracle\Virtualbox"
refreshenv
git clone https://github.com/0xtimosarkar/M146
cd M146
vagrant up fw lanws dmzsrv --provider virtualbox
```
1. This will boot firewall, upgrade it to v20.7
2. Then start lanws 
3. Then start dmzsrv, boot the nginx server

> After this: go to services/web proxy/acl. Then download acls and select the category social_media for testing purposes. Then click download & apply. 
> It is important to do this using hotspot.


- Webpanel for Firewall is located at: https://127.0.0.1:10443 at the host machine. Login is: root & opnsense
- Login for other machines are: vagrant & vagrant
- To visually test webfilter: prepare a windows vm, put it into the internal vbox network LAN and install opnsense-ca.crt under trusted roots. Then access 
