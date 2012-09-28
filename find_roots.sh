#!/bin/bash
#if argv not input then use actual path
path=$1

find $path -name \*pro -not -name .\* > filelist

for file in `cat filelist`; do
    grep -i -E -H -n '^pro |^function ' $file >> names; 
done
sed -e 's/\,/\:/' names | awk -F ":" '{print $1":"$2":"$3}' | sed -s 's/\:function/\:function\:/I' | sed -s 's/\:pro/\:pro\:/I' > file_funct

#divide the file into 20
split -d -l 300 file_funct chunk_

let "nn=`ls chunk_* | wc -l`-1"
for chunk in `seq -f '%02G' 0 $nn`; do
    ./find_sub.sh chunk_$chunk $chunk & #find_sub filename number
done

wait

for chunk in `seq  -f '%02G' 0 $nn`; do
    cat file_funct_list_$chunk >> file_funct_list0
done

grep -viE ':pro |:function |:;' file_funct_list0 | sed -e 's/ //g' | sed -e 's/	//g' > file_funct_list


rm file_funct_list_* chunk_* file_funct_list0 

# Create list of functions and procedures for python
grep ":pro:" file_funct | awk -F ":" 'BEGIN { format = "\"%s\","; printf "pro = ("}{printf(format,$4)} END{printf ")\n"}' | sed -e 's/ //g' | sed -e 's/\,)/)/' > py_var
grep ":function:" file_funct | awk -F ":" 'BEGIN { format = "\"%s\","; printf "fun = ("}{printf(format,$4)} END{printf ")\n"}' | sed -e 's/ //g' | sed -e 's/\,)/)/' >> py_var

./find_edges.sh file_funct_list file_funct

sed -e 's/\"\"/\"empty\"/g' py_var | sed -e 's///g' > py_var0
mv py_var0 py_var

python2 create_map.py

#grep -v ":;" file_funct_list | grep -vi ":function"  | grep -vi ":pro" 