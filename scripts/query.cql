USE tpc_lpgen;


/* show keyspace's fuction */
DESCRIBE FUNCTION tpc_lpgen.multiplication;


/* drop keyspace's function with sapcified data type */
DROP FUNCTION tpc_lpgen.multiplication (float,tinyint) ;

/* create UDF */
CREATE OR REPLACE FUNCTION multiplication(input1 float, input2 tinyint)
	CALLED ON NULL INPUT 
	RETURNS float
	LANGUAGE java AS 'return input1 * input2;';

/*
CALLED ON NULL INPUT 
ensures the function will always be executed.

RETURNS NULL ON NULL INPUT 
ensures the function will always return NULL if any of the input arguments is NULL.

RETURNS 
defines the data type of the value returned by the function.
*/


SELECT customerid, SUM(multiplication(measurement,multiplier)) AS measurement
FROM tpc_lpgen.dev_15003
WHERE readingtype='0.0.2.9.1.2.12.0.0.0.0.0.0.0.0.3.72.0'
  AND customerId='00000000195'
  AND timestamp >= '2020-02-08 00:00:00.000+0000'  
  AND timestamp < '2021-02-09 00:00:00.000+0000'
GROUP BY readingtype,customerid ;

