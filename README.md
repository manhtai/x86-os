A toy OS for x86. Follow [some][1] [tutorials][2] in the net.

```
vagrant up
vagrant ssh
cd /vagrant
make
```

Back in your host:

```
qemu-system-x86_64 -drive format=raw,file=os-image.bin,if=floppy
```


[1]: https://github.com/tuhdo/os01
[2]: https://github.com/cfenollosa/os-tutorial
