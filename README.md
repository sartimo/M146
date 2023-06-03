# M146
Vagrantfiles for provisioning our OPNsense Infrastructure for M146 at BBZW Sursee

### Testing on Windows 11 22H2 virtualbox

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

### Testing on Windows Hyper-V (seems to work)

1. Activate Hyper-V
2. 
```batch
pushd "%~dp0"
dir /b %SystemRoot%\servicing\Packages\*Hyper-V*.mum >hv-home.txt
for /f %%i in ('findstr /i . hv-home.txt 2^>nul') do dism /online /norestart /add-package:"%SystemRoot%\servicing\Packages\%%i"
del hv-home.txt
Dism /online /enable-feature /featurename:Microsoft-Hyper-V -All /LimitAccess /ALL
pause
```

```bash
git clone https://github.com/mcree/vagrant-opnsense.git
cd vagrant-opnsense
cd test
vagrant up --provider hyperv
```

### Firewall Policies for LAN, WAN and DMZ

https://github.com/mcree/vagrant-opnsense/blob/master/test/config.xml
