#!/bin/sh
IPT="/sbin/iptables"

# By default, drop everything except outgoing traffic
$IPT -P INPUT DROP
$IPT -P FORWARD DROP
$IPT -P OUTPUT ACCEPT


## General Rules
################

# Allow incoming and outgoing for loopback interfaces
$IPT -A INPUT -i lo -j ACCEPT
$IPT -A OUTPUT -o lo -j ACCEPT

# ICMP rule
$IPT -A INPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT

# Allow established connections:
$IPT -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT


## Consul Client Ports
######################

# Allow Consul LAN Serf on TCP and UDP Ports 8301
$IPT -A INPUT -p udp -m udp --dport 8301 -j ACCEPT
$IPT -A INPUT -p tcp -m tcp --dport 8301 -j ACCEPT


## MariaDB Rules
################

# Allow MySQL connections (TCP Port 3306)
$IPT -A INPUT -p tcp -m tcp --dport 3306 -j ACCEPT