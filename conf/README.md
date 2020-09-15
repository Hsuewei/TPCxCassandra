# original ``README.txt``` under conf/ from apahe-cassandra-3.11.8
```
Required configuration files
============================

cassandra.yaml: main Cassandra configuration file
logback.xml: logback configuration file for Cassandra server


Optional configuration files
============================

cassandra-topology.properties: used by PropertyFileSnitch
```
---
# Modification under conf/
## cassandra-env.sh

## cassandra.yaml
### ```node01```
parameter | modified value   
----------| ---------------
cluster_name| 'cassandraCluster'
num_tokens| 128(node01)<br>256(node02,node03,node04)
data_file_directories| $CASSANDRA_HOME/data/data
seed_provider.<br>org.apache.cassandra.locator.SimpleSeedProvider.<br>paramters.seeds | "10.106.51.152,10.106.51.150" 
concurrent_reads | 16(node01)<br>96(node02,node03,node04)
concurrent_writes | 384
concurrent_counter_writes | 16
memtable_heap_space_in_mb | 
memtable_offheap_space_in_mb | 
listen_address| <sup>[1](#footnote1)</sup>

### ```node02```,```node03```,```node04```
parameter | modified value
----------| ---------------
cluster_name| 'cassandraCluster'
num_tokens| 256
data_file_directories| $CASSANDRA_HOME/data/data
seed_provider.<br>org.apache.cassandra.locator.SimpleSeedProvider.<br>paramters.seeds | "10.106.51.152,10.106.51.150"
concurrent_reads | 96
concurrent_writes | 384
concurrent_counter_writes | 96
memtable_heap_space_in_mb | 16384
memtable_offheap_space_in_mb | 16384
listen_address | <sup>[1](#footnote1)</sup>

 

---
# Foot Notes:
### 1:  <a name="footnote1">please refer to *host_info* part for ip mapping</a>
