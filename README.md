# M146
Vagrantfiles for provisioning our OPNsense Infrastructure for M146 at BBZW Sursee

### Testing on Windows

1. Download virtualbox 6:  https://download.virtualbox.org/virtualbox/6.0.24/VirtualBox-6.0.24-139119-Win.exe

```bash
git clone https://github.com/mcree/vagrant-opnsense.git
cd vagrant-opnsense
cd test
vagrant up --provider=hyperv
```
