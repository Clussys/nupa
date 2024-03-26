sudo /opt/qemu/bin/qemu-system-x86_64 \
	-drive file=./node2.qcow2,format=qcow2,index=0,media=disk,id=hd \
	-m 4G,slots=4,maxmem=8G \
	-smp 4 \
	-machine type=q35,cxl=on \
	-nographic \
	-net nic \
	-net user,hostfwd=tcp::2222-:22 \
	-object memory-backend-file,id=shmmem-shmem0,mem-path=/dev/shm/my_shmem0,size=256M,share=yes \
	-device ivshmem-plain,id=shmem0,memdev=shmmem-shmem0,addr=0xb,master=on
