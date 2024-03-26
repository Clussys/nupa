# IP over CXL


## 0. Prerequisite

 Before you dive into this doc, please make sure virtual environment has already been setup according to  [VMS-CXL](../../vms/cxl/README.md)

## 1. Install Driver

On **node1**

```
cd ~/ip_over_cxl
sudo ./install.sh 0
# suppose enpXsY is the NIC name nupanet driver generated, config NIC using:
ifconfig enpXsY 192.168.8.100/24


```

On **node2**
```
cd ~/ip_over_cxl
sudo ./install.sh 1
```


## 2.Setup
On **node1**, suppose **enpXsY** is the NIC name nupanet driver generated, please modify accordingly, config NIC using:
```

ifconfig enpXsY 192.168.8.100/24
ifconfig enpXsY up
```

On **node2**, suppose **enpXsY** is the NIC name nupanet driver generated, please modify accordingly, config NIC using:
```

ifconfig enpXsY 192.168.8.101/24
ifconfig enpXsY up
```

## 3. Test

After setting up the nupanet, we can run some basic tests to test nupanet 
### (1) ping test
Suppose **node1**'s IP is ```192.168.8.100``` and **node2**'s IP is ```192.168.8.101```, on **node1**, we can ping **node2** using:

``` 
ping 192.168.8.101
``` 

### (2) iperf test
We can use ***iperf*** test to test performance. Suppose **node1** is server(192.168.8.100), and **node2**(192.168.8.101) is client.
On **node1**, run:

``` 
iperf3 -s
```

On **node2**, run:

``` 
iperf3 -c 192.168.8.100 -i 1 -t 10
```