#!/bin/bash
num=3
record=''


sum $num

tableName="file"
i=1

awk 'BEGIN{FS=":";OFS=":"}{if($0!=""){print '$record'}}' $tableName >> fil


function sum(){

	record+='$(('$1'))'

}
