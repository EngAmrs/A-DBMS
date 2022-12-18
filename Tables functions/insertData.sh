#!/bin/bash

while true 
do 
	tableName=$(dialog --title "Choose Table" --inputbox "Enter Table Name" 8 45 3>&1 1>&2 2>&3)

		# if file not exist
	if [[ ! -f $tableName ]] && [[ $tableName != "" ]]; then

		dialog --title "Error Message" --msgbox "Table $tableName you entered doesn't exist, Try again " 8 45 
		
		# if file is exist		

	elif [[ -f $tableName ]] && [[ $tableName != "" ]]; then
		
		colsNum=`awk 'END {print NR}' .$tableName` # to know number of column
		fasel=":"

		for (( i=1 ; i <= $colsNum ; i++ )); do
				# get table information
			checkColName=`awk 'BEGIN {FS=":"}{if ( NR=='$i' ) print $1 }' .$tableName`
			checkDataType=`awk 'BEGIN {FS=":"}{if ( NR=='$i' ) print $2 }' .$tableName`
			checkIsPrimary=`awk 'BEGIN {FS=":"}{if ( NR=='$i' ) print $3 }' .$tableName`
			
			record=$(dialog --title "Record Data" --inputbox "Enter data for $checkColName with in data type ($checkDataType)" \
				 8 45 3>&1 1>&2 2>&3)
	
			test ##calling test function 

		#check Primary key

			if [[ $checkIsPrimary == "(PK)" ]]; then

				while [[ true ]]; do 
			

				   if [[ $record =~ ^[`awk 'BEGIN{FS=":" ; ORS=" "}{if(NR != 1)print $(('$i'-1))}' $tableName`]$ ]]; then

				      dialog --title "Error Message" --msgbox "Primary key can't be duplicated try again" 8 45

	 			      record=$(dialog --title "Record Data" --inputbox "Enter data for $checkColName with data type ($checkDataType)" \
						 8 45 3>&1 1>&2 2>&3)

				      test ##calling test function 

				   else

				      break;

			           fi
				

				done
			fi

		## insert record in table

			if ! [[ $i == $colsNum ]]; then

				echo -n $record$fasel >> $tableName

			else
				echo $record >> $tableName
				
			fi
		done 

		dialog --title "Success Message" --infobox "Your records inserted successfully" 8 45
		sleep 1
		
		break

	else 
		break
	fi
done


function test() {

	if [[ $checkDataType == "int" ]]; then

		while ! [[ $record =~ ^[0-9]+$ ]]; do

			dialog --title "Error Message" --msgbox "Not integer, Enter Record Again" 8 45
		
			record=$(dialog --title "Record Data" --inputbox "Enter data for $checkColName with data type ($checkDataType)" \
				8 45 3>&1 1>&2 2>&3)
		done

	elif [[ $checkDataType == "boolean" ]]; then

	      	while ! [[ $record = "true" || $record = "false" || $record = "TRUE" || $record = "FALSE" ||  \
				$record = "T" || $record = "t" || $record = "F" || $record = "f" ]]; do

	    	      	dialog --title "Error Message" --msgbox "Not a boolean; please try again only" 8 45

	 		record=$(dialog --title "Record Data" --inputbox "Enter data for $checkColname with data type ($checkDataType)" \
				8 45 3>&1 1>&2 2>&3)
		done

	fi

}
