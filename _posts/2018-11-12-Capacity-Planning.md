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
