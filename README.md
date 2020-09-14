# TPCxCassandra
use mock Taiwan power company and get familiar with Cassandra

# Table of Contents
* [Hardware Info](#hardware-info)
* [Software Info](#software-info)
* [Host Info](#host-info)
* [Deployment](#deployment)
    * [Topology](#topology)
    * [Install Cassandra](#install-cassandra)


## Hardware Info
- servers:
  - QuantaGrid D51PH-1ULH : 4
    - CPU: Intel Xeon E5 2680 V3 : 8
    - RAM: Skhynix 2133Hz 2R*4 16G : 52 (4,16,16,16)
    - Boot: InteL SATA SSD S3710 960GB : 4
    - SSD: Samsung SATA SSD SM863 960GB : 21 (0,7,7,7)
    - NIC: Mellanox  CX4 25G  Dual port : 4
    - SAS Controller: SAS Controller: LSI 3008 (LSI SAS9300) : 4
- switches:
  - QuantaMesh T3048-LY8 : 1
    - cables: 10G SFP+ DAC Cable - 3m: 8
  - QuantaMesh T1048-LB9 : 1
    - cables: 1G Cat5e CABLE - 2m: 4


## Software Info
OS | Application | Java
---|------------|----
RHEL 7.5 | apapche-Cassandra-3.11.8| OpenJDK1.8

## Host Info
hostname | IP | DC(data center) | rack number
node01 | 10.106.51.152 | dc1 | rack1
node02 | 10.106.51.149 | dc1 | rack2
node03 | 10.106.51.150 | dc2 | rack1
node04 | 10.106.51.151 | dc2 | rack2

> ```node01``` only equipped with 1 SSD and 4 16G-memory

## Deployment

### Topology
![](images/nodes.png)

### Install Cassandra
#### ref:
   - [apach Cassabdra installation](https://cassandra.apache.org/doc/latest/getting_started/installing.html)
#### Tarball download
```shell
# Cassandra 3.11.8
wget http://ftp.mirror.tw/pub/apache/cassandra/3.11.8/apache-cassandra-3.11.8-bin.tar.gz
```
### Environment Set-up
#### Set Java Home
#### disable firewalld
#### Set up LVM and set up $CASSANDRA_HOME
```node01``` : Use OS disk's **/home** partition as $CASSANDRA_HOME
``` shell
# create dir
mkdir /home/cassandra
cd /
ln -s /home/cassandra
# adduser 
adduser cassandra --no-create-home
```

```node02```,```node03```,```node04``` : Raid-5 on 7 SSD as $CASSANDRA_HOME
``` shell
# LVM
pvcreate /dev/sda;pvcreate /dev/sdb;pvcreate /dev/sdc;pvcreate /dev/sdd;pvcreate /dev/sde;pvcreate /dev/sdf;pvcreate /dev/sdg
vgcreate --dataalignment 128K --physicalextentsize 4096K cassandra-data /dev/sda /dev/sdb /dev/sdc /dev/sdd /dev/sde /dev/sdf /dev/sdg
lvcreate --type raid5 -i 6 -I 64K -l 100%FREE -n storage cassandra-data
mkfs.xfs -b size=4096 -d su=64k,sw=6 /dev/mapper/cassandra--data-storage
# create dir
mkdir /cassandra
# create user
adduser cassandra --no-create-home
```





