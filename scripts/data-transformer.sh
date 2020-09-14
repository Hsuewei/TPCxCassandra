#!/bin/bash

#How to use this script
# Give two arguments:
# 1. Absolute path to *.csv's father directory
# 2. Absoulte path to transformed *.csv's father directory


#How to get filename under a directory
# filename=$(basename -- "$file")
# echo $filename
# (output): 000082.csv


#Get rid of ^M
# in windows operating system
# change to new line is  (carriage return and new line):(\r\n)
# IN linux you should press ctrl + v + m  in succession



FILE_DIR=$1/*.csv
OUT_FILE_DIR=$2

for file in $FILE_DIR; do
	#this command aim to use single quote in awk '' with -v option
	# filename=$(basename -- "$file")
	# awk -v q=\' 'BEGIN{FS=",";OFS=","}{if(NR>=2){sub(//,""); print $6,$4, q substr($1,2,24)"+0000" q,$8,$2,$7,$17,$14,$5,$9,$10,$11,$15,$18,$16,$3,$13,$12,$19}else{ print $6,$4,$1,$8,$2,$7,$17,$14,$5,$9,$10,$11,$15,$18,$16,$3,$13,$12,$19}}' $file > $OUT_FILE_DIR/$(basename -- "$file")
    

	#this commmand will
	# 1. re-order the columns
	# 2. trim ^M from windows .csv
	# 3. trim double quote
	# 4. modify timestamp foramt to meet cassandra's standard
	# Note the split(),substr(), and sub() function in awk
	awk '
	BEGIN{FS=",";OFS=","}
	{
	   if(NR>=2){
		sub(//,"");  
		gsub(/\"/,"");
		split($1,a,"T");
		print $6,$4,substr(a[1]" "a[2],1,23)"+0000",$2,$7,$17,$8,$14,$5,$9,$10,$11,$15,$18,$16,$3,$13,$12,$19
	   }
	   else{
		sub(//,"");
		gsub(/\"/,"");
		print $6,$4,$1,$2,$7,$17,$8,$14,$5,$9,$10,$11,$15,$18,$16,$3,$13,$12,$19
	   }
	}
	' $file > $OUT_FILE_DIR/$(basename -- "$file")
done



