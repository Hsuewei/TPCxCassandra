# How I create table?
> Please refer to [createTable.cql](createTable.cql) for details
Comment:
1. The uniqueness of each row can be achieved by combination of **readingType**, **customerId** and **timestamp** fields
2. Create [composite partition key](https://docs.datastax.com/en/cql-oss/3.3/cql/cql_using/useCompositePartitionKeyConcept.html?hl=composite%2Cpartition%2Ckey)
> ((readingType,customerId),timestamp)
3. No matter what order of columns is stated in ```CREATE TABLE...```, the column name after creation is always ordered(from first to last) by:
  - partition key in ```CREATE TABLE....``` statement
  - clustering columns  in ```CREATE TABLE....``` statement
  - the rest of columns in alphabetical order
  

# How I transform data?
> Please refer to [data-transformer.sh](data-transformer.sh) for details

This script will do the following things:
- rearrange raw data columns' order
- trim double quotes
- trim ^M (carraiage return) from windows .csv files
- alter the timestamp foramt to meet Cassandra's [standard](https://cassandra.apache.org/doc/latest/cql/types.html/)

# How I query?
> Please refer to [query.cql](query.cql) for details




