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

# Modification under conf/
## cassandra.yaml
## cassandra-env.sh
parameter | modified value   
----------| ---------------
cluster_name| 'cassandraCluster'
num_tokens| 128(node01)<br>256(node02,node03,node04)
data_file_directory| $CASSANDRA_HOME/data/data
seed_provider.<br>org.apache.cassandra.locator.SimpleSeedProvider.<br>paramters.seeds | "10.106.51.152,10.106.51.150" 
concurrent_reads | 16(node01)<br>96(node02,node03,node04)
concurrent_writes | 384
concurrent_counter_writes | 16(node01)<br>96(node02,node03,node04)
memtable_heap_space_in_mb | (node01)<br>16384(node02,node03,node04)
memtable_offheap_space_in_mb | (node01)<br>16384(node02,node03,node04)
listen_address|10.106.51.152 node01 <br> 10.106.51.149 node02 <br> 10.106.51.150 node03 <br> 10.106.51.151 node04|

