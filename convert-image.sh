#!/bin/sh

set -x

MB=$((1024*1024))
size=$(qemu-img info -f raw --output json rhel7.raw | \
       gawk 'match($0, /"virtual-size": ([0-9]+),/, val) {print val[1]}')

rounded_size=$((($size/$MB + 1)*$MB))
echo "Rounded Size = $rounded_size"

qemu-img resize rhel7.raw $rounded_size

qemu-img convert -f raw -o subformat=fixed -O vpc rhel7.raw rhel7.vhd
