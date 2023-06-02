#!/bin/sh

# Configure LAN interface
ifconfig igb0 down
ifconfig igb0 inet 192.168.1.1/24 up

# Configure DMZ interface
ifconfig igb1 down
ifconfig igb1 inet 192.168.2.1/24 up

# Configure WAN interface
ifconfig igb2 down
ifconfig igb2 inet 192.168.3.1/24 up

# Enable IP forwarding
sysctl net.inet.ip.forwarding=1

# Add firewall rules for LAN, DMZ, and WAN
cat > /usr/local/etc/ipfw.rules <<EOF
# Allow LAN to DMZ
add allow ip from 192.168.1.0/24 to 192.168.2.0/24

# Allow LAN to WAN
add allow ip from 192.168.1.0/24 to 192.168.3.0/24

# Allow DMZ to WAN
add allow ip from 192.168.2.0/24 to 192.168.3.0/24

# Allow established connections
add check-state
EOF

# Apply firewall rules
/usr/local/etc/rc.d/ipfw restart

# Enable DHCP server for LAN
cat > /usr/local/etc/dhcpd.conf <<EOF
option domain-name-servers 8.8.8.8, 8.8.4.4;
default-lease-time 600;
max-lease-time 7200;

subnet 192.168.1.0 netmask 255.255.255.0 {
    range 192.168.1.100 192.168.1.200;
    option routers 192.168.1.1;
}
EOF

# Start DHCP server
/usr/local/etc/rc.d/dhcpd restart
