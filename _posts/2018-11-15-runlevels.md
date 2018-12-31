---
layout: post
current: post
cover: 'assets/images/bldg1.png'
navigation: true
title: NIX Startup
date: 2018-11-14 10:18:00
tags: linux, code
class: post-template
subclass: 'post tag-linux'
author: rob
---

# Topics - NIX Startup

> “The secret of getting ahead is getting started. The secret of getting started is breaking your complex overwhelming tasks into small manageable tasks, and starting on the first one.” ― Mark Twain

Editor Note:
- The material below was cobbled together for personal use, from attributed sources, and endured some mild look/feel massage.
- Document Purpose: Conveniently scoped refresher on the listed Linux material.

Sources: 
- LPIC2 Prep - Linux Academy
- Photo source by Tiago B on Unsplash

## System Startup
### Knowledge Targets
- Query and modify the behaviour of system services at various run levels. 
- Understand the init structure and boot process. 
- Interact with run levels.

### 202.1 Customizing a SysV-Init System Startup
#### LSB - Linux Standard Base Spec
Linux Foundation and Distro Maintainers
- An attempt at improving a standard experience in Linux, among fractured distros
- Version 5 was major version change, breaking.
- FHS - File Hierarchy Spec

#### SysVInit Boot Process
Big topic, Other approaches are becoming more popular - Systemd and Upstart
**Process starts with Init process.  At boot.**
- Used to start all other processes and services.
- `ps -aux | grep init` shows init, process id 1

**Run Levels**, Determine what state the system is booted to, what services are started as a result.
- There are some differences between Redhat variants and Debian variants.

##### Redhat and variants
- RL 0, stop system
- RL 1, single user mode.  Special - like windows safe mode.  Key services, Filesystem.
- 2, multi-user mode, but no networking and no gui.  You can login, but no remote access, etc.
- 3, multi-mode with network, no gui.  Network is generally available, as long as it is defined at RL3.
- 4, Not defined in RH.  LSB specifies this as not defined.
- 5, Standard one for a desktop.  Standard b/c is multi-user, network, and GUI.
- 6, Reboots the system.  Called when you do a reboot or `shutdown -r`

##### Debian and variants
Contrasted to RH
- 0-1 matches
- 2,3,4,5 are all multi-user mode, network, and GUI.
- 6 matches.

Note: From an LSB perspective, there is RL 7-9.  Most distros don't define these by default.

**Important Ones**
- 1 - Troubleshooting
- 3 - Server run level
- 5 - Desktop mode

For sysv systems, what determines the default RL is `/etc/initab`
- Sets default
- Allows for writing hooks around a run level.  Like do this blah thing at RL x.

##### Redhat
Specific config
`/etc/rc.d`
- rc script
- rcX.d dirs
- rc.sysinit

##### Debian
They bring the rcX.d dirs up to `/etc` level.  Ie `/etc/rc0.d`

`echo runlevel` - might work
Inside an rcX.d dir
- S - Start scripts
- K - Kill script
- Number orders how scripts are ran
 

#### /etc/init.d and modifying runlevel script
Things that are specific to Debian or Redhat
- Debian is closer to LSB by implementation
- `/etc/init.d/script control-command`

**Modifying runlevels and services**
- `update-rc.d`
- `update-rc.d apache2 start 10 2 3 4 5 . stop 90 0 1 6 .`
- Apache2 will be started (as long as it isn’t already) 
  - When the system enters RunLevel 2, 3, 4 or 5 with a priority of 10. 
- It will then be asked to stop when the system enters RunLevel 0, 1 or 6 with a priority of 90.

