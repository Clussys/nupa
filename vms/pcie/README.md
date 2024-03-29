# 1.Build QEMU 

 Before configure qemu, you may need to install some software using following commands
 ```
 sudo apt install libaio-dev libnfs-dev libseccomp-dev libcap-ng-dev libxkbcommon-dev libslirp-dev libpmem-dev python3 python3-pip numactl libvirt-dev
 sudo pip3 install ninja meson
 ```

Build Qemu from source with stable 8.2

 ```
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout stable-8.2
mkdir build
cd build
../configure --prefix=/opt/qemu --target-list=i386-softmmu,x86_64-softmmu --enable-libpmem --enable-slirp
make -j 8
sudo make install
 ```

# 2. Get qcow2 Image

For PCIe showcase, we use a ubuntu server image based on linux-5.15.x, download its qcow2 img using :

```
wget http://43.133.203.111/pcie.qcow2
cp pcie.qcow2 pcie_node1.qcow2
cp pcie_node1.qcow2 pcie_node2.qcow2
```

 # 3. Run qemu
 ```
./node1.sh
# node1 log in, username is root, password is ubuntu
# if NIC is not set, try set as such that you can log in using ssh , enpXsY is your NIC name, please modify accordingly
ifconfig enpXsY 10.0.2.15
ifconfig enpXsY up

ssh root@127.0.0.1 -p 2221

./node2.sh
# node2 log in, username is root, password is ubuntu
# if NIC is not set, try set as such that you can log in using ssh , enpXsY is your NIC name, please modify accordingly
ifconfig enpXsY 10.0.2.15
ifconfig enpXsY up
ssh root@127.0.0.1 -p 2222
 ```

# 4. IP or RDMA Test
Now we can run **IP** or **RDMA** Test.

(1) [IP over PCIe](../../ip/pcie/README.md)


(2) [RDMA over PCIe](../../rdma/pcie/README.md)


Go to corresponding directory, and do the test according to the README.md inside. 
