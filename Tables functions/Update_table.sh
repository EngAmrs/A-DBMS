#!/bin/bash

colname=""
condvalue=""
Target_Column=""
newrecord=""

function main(){

    for (( ; ; ))
    do
        tableName=$(dialog --title "Table Name" --inputbox "Enter Table Name" 8 45 3>&1 1>&2 2>&3)

        if [[ ! -f $tableName ]] && [[ $tableName != "" ]]; then

            dialog --title "Error Message" --msgbox "Table doesn't exist" 8 45
        else
            break
        fi    
    done

    while true
    do  
        if [[ -f $tableName ]] && [[ $tableName != "" ]]; then

            ###################
            # Data Form
            ################### 
        user_record=$(\
            dialog                                             \
            --separate-widget $'\n'                            \
            --title "INSERIR"                                  \
            --form ""                                          \
            0 0 0                                              \
            "Column_name:"   1 1 "$colname"      1 30 40 30      \
            "column_value:"  2 1 "$condvalue"    2 30 40 30      \
            "Target_Column:" 3 1 "$Target_Column"        3 30 40 30      \
            "New_record:"    4 1 "$newrecord"    4 30 40 30      \
            3>&1 1>&2 2>&3 3>&- \
            )
            colname=$(echo "$user_record" | sed -n 1p)
            condvalue=$(echo "$user_record" | sed -n 2p)
            Target_Column=$(echo "$user_record" | sed -n 3p)
            newrecord=$(echo "$user_record" | sed -n 4p)
        
            ###################
            # Checking columns
            ################### 
            
            checkcolumnfound=$(awk 'BEGIN{FS=":"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$colname'") print i}}}' $tableName)
            if [[ ! $checkcolumnfound ]] && [[ $checkcolumnfound != "" ]]; then
                    dialog --title "Error Message" --msgbox "Column doesn't exist" 8 45
                
            elif [[ $checkcolumnfound ]] && [[ $checkcolumnfound != "" ]]; then
                condrecordNo=$(awk 'BEGIN{FS=":"}{if ($'$checkcolumnfound'=="'$condvalue'") print $'$checkcolumnfound'}' $tableName)
                recordNo=$(awk 'BEGIN{FS=":"}{if ($'$checkcolumnfound'=="'$condvalue'") print NR}' $tableName)


                if [[ $condrecordNo == "" ]]; then
                    dialog --title "Error Message" --msgbox "This value dosen't Exist" 8 45
                else

                    if [[ $recordNo == 1 ]] ; then

                        dialog --title "Error Message" --msgbox "It's the column name" 8 45

                    else

                        checkfieldfound=$(awk 'BEGIN{FS=":"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$Target_Column'") print i}}}' $tableName)

                        if [[ $checkfieldfound == "" ]] ; then 
                            dialog --title "Error Message" --msgbox "Target_Column Not found" 8 45

                        else
                            checkDataType=$(awk 'BEGIN{FS=":"}{if($1=="'$Target_Column'") print $2}' .$tableName)
                            checkIsPrimary=$(awk 'BEGIN{FS=":"}{if($1=="'$Target_Column'") print $3}' .$tableName)
                            datatypeTest
                            primaryTest
                            break

                        fi
                    fi
                fi
            else
                break    
            fi
        else
            break
        fi
    done
}



### Checking Functions ###

function datatypeTest() {
	if [[ $checkDataType == "int" ]]; then

		while ! [[ $newrecord =~ ^[0-9]+$ ]]; do

			dialog --title "Error Message" --msgbox "Not integer, Enter Record Again" 8 45
            break
		done

	elif [[ $checkDataType == "boolean" ]]; then

	    while ! [[ $newrecord = "true" || $newrecord = "false" || $newrecord = "TRUE" || $newrecord = "FALSE" ||  \
			$newrecord = "T" || $newrecord = "t" || $newrecord = "F" || $newrecord = "f" ]]; do

	    	    dialog --title "Error Message" --msgbox "Not a boolean; please try again only" 8 45
                break
		done        
	fi
}

function primaryTest() {
    if [[ $checkIsPrimary == "(PK)" ]]; then
        colsNum=`awk 'END {print NR}' .$tableName` 
            
        while [[ true ]]; do 

              for(( i=1 ; i <= $colsNum ; i++ )); do
                firstField=`head -1 $tableName | cut -d ":" -f $i`
                        if [[ $firstField == $Target_Column ]]; then
                            primary_values=`tail -n +2 "$tableName" | cut -d ":" -f $i`
                        fi
                done 

                columnsMax=`echo "$primary_values" | wc -l`
                for(( i=1 ; i <= $columnsMax ; i++ )); do

                    tst=`echo "$primary_values" | awk 'NR=="'$i'"{print $1}'`

                    if [[ $tst == $newrecord ]]; then
                        dialog --title "Error Message" --msgbox "Primary key can't be duplicated try again" 8 45
                        break 2

                    elif [[ $tst != $newrecord ]]; then

                            if [[ $i == $columnsMax ]]; then
                            oldrecord=$(awk 'BEGIN{FS=":"}{if(NR=='$recordNo'){for(i=1;i<=NF;i++){if(i=='$checkfieldfound') print $i}}}' $tableName)
                                sed -i ''$recordNo's/'$oldrecord'/'$newrecord'/g' $tableName
                                dialog --title "Record" --msgbox "record updated sucessfully" 8 45
                                break 2    
                            fi
                    fi     
                done
                
        done
    fi
}

main