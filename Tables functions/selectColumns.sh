#!/bin/bash

function sumRecord(){

	allcol+='$(('$1'))'

}


while true ; do 

	tableName=$(dialog --title "List DataBases" --inputbox "Enter Table Name" 8 45 3>&1 1>&2 2>&3)
                                        
	if [[ ! -f $tableName ]] && [[ $tableName != "" ]]; then 
                                                
		dialog --title "Error Message" --msgbox "Table doesn't exist" 8 45
                                                
        elif [[ -f $tableName ]] && [[ $tableName != "" ]]; then 
                 
		numCol="$(cat $tableName | awk -F ":" 'END{print NF}')"
		allcol=''

		while true ; do
						              
		colNum=$(dialog --title "List DataBases" --inputbox "Enter number of column display from { 1 to $numCol }" 8 45 3>&1 1>&2 2>&3)

		if [[ $colNum == "" ]];then 
			break 2
		elif [[ $colNum != [0-9]* ]];then
			dialog --title "Error Message" --msgbox "please enter number " 8 45
		elif [[ $colNum > $numCol ]];then
			dialog --title "Error Message" --msgbox "please enter number from { 1 to $numCol }" 8 45
		else 
			break
		fi
		done

		if [[ $colNum == [0-9]*  ]] ;then

			for (( i=1 ; i<=$colNum ;i++ )) ; do

				while true ; do 

					colname=$(dialog --title "Table Records"  --inputbox "Enter Column $i Name" 8 45 3>&1 1>&2 2>&3)
					checkcolumnfound=$(awk 'BEGIN{FS=":"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$colname'") print i}}}' $tableName)
						
						if [[ $colname == "" ]]; then


							break 3

						elif [[ $checkcolumnfound == "" ]]; then
						
							dialog --title "Error Message" --msgbox "Column doesn't exist" 8 45
						else
							break						
						fi
				done 

				sumRecord $checkcolumnfound
						
				if [[ $i != $colNum ]] ;then
					allcol+=','
				fi

			done
						
		fi

		if [[ $allcol != "" && $allcol != ',' ]]; then
			`awk 'BEGIN{FS=":";OFS="\t"}{if($0!=""){print '$allcol'}}' $tableName > fil`
			cat fil | sed -r 's/[┘]+/ /g' > fil2

			typeset -i length
			length=0							
			for (( i=1;i<=$numCol;i++)) 
			do 
				length+=$(cut -d$'\t' -f$i fil2| awk -F "" 'BEGIN{len=0}{if(len<NF)len=NF}END{print len}')
			done
			. ../../.prettytable
			whiptail --title "Table Records" --scrolltext --msgbox "$(cat fil2 | prettytable $colNum)" 20 $(("$length"+(("$colNum"+1)*4)))
			rm fil fil2
			break

		fi
	else 
		break 
        fi
done

