CREATE KEYSPACE tpc_lpgen
   WITH REPLICATION = {
            'class':'NetworkTopologyStrategy',
            'dc1': 1,
            'dc2': 1
        }
AND DURABLE_WRITES=true;



CREATE TABLE tpc_lpgen.dev_15003(
    timestamp timestamp,
    branchCode text,
    sdp uuid,
    customerId text,
    meterId varchar,
    readingType text,
    displayCode tinyint,
    measurement float,
    multiplier tinyint,
    quality text,
    qualityReason text,
    veeStatus text,
    veeFlag text,
    messageId text,
    receivedTime text,
    saveTime text,
    editor text,
    reviewer text,
    version tinyint,
    PRIMARY KEY ((readingtype,customerid),timestamp)
);



/* at first we leave table option as default */

 /*WITH CLUSTERING ORDER BY (end ASC, class ASC, title ASC)*/
 /* AND option=value */
 

/* table option:
ALTER TABLE tpc_lpgen.1001_1500_3
  WITH bloom_filter_fp_chance = 0.01 
  AND caching = {'keys': 'NONE', 'rows_per_partition': '10'}
  AND comment = ''
  AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '32', 'min_threshold': '4'}
    AND compression = {'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99PERCENTILE';

/* Create index
CREATE INDEX ON tpc_lpgen.1001_1500_3.readingType

*/


/*
REF: COPY
https://docs.datastax.com/en/cql-oss/3.3/cql/cql_reference/cqlshCopy.html

REF: strftime
https://docs.python.org/3/library/datetime.html

*/
/* import csv into exsiting table */


COPY tpc_lpgen.dev_15003 
FROM '/cassandra/sourceData/after/*.csv'
   WITH DELIMITER=','
   AND HEADER=true	 
   /* true, first row of data is header */      
   AND NUMPROCESSES=16;
   /* hope that importing processing will be faster */
   /*AND QUOTE='"'; */
   /*AND DATETIMEFORMAT='%Y-%m-%dT%H:%M:%S%f%z';*/  

/*
SOME NOTES for COPY commmand:
1. Import CSV into Cassandra
   - Make Sure dont replace the row separator:  (ctrl+v+m) with \n
   - if you do so, use awk or somthing else append  at the end of each row
2. Column schema
   - Cassandra will shuffle the column order with:
       - partition keys (with alphabatical order)
       - clustering columns (with alphabetical order)
       - the rest of columns (with alphabetical order)
   - Make sure your .CSV file follow the column order
3. Timestamp data type in COPY command
   - format the timestamp:
       - cqlshrc under /${user}/.cassandra
            [ui] datetimeformat=${strftime format}
            FOR example: %Y-%m-%dT%H:%M:%S.%f%z
       - COPY WITH DATETIMEFORMAT= '%Y-%m-%dT%H:%M:%S.%f%z'
   - ##############  
     ## BAD NEWS ##  Neither of these two can't control the behavior of showing or reading timestamp
     ##############  (Although the official doc said it can)

   - ANOTHER way that i have successfully imported into Cassandra's timestamp data type is 
     ###############
     ## GOOD NEWS ## Give the number of milliseconds since the Epoch to Cassandra timestamp data type
     ############### (Cassandra will interpret it as Interger rather than String)

   - Or you can just modify your source data's timestamp column that fit the strftime format in default:
       - '%Y-%m-%d %H:%M:%S.%f%z'
            (Note that there is a space between %d and $H)
       - Number of millisecond since 1970-01-01T00:00:00.000000+0000
4. Timestamp showing
   - Shown in terminal, the format will be '%Y-%m-%d %H:%M:%S.%f%z'
     But:
          - INSERT value with 1234-56-78T00:00:33.123456+0000 will be rejected
          - COPY from csv column with 1234-56-78T00:00:33.123456+0000 wii be omitted to 
            1234-56-78T00:00:33.123000+0000 
*/









