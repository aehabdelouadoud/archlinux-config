#!/bin/bash

qemu-system-x86_64 \
  -enable-kvm \
  -m 4G \
  -smp 2 \
  -boot d \
  -netdev user,id=net0,net=192.168.0.0/24,dhcpstart=192.168.0.9,hostfwd=tcp::2222-:22 \
  -device virtio-net-pci,netdev=net0 \
  -vga virtio \
  -monitor stdio \
  -display sdl \
  -hda "$1"
