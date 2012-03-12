#!/bin/bash

filename=$1
file_all=$2

for line in `cat $filename`; do
    file_search=`echo $line | awk -F ":" '{print $1}'`
    line_search=`echo $line |awk -F ":" '{print $2}'`
    functcalled=`echo $line |awk -F ":" '{print $3}'`
    functcaller=`grep $file_search $file_all | awk -F ":" -v num="$line_search" '{print ($2-num)":"$1":"$3":"$4":"$5}'| grep "^-" | sort -nr | head -n1 | awk -F ":" '{print $4}' | sed -e 's/ //g'`
    echo "(\""$functcaller"\",\""$functcalled"\")" | sed -e 's/ //g' >> edges0
done

uniq edges0 edges
awk 'BEGIN{printf "edge_list = ["}{printf $1","}END{printf "]\n"}' edges | sed -e 's/ //g' | sed -e 's/\,]/]/' >> py_var

rm edges0 edges