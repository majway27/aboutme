---
layout: post
current: post
cover: assets/images/networking.png
navigation: True
title: NIX Networking
date: 2018-11-17 10:18:00
tags: linux
class: post-template
subclass: 'post tag-speeches'
author: rob
---

# Topics - Networks

> Networking is the act of connecting two or more computers so that they can communicate with each other. The actual methods of connecting and communicating are slightly complicated, but the end result is very useful. -tldp

Editor Note:
- The material below was cobbled together for personal use, from attributed sources, and endured some mild look/feel massage.
- Document Purpose: Conveniently scoped refresher on the listed Linux material.

Sources: 
- LPIC2 Prep - Linux Academy
- http://www.tldp.org/LDP/intro-linux/html/chap_10.html
- Photo source by The Roaming Platypus on Unsplash

## Nix Networking
### Knowledge Targets
- Configure a network device to be able to connect to a local, wired or wireless, and a wide-area network. 
- Communicate between various subnets within a single network including both IPv4 and IPv6 networks.

### 205.1 Linux Networking
#### Interfaces - ifconfig
Use to see general network configuration
- `ifconfig eth1 192.168.1.2` - set ip
- `ifconfig eth1 down` - down adapter
These configs are temporary.  Need a write to persist.
Promiscious mode.  Stop ignoring packets not targeted at its ip.  Debugging/troubleshooting.  ifconfig can on/off.

#### Routing - ARP
ARP table
- hostname, ip, route info (routers, switches, etc)
- When a packet flys by, arp will learn about it.
- If you ping and don't get a response, an incomplete arp entry will go in.

#### ip tool
ifconfig is deprecated, use `ip ..`
- arp = ip neigh
- ifconfig = ip addr
- route = ip route

#### iw
Configure wifi
- Do client stuff

### 205.2 Advanced Troubleshooting
netstat
- netstat gives alot of info.  `netstat -s` gives a summary
- `netstat -i` gives a handy col view by adapter, for all the traffic from summary
- `netstat -r` Kernel ip routing table
- `netstat -l` Just listening sockets

lsof
- list open files

nc
- handy for verifying network (firewall, middle issues, etc)

selinux
- can be a factor

### 205.3 Configuration
Debian and Redhat differences
- RH 
  - `/etc/sysconfig/network-scripts`
  - "ifcfg-eth1" example
```bash
DEVICE=eth1
IPADDR ...
NETMASK ..
BROADCAST ..
ONBOOT=yes
BOOTPROTO=none
```

