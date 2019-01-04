---
layout: post
current: post
cover: 'assets/images/neon1.png'
navigation: true
title: NIX Filesystems
date: 2018-11-16 10:18:00
tags: linux, code
class: post-template
subclass: 'post tag-linux'
author: rob
---

# Topics - NIX Filesystems

> “People have different styles: Some are filters and some are pilers.  The people who pile things often know exactly where things are, and they're often just as organized as people who file things” ― Daniel Levitin

Editor Note:
- The material below was cobbled together for personal use, from attributed sources, and endured some mild look/feel massage.
- Document Purpose: Conveniently scoped refresher on the listed Linux material.

Sources: 
- LPIC2 Prep - Linux Academy
- Photo source by Simon Zhu on Unsplash

## System Startup
### Knowledge Targets
- Properly configure and navigate the standard Linux filesystem, including configuring and mounting various filesystem types.

### 203.1 Operating Linux Filesystem
#### Displaying Filesystem Mounting Information
Mount cmd
List all mounts
/etc/mtab - what mount reads
Updated everytime somthing is mount/unmounted

#### Manual mount/unmount
Howto
mount/umount, -f to force
fuser command tells processes using
`fuser ~/Downloads/Projects $ fuser /Users/rmay
/Users/rmay: 487 518 647 654 823 1180c 7277c 7279c 23964c 24048`
Options to mount
RO - remount, ro

#### Auto mount with /etc/fstab
