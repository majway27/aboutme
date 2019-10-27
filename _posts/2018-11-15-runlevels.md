---
layout: post
current: post
cover: 'assets/images/bldg1.png'
navigation: true
title: NIX Startup
date: 2018-11-15 10:18:00
categories: [techblog]
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
##### Debian
- `update-rc.d`
- `update-rc.d apache2 start 10 2 3 4 5 . stop 90 0 1 6 .`
- Apache2 will be started (as long as it isn’t already) 
  - When the system enters RunLevel 2, 3, 4 or 5 with a priority of 10. 
- It will then be asked to stop when the system enters RunLevel 0, 1 or 6 with a priority of 90.

##### Redhat
Chkconfig SSHD example.  chkconfig 2345 55 25.  
- Start in RL 2345.
- If it wasn't in 2, you edit file, add 2 to commented chkconfig, and then chkconfig --add sshd
- `chkconfig --list` is a nice table view across RLs
- `chkconfig --off` - turn off across all RLs
- `chkconfig --level 3 on` - Now only turn on for RL 3.

#### Changing Runlevel

**runlevel** command
````bash
rmay@dev-vm:~/$ runlevel
N 5
````
**init** command
`init 6` would reboot system
Pretty basic, not alot of flexibility

**telinit**
Use to pass a time (like do this in 2 minutes).  Could be used with a broadcast message to all users.

#### Systemd
Systemd is an init system similar to sysvinit, but with improvements.
- While sysvinit is sequential, based on rules.
  - Systemd can start in parallel, define dependencies, start services automatically. 
- SVI uses startup scripts, systemd uses unit files.
  - Unit files contain minimum unit name and service desc.  Most also contain install section.
    - Tells when to stop/start service.
  - Unit files can also manage sockets, devices, mounts, swap devices and timers, among other things.

**Targets**
Is a unit that provides a syncronization point for other units when booting or changing states.
- Can be used to bring the system to another desired state.
- Example - SVI, gui is RL5.  For sysd, multi-user.target.
Create target
- `/etc/systemd/customTarget.wants/ symlink in the services you desire from /lib/systemd/system`

### 202.2 System Recovery
#### Knowledge Targets
- Manipulate a Linux system during both the boot process and during recovery mode
  - Both the init utility and init-related kernel options 
- Determine the cause of errors in loading and usage of bootloaders.

#### Understanding the boot process
4 Phases
- BIOS/UEFI (unified extensible firmware interface)
  - UEFI is software for BIOS.  Not considered firmware like BIOS.
  - UEFI can handle modern disk technology (GUIDs, LVM, etc)
- Boot Loader
  - Once complete, hands off to approriate kernel
  - Presents us with option to choose a kernel, boot options
  - Grub/Grub2, Grub was a replacement for LILO
  - BL is stored in MBR.  First 215 bytes of any disk
- Kernel
  - Sets up things, hands off to post-kernel
    - init process, sysvinit/systemd/etc time.

#### Grub2
Improvement on GRUB
- G could not used uuids
- G2 can boot encrypted devices
- Small diff btwn RH and Debian
- Config dir
  - `/boot/grub2` - Kernel info
  - grub.cfg - we won't change this.  Is a menu builder.
- `/etc/default/grub` - where you edit and set behaviors
  - timeout, cmdline_linux (options)
- `/etc/grub.d/` - see files referenced/included from grub.cfg
  - grub.cfg is built by Makefile, it concats these files.
- Change 40_custom file and rebuild via `grub2-mkconfig -o newgrub.conf` (don't clobber old file)
  - Backup original in `/boot/` and drop in new one, renamed.
  - Reboot

#### fsck
Check and repair NIX file system
- Can't run on mounted FS

#### Systemd rescue and emergency recovery
Single user mode
- **rescue** - Lauches a shell shortly after the root filesytem is mounted read/write
- **emergency** - Launches a shell before most filesytems are mounted
- **last resort** - If systemd is broken, it is possible to launch a root shell using init (init=/bin/sh)
- **debug shell** - Have systemd launch a root shell on tty9 on boot.

#### System Recovery, BIOS and UEFI
BIOS looks for the MBR on the first sector of the HD in order to physically locate the computers kernel.
- Size limit of first sector
UEFI looks at a special disk partition, the EFI system partition (ESP) to store bootloader programs.
- This enables us to use large bootloaders or multiple OSs (ie windows/linux dual boot)
NVMe - non-volitile memory express
- Supported since linux kernel 3.3
- Allows linux to use SSDs as boot drive

### 202.3 Alternate Bootloaders
List
- LILO
- Syslinux
- EXTLinux
- ISOLinux 
- PXELinux

