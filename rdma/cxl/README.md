# Introduction
Two linux kernel modules are provided at this directory: nupa_net.ko and rdma_cxl.ko. nupa_net.ko provided a neccessary Interface of ethernet for IB device and a core nupa abstraction for data transfer through cxl. rdma_cxl.ko is just the rdma driver based on the nupa core.
Along with the kernel modules, two virtual machines run on qemu are provided, located at ../../../vms/cxl/. Goto that directory, and read the README to get the usage description.
In this README, we take a example of two-host system to demonstrate the usage of the rdma over cxl

# usage
1) Copy the kernel modules into the two virtual machines.
2) Create a cxl region, for example:
   ```
   sudo cxl create-region -m -t ram -d decoder0.0 -w 1 -g 4096 mem0
   lsmem
   ```
   On our platform, you will see:
   ```
   [fedora@localhost ~]$ lsmem
   RANGE                                 SIZE   STATE REMOVABLE   BLOCK
   0x0000000000000000-0x000000007fffffff   2G  online       yes    0-15
   0x0000000100000000-0x000000047fffffff  14G  online       yes  32-143
   0x0000000690000000-0x000000078fffffff   4G offline           210-241

   Memory block size:       128M
   Total online memory:      16G
   Total offline memory:      4G
   ```
   0x690000000-0x78fffffff is the range of memory we newly added to the system, 0x690000000 is the base address.
3) Install nupa_net.ko
   On one virtual machne, run:
   ```
   sudo insmod nupa_net.ko base_addr=0x690000000 local_port=x
   ```
   here x = 0 or 1. we names the virtual machine VM0, on which x is set to 0, and the other VM1, on which x is set to 1.
   when completed, a ethernet interface will appear as nupa_net0 on both VMs.
4) Set the ipaddr
   On VM0, run:
   ```
   sudo ifconfig nupa_net0 192.168.112.1
   ```
   On VM1, run:
   ```
   sudo ifconfig nupa_net0 192.168.112.2
   ```
5) Install rdma_cxl.ko
   On both VMs, run:
   ```
   sudo modprobe ib_core
   sudo modprobe ib_uverbs
   sudo insmod rdma_cxl.ko
   ```
   When this step completed, an ib device named nupa_rdma0 on both VMs will appear.
6) Have a look
   run: 
   ```
    ibv_devinfo
   ```
   you will see the details of the ib device --- nupa_rdma0
   ```
   hca_id: nupa_rdma0
         transport:                        InfiniBand (0)
         fw_ver:                           0.0.0
         node_guid:                        326e:75ff:fe70:6130
         system_image_guid:                326e:75ff:fe70:6130
         vendor_id:                        0xffffff
         vendor_part_id:                   0
         hw_ver:                           0x0
         phys_port_cnt:                    1
                port:      1
                           state:                PORT_ACTIVE  (4)
                           max_mtu:              4096  (5)
                           active_mtu:           1024  (3)
                           sm_lid:               0
                           port_lid:             0
                           port_lmc:             0x00
                           link_layer:           Ethernet
   ```
   This is the details of nupa_rdma0 on VM0.
7) Performance test
   You can use any tool in perftest to do the bandwidth or latency testing.
