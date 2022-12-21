#!/bin/bash
typeset -i length
length=0	

record="ali saad"

record=$(sed -r 's/[" "]+/┘/g' <<< $record)





i=2



tableName=file

echo $(awk 'BEGIN{FS=":" ; ORS=" "}{if(NR != 1 && $(('$i')) == "'$record'" ) print $(('$i'))}' $tableName)

