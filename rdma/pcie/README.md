# Introduction
Three linux kernel modules are provided at this directory: nupa_net.ko, ib_uverbs.ko and rdma_nupa.ko. nupa_net.ko provided a neccessary Interface of ethernet for IB device and a core nupa abstraction for data transfer through PCIe. rdma_nupa.ko is just the rdma driver based on the nupa core. ib_uverbs.ko is a core dependency of rdma_nupa.ko but absent on our board, so we compiled one and provide together.
Along with the kernel modules, two virtual machines run on qemu are provided, which located at ../../../vms/pcie/. Goto that directory, and read the README to get the usage description.
In this README, We take a example of two-host system to demonstrate the usage of the rdma over PCIe.

# usage
We call the anyone among the two hosts VM0, and the other VM1.
1) cd /root/rdma
2) run script
   on VM0:
   ```./install.sh 0
   ```
   On VM1:
   ```./install.sh 1
   ```
3) Have a look
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
4) Performance test
   You can use any tool in perftest to do the bandwidth or latency testing.
