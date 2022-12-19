#!/bin/bash

record=9
tableName="fi"
i=1



if [[ `awk 'BEGIN{FS=":" ; ORS=" "}{if(NR != 1 && $(('$i')) == "'$record'" ) print $(('$i'))}' $tableName` != "" ]];then
	echo "found"
else
	echo "not found"
fi
