# NUPA: RDMA and TCP/IP over CXL and PCIe Fabric

## Abstrcat:
In the past three years, with the advancement of Large Language Models (LLMs), the potential for leveraging extensive computational power towards achieving Artificial General Intelligence (AGI) has become increasingly apparent. However, the substantial increase in model parameters has posed significant challenges to network infrastructures, especially those supporting GPU and AI cluster facilities. Nvidia, as an industry leader, has leveraged its existing GPUs and InfiniBand (IB) networks, alongside the latest NVLink and NvSwitch technologies, to develop a comprehensive solution that covers computing, networking, and storage needs. While this solution offers exceptional performance, its associated costs and closed nature necessitate a demand for new, more open, and cost-effective solutions.

At Clussys, an innovative AI network infrastructure company, we are poised to build our own CXL/PCIe Fabric solution on CXL controller. Leveraging this technology, we will develop RDMA and IP protocols based on the CXL/PCIe Fabric, enabling seamless adaptation of applications to new AI networks.

As Clussys, unlike traditional Ethernet network infrastructures, we will completely abandon the MAC network model and adopt a network model based on CXL controllers. We are particularly focused on small-scale, high-performance, low-latency cluster applications. Our goal is to interconnect 100 to 1000 GPUs, CPUs, and SSDs via high-speed PCIe/CXL bus networks, allowing these computational devices to operate as if they were one single device. This is the core area of current computational performance expansion, rather than focusing on interconnecting 10,000 or even 100,000 devices as in traditional cloud computing. If needed, we can scale up using Ethernet/IB to PCIe/CXL network conversion, but this is not our primary focus currently.

In small-scale clusters, such as the Nvidia-defined superpod clusters, we are particularly concerned with high-speed, low-latency communication between devices. Just like traditional networks, the key elements for improving communication performance include hardware control as much as possible, streamlined data flow (zero copy), and excellent flow control. To simplify the model, we compare network protocols and aim to achieve data transmission by leveraging existing hardware features as much as possible.

![protocols](protocols.png)

In the figure above, we can see that traditional network card devices introduce approximately 1-3us of additional latency. Additionally, data needs to be constantly copied between user space, kernel space, and devices. While various optimization techniques and technology modules can simplify this data movement, the results are not yet satisfactory, and we need something better.

In a CXL network, data movement can directly utilize the DMA of the CXL controller without the need for additional network cards or DSPs (this also applies to PCIe networks). Furthermore, the cache protocol provided by the CXL controller allows for faster and more timely data responses between different devices. Clussys, through the design of a unique yet universal bus interconnect network that leverages the performance of CXL controllers, efficiently moves data from one CPU to another, and from one GPU to another. The end-to-end latency is only 600ns, significantly reducing latency by over three times compared to RDMA networks.

To expedite ecosystem development and gather feedback from priority engineers, we are eager to share our achievements and research progress with the broader developer community. In this repository, we will gradually unveil our advancements. The structure of this repository is as follows:

```
nupa/
├── ip
│   ├── cxl
│   │   └── README.md
│   └── pcie
│       └── README.md
├── protocols.png
├── rdma
│   ├── cxl
│   │   └── README.md
│   └── pcie
│       └── README.md
├── README.md
├── uec
│   └── README.md
└── vms
    ├── cxl
    │   ├── node1.sh
    │   ├── node2.sh
    │   └── README.md
    └── pcie
        ├── node1.sh
        ├── node2.sh
        └── README.md

```

To accelerate ecosystem development and incorporate the opinions and suggestions of priority engineers, we are eager to share our achievements and R&D progress with developers. In this repository, we will gradually open up our progress. The structure of this repository is as follows:

### IP Folder
In the `ip` folder, we will build netdevice devices on the CXL network and introduce the capability of DMA technology for data transmission. Given the characteristics of CXL and PCIe networks, we aim to simplify protocol processing in the netdevice flow, removing unnecessary verification and inspection processes. We will provide applications for both CXL and PCIe scenarios.

### RDMA Folder
In the `rdma` folder, we will directly build RDMA devices on the CXL network and re-adapt the verbs interface. This is to enable applications to adapt to the future arrival of CXL networks without the need for modifications. Similarly, we will offer both CXL and PCIe modes.

### UEC Folder
UEC? This is for the future, but since the future has not arrived yet, let's reserve a spot for UEC.

### VMS Folder
Finally, our main attraction, the `vms` folder, our software development environment. As the name suggests, this is a development and verification environment based on virtual machines. Of course, in virtual machines, performance expectations should be moderated. The goal is to demonstrate the credibility of the technology. Within the `vms` directory, we have built two environments for CXL and PCIe. It is worth mentioning that CXL is a rapidly evolving technology with high kernel requirements. Therefore, we have selected the 6.3 kernel series. While new kernels offer new features, stability needs collective validation. For PCIe, a long-standing technology, we have opted for the 5.15 kernel. In each virtual machine environment, you can run scprits for usage and experience. Additionally, a `readme` file is available for reference.

Finally, we gave our architecture a name, NUPA :-)

---

# NUPA
## What is NUPA?

The **N**etwoking **U**nified **P**rotocol **A**rchitecture (NUPA) is an open-source software-defined protocol stack designed for the inter connection of servers. Currently, **NUPA** supports traditional ethernet protocol(TCP/IP), AKA, **NUPA-NET**, [IP over PCIe](ip/pcie/README.md) or [IP over CXL](ip/cxl/README.md), and RoCE V2 protocol, AKA,**NUPA-NET**, [RDMA over PCIe](rdma/pcie/README.md.md) or [RDMA over CXL](rdma/cxl/README.md)


## What we privide here
In this repo, we privide 2 kinds virtual hardware(**PCIe** and **CXL**) environment for both **IP** and **RDMA** protocol, known as **NUPA-NET** and **NUPA-RDMA**.


## NUPA-NET
NUPA-NET is the ethernet device driver specified for CLussys ASIC to provide standard ethernet interface, compatible with traditional ethernet interface. Users could use standard socket interface to access ethernet device.

If physics layer is PCIe, NUPA-NET is also known as **IP over PCIe**.

If physics layer is CXL, NUPA-NET is also known as **IP over CXL**.

More details please refer to [NUPA-NET](./NUPA-NET-VM.md)
## NUPA-RDMA
NUPA-RDMA is the RDMA device driver specified for Clussys ASIC to privide standard RDMA interface, users could use standard RDMA libraries to access the RDMA interface.

More details please refer to [NUPA-RDMA](./NUPA-RDMA.md)


## How to setup and run

Please refer to [VMS-PCIe](vms/pcie/README.md) and [VMS-CXL](vms/cxl/README.md)

## License

NUPA is licensed under the BSD LICENSE

## Documentation

The NUPA documentation is available [online](https://clussys.com/).

## Contacts

For any questions, please contact [Clussys](https://clussys.com/).


## Community
NUPA Community -- TODO


## Contact
Finally, thank you all for using and experiencing our technology. We hope to build an open ecosystem on CXL/PCIe technology and contribute to large-scale models and AGI.
Thanks to contributors @zhangg, @zhoujm, and @leo.
If you have any questions, feel free to email us at: info@clussys.com
