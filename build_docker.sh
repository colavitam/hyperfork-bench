set -e

rm -rf mnt $1.tar

docker image build -f images/$1/Dockerfile -t $1 .
DPID=`docker create $1`
docker export $DPID > $1.tar

OUTFILE=out/$1.ext4
dd if=/dev/zero of=$OUTFILE bs=1M count=1024
mkfs.ext4 $OUTFILE
mkdir -p mnt

sudo mount $OUTFILE mnt
sudo tar -xf $1.tar -C mnt || sudo umount mnt
sudo umount mnt

rm $1.tar
rm -rf mnt
