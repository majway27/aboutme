---
layout: post
current: post
cover: 'assets/images/internals.png'
navigation: True
title: Capacity Planning
date: 2018-11-12 10:18:00
tags: linux, administration, lpic
class: post-template
subclass: 'post tag-linux'
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
##### UPTIME (better than updog)
>The iostat command is used for monitoring system input/output device loading by observing the time the devices 
are active in relation to their average transfer rates. The iostat command generates reports that can be used to 
change system configuration to better balance the input/output load between physical disks. -man

```bash
rmay@dev-vm:~/Projects/dojo$ uptime
 10:00:40 up  7:15,  1 user,  load average: 1.21, 0.58, 0.37
```

- Compare against `date`
- uptime relies on /var/run/utmp, a binary file.  Can be cat'd.

#### CPU and Disk IO
##### IOSTAT
>The iostat command is used for monitoring system input/output device loading by observing the time the devices 
are active in relation to their average transfer rates. The iostat command generates reports that can be used to 
change system configuration to better balance the input/output load between physical disks. -man

````bash
rmay@dev-vm:~/Projects/dojo$ iostat 
Linux 4.15.0-43-generic (dev-vm)        12/24/2018      _x86_64_        (1 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           3.21    0.06    2.27    0.10    0.00   94.36

Device             tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
````

CPU, (No disk), `iostat -c`.

```bash
rmay@dev-vm:~/Projects/dojo$ iostat -c
Linux 4.15.0-43-generic (dev-vm)        12/24/2018      _x86_64_        (1 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           3.27    0.06    2.31    0.10    0.00   94.26

```

Notes:
  - Machine has 1 cpu, 64bit cpu, on v4 kernel
  - rmay user is using average (see 'avg-cpu') of 3.27% of cpu time
  - nice = background, low priority processes
  - system using 2%
  - iowait, how much disk is waiting on cpu, less than 1% is good.

Do I have a system problem?
- `iostat` -c 2 5 (every 2 sec, 5 readings)
- Watch activity in a separate term window while you test stuff

Disk, Command `iostat -d`

Look at /dev/sda, local disk

```bash
rmay@dev-vm:~/Projects/dojo$ iostat | grep sda
sda               2.19        28.06        34.63    1622701    2002476
rmay@dev-vm:~/Projects/dojo$ iostat | grep sda
sda               2.19        28.05        34.62    1622701    2002524
rmay@dev-vm:~/Projects/dojo$ iostat | grep sda
sda               2.19        28.05        34.62    1622701    2002524
```

This is cool - look at device and its partitions
```bash
rmay@dev-vm:~/Projects/dojo$ iostat -d -p sda
Linux 4.15.0-43-generic (dev-vm)        12/24/2018      _x86_64_        (1 CPU)

Device             tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sda               2.20        27.37        36.03    1625385    2140008
sda1              2.19        27.24        36.03    1617605    2140008

```

#### Easily Record CPU and Disk IO
##### SAR
> sar - Collect, report, or save system activity information. -man

Let's go sar, CPU
```bash
rmay@dev-vm:~/Projects/dojo$ sar
Cannot open /var/log/sysstat/sa24: No such file or directory
Please check if data collecting is enabled
```
fix - flip enabled to true in /etc/default/sysstat (debian)
```bash
rmay@dev-vm:~/Projects/dojo$ sar 1 3
Linux 4.15.0-43-generic (dev-vm)        12/24/2018      _x86_64_        (4 CPU)

08:48:19 AM     CPU     %user     %nice   %system   %iowait    %steal     %idle
08:48:20 AM     all      1.02      0.00      0.25      0.00      0.00     98.73
08:48:21 AM     all      1.27      0.00      0.51      0.00      0.00     98.23
08:48:22 AM     all      0.76      0.00      0.76      0.00      0.00     98.48
Average:        all      1.01      0.00      0.51      0.00      0.00     98.48
```

Can be set to auto collect metrics, then simply running `sar` will return recorded history.
Set in `/etc/cron.d/sysstat`

Sar for Disk/Devices `sar -d`
```bash
rmay@dev-vm:~/Projects/dojo$ sar -d 1
Linux 4.15.0-43-generic (dev-vm)        12/24/2018      _x86_64_        (4 CPU)

08:55:49 AM       DEV       tps     rkB/s     wkB/s   areq-sz    aqu-sz     await     svctm     %util
...rage:       dev7-4      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
Average:       dev7-5      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
Average:       dev7-6      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
Average:       dev7-7      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
Average:       dev8-0      2.24     26.50     36.49     28.16      0.00      1.23      0.49      0.11
Average:       dev7-8      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
Average:       dev7-9      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
Average:      dev7-10      0.00..
```
- Devices are listed.  Example - Correlate via:

```bash
rmay@dev-vm:~/Projects/dojo$ ls -l /dev | grep "8, *"
crw-------  1 root    root    108,   0 Dec 24 08:39 ppp
brw-rw----  1 root    disk      8,   0 Dec 24 08:39 sda

rmay@dev-vm:~/Projects/dojo$ df -h | grep sda*
/dev/sda1        49G  9.5G   38G  21% /
```

- tps is transfers per second
- rkB/s reads per sec, wkB/s writes per sec
- areq-sz average size in sectors, per request
- aqu-sz average length of queue size, per request.  For example if we had a system under heavy load, we'd have higher average queue numbers.
- **await** _average wait (ms) to serve disk requests_
- **svctm** _average time the device has taken to service the request, and the average time for the request_

#### Memory Utilities
##### FREE (memory free)
> Display amount of free and used memory in the system

```bash
rmay@dev-vm:~/Projects/dojo$ free -h
              total        used        free      shared  buff/cache   available
Mem:           7.8G        1.4G        5.3G         33M        1.1G        6.1G
Swap:          2.0G          0B        2.0G
```

- System tries to be efficient with resources
  - Example: In the above, buffering/caching mechamism (performance) are using 1.1g/1.4g.
- Note: we shouldn't be in swap, and aren't above.

##### VMSTAT
> Report virtual memory statistics

- Why vmstat?  Sometimes we want more detail about memory usage.

```bash
rmay@dev-vm:~/Projects/dojo$ vmstat 3 -t
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu----- -----timestamp-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st                 MST
 3  0      0 5574252  90444 1028512    0    0    53    14  576  943  4  1 95  0  0 2018-12-24 09:52:43
 0  0      0 5573376  90452 1028512    0    0     0     8 2053 3409  1  1 98  0  0 2018-12-24 09:52:46
 0  0      0 5574244  90452 1028512    0    0     0    13 1498 2571  1  0 99  0  0 2018-12-24 09:52:49
```

Summary view
```bash
rmay@dev-vm:~/Projects/dojo$ vmstat -s
      8167936 K total memory
      1481796 K used memory
      1718916 K active memory
       714532 K inactive memory
      5565868 K free memory
...
```

#### Disk and file usage
##### LSOF
> list open files -man

- Why lsof?  If you had a busy disk based on above diagnostic tool output, lsof could tell you what files 
are open on that mount, you could then tie that to a process/app, and go from there.

````bash
rmay@dev-vm:~/Projects/dojo$ lsof -u rmay | wc -l && lsof -u rmay | head -10
5624
COMMAND     PID USER   FD      TYPE             DEVICE SIZE/OFF       NODE NAME
systemd     936 rmay  cwd       DIR                8,1     4096          2 /
systemd     936 rmay  rtd       DIR                8,1     4096          2 /
systemd     936 rmay  txt       REG                8,1  1595792     273581 /lib/systemd/systemd
systemd     936 rmay  mem       REG                8,1  1700792     267778 /lib/x86_64-linux-gnu/libm-2.27.so
systemd     936 rmay  mem       REG                8,1   121016     267667 /lib/x86_64-linux-gnu/libudev.so.1.6.9
systemd     936 rmay  mem       REG                8,1    84032     267756 /lib/x86_64-linux-gnu/libgpg-error.so.0.22.0
systemd     936 rmay  mem       REG                8,1    43304     267767 /lib/x86_64-linux-gnu/libjson-c.so.3.0.1
systemd     936 rmay  mem       REG                8,1    34872    3155204 /usr/lib/x86_64-linux-gnu/libargon2.so.0
systemd     936 rmay  mem       REG                8,1   432640     267737 /lib/x86_64-linux-gnu/libdevmapper.so.1.02.1
````
- Note: Does the device 8,1 look familiar?
- Also important - see PID value, we can tie that to top, etc, and see open files for a troublesome process.NET

##### IOTOP
> simple top-like I/O monitor

usage:

```bash
Total DISK READ :       0.00 B/s | Total DISK WRITE :       0.00 B/s
Actual DISK READ:       0.00 B/s | Actual DISK WRITE:       0.00 B/s
  TID  PRIO  USER     DISK READ  DISK WRITE  SWAPIN     IO>    COMMAND  
 5214 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.09 % [kworker/u8:2]
    1 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % init splash
    2 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [kthreadd]
    4 be/0 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [kworker/0:0H]
    6 be/0 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [mm_percpu_wq]
    7 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [ksoftirqd/0]
    8 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [rcu_sched]

```

Headers:
- TID: Thread ID
- PRIO: Idle, best-effort, or real-time
- DISK READ/DISK WRITE: amount of data being transferred
- SWAPIN: disk swap amount
- IO: Percentage of time the process is blocking on input/output
- COMMAND: process name associated with Thread ID

##### HTOP
> interactive process viewer

Kind of like `top` with an `-h` flag :)
Usage example
```bash
  1  [||||||||||||||||||||||||                                                   19.2%]   Tasks: 113, 310 thr; 3 running
  2  [|||||||||||||||||||||||||                                                    20.2%]   Load average: 1.20 0.89 0.62
  3  [||||||||||||||||||||||||||                                                               20.7%]   Uptime: 05:55:57
  4  [||||||||||||||||||||||||                                                                                    19.6%]
  Mem[||||||||||||||||||||||||||||||||||||||||||||||||||||||                                                2.27G/7.79G]
  Swp[                                                                                                         0K/2.00G]

  PID USER      PRI  NI  VIRT   RES   SHR S CPU% MEM%   TIME+  Command
F1Help  F2Setup F3SearchF4FilterF5Tree  F6SortByF7Nice -F8Nice +F9Kill  F10Quit

```

Notes

#### Process Deep Inspection
##### PS
> report a snapshot of the current processes -man

- Why pstree?  The visual representation is a big timesaver over scrolling back and forth through ps output 
when tracing a process of interest.
```bash
rmay@dev-vm:~/Projects/dojo$ ps -ef | grep myApp
myAppUser       250     1  0 Dec2 ?        00:00:00 /opt/myApp/bin/startApp.sh
```

##### PSTREE
> display a tree of processes

````bash
rmay@dev-vm:~/Projects/dojo$ pstree -h -p | head -10
systemd(1)-+-ModemManager(635)-+-{ModemManager}(701)
           |                   `-{ModemManager}(723)
           |-NetworkManager(725)-+-{NetworkManager}(776)
           |                     `-{NetworkManager}(778)
           |-VBoxClient(1078)---VBoxClient(1080)---{VBoxClient}(1114)
           |-VBoxClient(1088)---VBoxClient(1089)
           |-VBoxClient(1095)---VBoxClient(1096)---{VBoxClient}(1098)
           |-VBoxClient(1101)---VBoxClient(1102)-+-{VBoxClient}(1104)
           |                                     `-{VBoxClient}(1105)
           |-VBoxService(845)-+-{VBoxService}(847)

````
- -Z for selinux context info (if enabled)
- -a for passed in params to process start

##### top
> display Linux processes

- Why top?  Interactive! auto-refreshed!

#### Network and Bandwidth
##### NETSTAT
> Print network connections, routing tables, interface statistics, masquerade connections, and multicast memberships

Netstat is a big command.  We will focus on some common switches.
- Displaying network connections
- Routing tables
- And related stats

Routing - Display my routing table
```bash
rmay@dev-vm:~/$ netstat -r
Kernel IP routing table
Destination     Gateway         Genmask         Flags   MSS Window  irtt Iface
default         _gateway        0.0.0.0         UG        0 0          0 enp0s3
link-local      0.0.0.0         255.255.0.0     U         0 0          0 enp0s3
192.168.1.0     0.0.0.0         255.255.255.0   U         0 0          0 enp0s3
```
Would also reflect static routes.

Summary of connections by protocol
```bash
rmay@dev-vm:~/Projects/aboutme$ netstat -s
Ip:
    Forwarding: 2
    31771 total packets received
    0 forwarded
    0 incoming packets discarded
    31769 incoming packets delivered
    11861 requests sent out
Icmp:
    0 ICMP messages received
...
    ICMP output histogram:
Tcp:
    124 active connection openings
...
    31 resets sent
Udp:
    4086 packets received
...
```

- `-lt` for just tcp
- `-c` for continuous

##### SS
> another utility to investigate sockets (glowing review)

- Netstat has been deprecated.  SS is the new hotness.
- Has most of what netstat has, looks a bit different.

##### IPTRAF
> Interactive Colorful IP LAN Monitor

- May need to run `sudo iptraf-ng`
- Pretty cool tool
- Wireshark-ish, must run as root
- See adapter stats, query by attributes like traffic proto, etc.

#### User Activity
##### W
> Show who is logged on and what they are doing.

### 200.2 Predict Future Resource Needs
#### Colllect Stats
##### COLLECTD
Install collectd
Plugins, config files in /etc
/usr/share/collectd - types.db, 2 field spec.  item and way to get it.
/var/lib/collectd/rrd/<hostname> - location of rrd file that holds metrics data
Other options:
- Nagios
- MRTG
- Cacti
- Ichinga -- GUI improvement and restapi, fork of nagios





