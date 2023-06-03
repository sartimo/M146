# M146
Vagrantfiles for provisioning our OPNsense Infrastructure for M146 at BBZW Sursee

### Testing on Windows 11 22H2 virtualbox (works)

1. Download virtualbox latest
2. Download vagrant latest

```bash
setx /m VBOX_INSTALL_PATH "C:\Program Files \Oracle\Virtualbox"
refreshenv
```

```bash
git clone https://github.com/mcree/vagrant-opnsense.git
cd vagrant-opnsense
cd test
vagrant up --provider virtualbox
```

3. Login to the Firewall. User: root, PW: opnsense. You may also connect to the Web Dashboard which is bridged on 127.0.0.1:10443
4. Boot the LAN Windows Client using: ```vagrant rdp lanws```. This will trigger the vagrant daemon to fetch the windows10 box. After this is done, you can RDP into the LANWS.
5. Boote the DMZ Server using: ```vagrant ssh dmzsrv```.
6. Testing 


### Firewall Policies for LAN, WAN and DMZ

https://github.com/mcree/vagrant-opnsense/blob/master/test/config.xml
