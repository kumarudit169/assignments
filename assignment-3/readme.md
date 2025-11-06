# Linux High Load Troubleshooting

This guide outlines steps to identify the source of high load average on a Linux server.

## Commands to Use

### Check Load & CPU

```
uptime
top -o %CPU
mpstat -P ALL 1 5
```

### Check I/O

```
iotop -o
iostat -xz 1
```

### Check Memory & Swap

```
free -m
vmstat 1 5
```

### Check Processes

```
ps aux | grep -w D
ps aux | grep -w Z
```

### Disk & Inodes

```
df -h
df -i
```

### Logs

```
dmesg | tail
journalctl -xe
```

## What to Look For

* High CPU usage
* High I/O wait
* Swapping
* Stuck I/O tasks (D state)
* Full disk/inodes
* Kernel/OOM errors

## Goal

Find whether load is from CPU, I/O, memory, or blocked processes and take action accordingly.
