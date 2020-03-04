../hyperfork-kvmtool/lkvm run \
  --disk out/$1.ext4,ro \
  --kernel ../microvm-linux/arch/x86_64/boot/bzImage \
  --cpus 1 \
  --mem 1636 \
  --params "root=/dev/vda no-kvmclock" \
  --rng
