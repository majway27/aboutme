---
layout: post
current: post
cover: 'assets/images/internals.png'
navigation: True
title: Capacity Planning
date: 2018-11-12 10:18:00
tags: linux, administration, lpic
class: post-template
subclass: 'post tag-fiction'
author: rob
---

# Topics - Capacity Planning

> "You can't remember the syntax for anything so you spend five hours reading man pages before giving up. You then shoot the computer. -How to shoot yourself in the foot (shell)"

Editor Note:
- The material below was cobbled together for personal use, from attributed sources, and endured some mild look/feel massage.
- Document Purpose: Conveniently scoped refresher on Linux Server Capacity Planning

Sources: 
- LPIC2 Prep - Linux Academy
- Photo by Annie Spratt on Unsplash

## Resource Usage
### Key System Bottlenecks
- CPU, 
- Memory
- Disk
- Network/Firewall

### Useful Diagnostic Commands
- IOSTAT, SAR: cpu/memory
- FREE, VMSTAT: memory
- IOSTAT, SAR, LSOF: disk i/o
- NETSTAT: network utilization/bandwidth
- PS, PSTREE, TOP - what is running on system and where
- W - who is logged in and current activity of user

### 200.1 Measure and Troubleshoot Resource Usage
#### System Availability and Uptime
`
rmay@dev-vm:~/Projects/dojo$ uptime
 10:00:40 up  7:15,  1 user,  load average: 1.21, 0.58, 0.37
`
- Use `date`
- uptime relies on /var/run/utmp, a binary file.  Can be cat'd.

