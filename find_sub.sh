#!/bin/bash

filename=$1
echo $filename
# for some weird reason, the cat $filename was showing just till
# the space after :pro: ... maybe it would work with 
# line in $filename????  next to test if this does not work
for line in `sed 's/ //g' $filename`; do
    funct=`echo $line | awk -F ":" '{print $4}'`
    fop=`echo $line | awk -F ":" '{print $3}'`
    if [ "$fop" = "function" ]; then
	ff=$funct"\("
    fi
    if [ "$fop" = "pro" ]; then
	ff=`echo "^"$funct"[, ][^(_|*)]" | sed -e 's/ //'`
    fi
    for file in `cat filelist`; do
        # third awk tries to find whether the 3rd column still exist 
	#and contain the function 
	#eg: "...:25:END;functionname" => "...:25:END" should not be printed
        # Need from echo into vari, otherwise it adds a forward blank space :-s
	grep -i -E -H -n "$ff" $file| awk -F ";" '{print $1}' | awk -F ":" -v fun="`echo $funct`" 'tolower($3) ~ tolower(fun)'| awk -F ":" -v fun="`echo $funct`" '{print $1":"$2":"fun":"$3}'>> file_funct_list_$2 
    done
        
done
