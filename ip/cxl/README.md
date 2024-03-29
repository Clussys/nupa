# IP over CXL


## 0. Prerequisite

 Before you dive into this doc, please make sure virtual environment has already been setup according to  [VMS-CXL](../../vms/cxl/README.md)

## 1. Install Driver

On **node1**

```
cd ~/ip_over_cxl
sudo ./install.sh 0
```

On **node2**
```
cd ~/ip_over_cxl
sudo ./install.sh 1
```


## 2.Setup
On **node1**, suppose **nupanet0** is the NIC name nupanet driver generated, please modify accordingly.Check network config using

```
ifconfig
```

if **nupanet0** has never been setup before, we can use following commnads to setup
config NIC using:
```
sudo nmcli connection add con-name 'nupanet0' ifname 'nupanet0' type 'ethernet' ipv4.method 'manual' ipv4.addresses "192.168.8.100/24" ipv4.gateway '192.168.8.1'
```

On **node2**, suppose **nupanet0** is the NIC name nupanet driver generated. Since node2.qcow2 is copied from node1.qcow2, possibly **nupanet0**'s address has already been setup as 192.168.8.100, please change it to 192.168.8.101 using
```
sudo nmcli con modify nupanet0 ipv4.addresses "192.168.8.101/24"
```
Then reboot
```
sudo reboot
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