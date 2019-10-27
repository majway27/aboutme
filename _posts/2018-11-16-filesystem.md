---
layout: post
current: post
cover: 'assets/images/neon1.png'
navigation: true
title: NIX Filesystems
date: 2018-11-16 10:18:00
categories: [techblog]
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
Updated everytime something is mount/unmounted

#### Manual mount/unmount
Howto
mount/umount, -f to force
fuser command tells processes using
`fuser ~/Downloads/Projects $ fuser /Users/rmay
/Users/rmay: 487 518 647 654 823 1180c 7277c 7279c 23964c 24048`
Options to mount
RO - remount, ro

#### Auto mount with /etc/fstab
Mounting in fstab requires a unique id
- old - lable
- new - uuid, will nver change, known when device is first detected by system
Mount options
- options
  - nodev - no device files on fs
  - noexec - no exec files allowed on fs (ie security on fs)
  - suid - protect perms from changing
  - auto (defaults)
  - nouser - require root to mount
    - can specify user
    - anyone - "users"
Sync
- Some memory is reserved for buffers/cache
- Used to flush filesystem buffers.  In old days you'd do this before shutdown.
- Everything is fast enough now.  Also journaled FS can recover.

#### Swap Space
Swapon/swapoff utilities
- Man - Enable disable files for swapping
- `swapon -s` - list all active swap
- `swapon -a` - turns off all swap

#### Systemd mount and automount units
Systemd generates .mount unit files based on systems `/etc/fstab`, although they can be generated manually.
- Each mount file is named based on the mount point it controls, ie `/mnt/data` must be mnt-data.mount.
- Mandatory: 
  - (what) - absolute path of device, file, or other resource to mount.
  - (where) - absolute path of a directory for the mount point
  - (type) - FS type 


### 203.2 Maintaining Linux Filesystem
#### FS types
Major types, benefits, and creation.  FDISK to manage/partition.  MKFS to format.

**EXT (2-4)**
- ext4.  1 exabyte
XFS
- Non-journaled, high performance.  Supports file sizes up to 8 exab.
- File system size up to 16 eb
- Good for lots of tiny files, constantly being updated.
- Heavy load

**Change and View EXT3**
- `dumpe2fs -h` - dump fs info, only superblock info.
- Tells us things, like inode count (max files supported), journaled or not, etc.
- `tune2fs` - Used to change fs options.  Example, you could change reserved blocks percent for superuser.
- `debugfs` - A cli, you can execute commands 
  - You can unmount a fs, use debugfs on it.  You can look at detailed stats of a file (ACL, c/a/mtime, links, mode, etc)

#### Smart/SMARTD
Self-Monitoring, Analysis, and Reporting Technology
- Built into many ATA, IDE, and SCSI-3 HDs
- Designed to monitor the reliability of the drive
- Attempts to predict failures
- Runs self-tests
SMARTD
- Daemon that interacts with the smart functionality on drives
- Configurable timing on queries 30m
- Errors logged to syslog
- Check drive capability - `smartctl -i /dev/sda`

#### ZFS and BTRFS
Zettabyte File System
- Designed and implemented by Sun
- Not LVM, has lots of features (raid, etc)
BTRFS
- balance - Reallocates and balances data across the fs
- convert - Converts from EXT to BTRFS and back
- btrfstune - tune and on/off features
- others

### 203.3 Creating and configuring linux Filesystem options
#### Creating Swap Files and Partitions

#### Loopback and mkiofs
Man - The loop device is a block device that maps its data blocks not to a physical device such as a hard disk or optical disk drive, but to the blocks of a regular file in a filesystem or to another block device. 
- This can be useful for example to provide a block device for a filesystem image stored in a file, so that it can be mounted with the mount command.
- `mount -o loop blah.iso /media/mycd`

#### LUKS
Linux Unified Key Setup
- Use it to access encrypted drives
- `yum install cryptsetup`
- `cryptsetup luksformat /dev/myvol/secret`
- Warns about overwriting, requires a passphrase-key.  Don't lose this key!  String value unencrypts.
 