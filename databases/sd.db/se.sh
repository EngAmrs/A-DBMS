#!/bin/bash
checkcolumnfound=2
record='$1,$2,$#'

value="ali"

tableName="file"


`awk 'BEGIN{FS=":";OFS="\t"}{if($0!="" && $'$checkcolumnfound'== '$value' ){print '$allcol'}}' $tableName > fil`
