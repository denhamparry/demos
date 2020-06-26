# File Systems

Example of how file systems work within containers

```bash
$ sudo su
$ ls ./lower
$ ls ./upper
$ ./mount.sh
$ ls ./merged
$ cat ./merged/hello.txt
$ touch ./merged/whereami.txt
$ ls ./lower
$ ls ./upper
$ ./unmount.sh
$ exit
```

## References

- [How Containers Work](https://wizardzines.com/zines/containers/)
- [The Overlay Filesystem](https://windsock.io/the-overlay-filesystem/)
