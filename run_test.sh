../hyperfork-kvmtool/lkvm run \
  --disk out/$1.ext4,ro \
  --kernel ../microvm-linux/arch/x86_64/boot/bzImage \
  --cpus 1 \
  --mem $2 \
  --network "mode=none" \
  --params "root=/dev/vda rw no-kvmclock" \
  --rng \
  $3
