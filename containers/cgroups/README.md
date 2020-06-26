# Control Groups (cgroups)

## View cgroups

```bash
$ ls /sys/fs/cgroup
blkio
cpu -> cpu,cpuacct
cpuacct -> cpu,cpuacct
cpu,cpuacct
cpuset
devices
freezer
memory
net_cls -> net_cls,net_prio
net_cls,net_prio
net_prio -> net_cls,net_prio
perf_event
pids
rdma
systemd
unified
```

## Manually create a cgroup

## References

- [Everything You Need to Know about Linux Containers, Part I: Linux Control Groups and Process Isolation](https://www.linuxjournal.com/content/everything-you-need-know-about-linux-containers-part-i-linux-control-groups-and-process)