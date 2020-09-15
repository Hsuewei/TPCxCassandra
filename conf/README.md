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
# Modification
* [cassandra.yaml](#cassandra-yaml)
* [cassandra-env.sh](#cassandra-env-sh)
* [cassandra-rackdc.properties](#cassandra-rackdc-properties)
* [jvm.options](#jvm-options)


## ref:
1. [Cassandra.yaml configuration](https://docs.datastax.com/en/cassandra-oss/3.x/cassandra/configuration/configCassandra_yaml.html)
2. [Configure Cassandra Heap Dump](https://docs.datastax.com/en/ddac/doc/datastax_enterprise/config/configHeapDump.html)
3. [Cassandra Cluster Set-up recommendations](https://thelastpickle.com/blog/2019/01/30/new-cluster-recommendations.html)
4. [What is GC?](https://blog.51cto.com/sunbean/768034)
5. [GC Tunning for Apahe Cassandra](https://thelastpickle.com/blog/2018/04/11/gc-tuning.html)
6. [DataStax: Tuning JAVA Heap G1GC](https://docs.datastax.com/en/cassandra-oss/3.x/cassandra/operations/opsTuneJVM.html#opsTuneJVM__tuning-the-java-heap)
7. [Oracle: G1GC GC tuning](https://www.oracle.com/technical-resources/articles/java/g1gc.html)



## cassandra.yaml
### ```node01```
parameter | modified value   
----------| ---------------
cluster_name| 'cassandraCluster'
num_tokens| 128
data_file_directories| $CASSANDRA_HOME/data/data
seed_provider.<br>org.apache.cassandra.locator.SimpleSeedProvider.<br>paramters.seeds | "10.106.51.152,10.106.51.150" 
concurrent_reads | 16
concurrent_writes | 384
concurrent_counter_writes | 16
memtable_heap_space_in_mb | 
memtable_offheap_space_in_mb | 
listen_address| <sup>[1](#footnote1)</sup>
endpoint_snitch | GossipingPropertyFileSnitch
enable_user_defined_functions | true

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
endpoint_snitch | GossipingPropertyFileSnitch
enable_user_defined_functions | true

---
## cassandra-env.sh
### set **CASSANDRA_HOME**, **CASSANDRA_CONF**, **CASSANDRA_LOG_DIR**
Here is an example
``` shell
CASSANDRA_HOME=/cassandra
CASSANDRA_CONF=$CASSANDRA_HOME/conf
CASSANDRA_LOG_DIR=$CASSANDRA_HOME/logs
```
### set jvm heapDumpPath
Here is an example
``` shell
export CASSANDRA_HEAPDUMP_DIR=$CASSANDRA_HOME/data/heapDump
```

---
## cassandra-rackdc.properties
host | value
-----|------
node01 | dc=dc1<br>rack=rack1
node02 | dc=dc1<br>rack=rack2
node03 | dc=dc2<br>rack=rack1
node04 | dc=dc2<br>rack=rack2

---
## jvm.options
``` shell
# disable CMS
#-XX:+UseParNewGC
#-XX:+UseConcMarkSweepGC
#-XX:+CMSParallelRemarkEnabled
#-XX:SurvivorRatio=8
#-XX:MaxTenuringThreshold=1
#-XX:CMSInitiatingOccupancyFraction=75
#-XX:+UseCMSInitiatingOccupancyOnly
#-XX:CMSWaitDuration=10000
#-XX:+CMSParallelInitialMarkEnabled
#-XX:+CMSEdenChunksRecordAlways

# Heap sizes
-Xms64G
-Xmx64G

# New Gen size
-Xmn2400m

# use G1GC
-XX:+UseG1GC
-XX:G1RSetUpdatingPauseTimePercent=5
-XX:MaxGCPauseMillis=500
-XX:InitiatingHeapOccupancyPercent=70
-XX:ParallelGCThreads=48
-XX:ConcGCThreads=48

# GC log
-XX:+PrintGCDetails
-XX:+PrintGCDateStamps
-XX:+PrintHeapAtGC
-XX:+PrintTenuringDistribution
-XX:+PrintGCApplicationStoppedTime
-XX:+PrintPromotionFailure
-XX:PrintFLSStatistics=1
-Xloggc:/cassandra/logs/gc.log
-XX:+UseGCLogFileRotation
-XX:NumberOfGCLogFiles=10
-XX:GCLogFileSize=10M
```


---
# Foot Notes:
### 1:  <a name="footnote1">please refer to *host_info* part for ip mapping</a>
