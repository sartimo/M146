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

