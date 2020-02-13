#!/bin/bash

iptables -I FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -I FORWARD -s 10.8.0.0/24 -m conntrack --ctstate NEW -j ACCEPT
iptables -t nat -I POSTROUTING -s 10.8.0.0/24 -j MASQUERADE
iptables -I FORWARD -s 10.8.0.0/24 -d 192.168.10.0/24 -m conntrack --ctstate NEW -j ACCEPT
iptables -I FORWARD -s 10.8.0.0/24 -d {{ openstack_public_cidr.split("/")[0] }}/24 -m conntrack --ctstate NEW -j ACCEPT
iptables -I FORWARD -s 192.168.10.0/24 -m conntrack --ctstate NEW -j ACCEPT
iptables -I FORWARD -s {{ openstack_public_cidr.split("/")[0] }}/24 -m conntrack --ctstate NEW -j ACCEPT
iptables -t nat -I POSTROUTING -s 192.168.10.0/24 -j MASQUERADE
iptables -t nat -I POSTROUTING -s {{ openstack_public_cidr.split("/")[0] }}/24 -j MASQUERADE

# iptables -P INPUT ACCEPT
# iptables -P FORWARD ACCEPT
# iptables -P OUTPUT ACCEPT
# iptables -t nat -F
# iptables -t mangle -F
# iptables -F
# iptables -X

# iptables -I FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
# iptables -I FORWARD -s 10.8.0.0/24 -m conntrack --ctstate NEW -j ACCEPT
# iptables -t nat -I POSTROUTING -s 10.8.0.0/24 -j MASQUERADE

# iptables -I FORWARD -s 10.8.0.0/24 -d 10.220.218.0/24 -m conntrack --ctstate NEW -j ACCEPT
# iptables -I FORWARD -s 10.8.0.0/24 -d 10.220.217.0/24 -m conntrack --ctstate NEW -j ACCEPT
# iptables -I FORWARD -s 10.8.0.0/24 -d 10.220.216.0/24 -m conntrack --ctstate NEW -j ACCEPT
# iptables -I FORWARD -s 10.220.218.0/24 -m conntrack --ctstate NEW -j ACCEPT
# iptables -I FORWARD -s 10.220.217.0/24 -m conntrack --ctstate NEW -j ACCEPT
# iptables -I FORWARD -s 10.220.216.0/24 -m conntrack --ctstate NEW -j ACCEPT
# iptables -t nat -I POSTROUTING -s 10.220.218.0/24 -j MASQUERADE
# iptables -t nat -I POSTROUTING -s 10.220.217.0/24 -j MASQUERADE
# iptables -t nat -I POSTROUTING -s 10.220.216.0/24 -j MASQUERADE

