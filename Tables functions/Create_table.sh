#!/bin/bash
typeset -i isPK=0
cols_number=""
pk=""
datatype=""
count=1
countp=0

while true
do
	#================
	# Tables creation
	#================
	table=$(dialog --title "Creating table..." --inputbox "Enter the table name" 8 45 3>&1 1>&2 2>&3)

	if [[ -f $table ]] && [[ $table != "" ]]; then

		dialog --title "Creating table..." --msgbox "$table is already exist!" 8 45

	elif [[ $table == *['!'@#\$%^\&*().\,\:\;\/\\\"\'\{\}\`\~\-\^\%\$\<\>\?\|+" ""]""["]* ]] || [[ $table == [0-9]* ]] && [[ $table != "" ]]; then

		dialog --title "Creating table..." --msgbox "{$table} is not valid name, please try again" 8 45

	elif [[ $table != *['!'@#\$%^\&*().\,\:\;\/\\\"\'\{\}\`\~\-\^\%\$\<\>\?\|+" ""]""["]* ]] || [[ $table == [0-9]* ]] && [[ $table != "" ]]; then
		
		#================
		# Columns creation
		#================
		
		for (( ; ; ))
		do
			cols_number=$(dialog --title "Creating columns..." --inputbox "Enter column number" 8 45 3>&1 1>&2 2>&3)
			if [[ $cols_number == *[a-zA-Z]* ]] || [[ $cols_number == 0 ]] || [[ $cols_number == *['!'@#\$%^\&*().\,\:\;\/\\\"\'\{\}\`\~\-\^\%\$\<\>\?\|+" ""]""["]* ]]; then
				dialog --title "Creating Column..." --infobox "Incorrect enter, Please try again!" 8 45
				sleep 1
			elif [[ $cols_number == "" ]]; then
				break 2
			else
				break	
			fi
		done

		touch $table
		touch .$table
		while [ $count -le $cols_number ]
			do
				### Column name ###
				col_name=$(dialog --title "column Name" --no-cancel --inputbox "Enter Column $count Name "  8 45 3>&1 1>&2 2>&3)

				if [[ $col_name == `cut -d ":" -f1 $table` ]] && [[ $col_name != "" ]]; then

					dialog --title "Creating Column..." --no-cancel --msgbox "$col_name is already exist!" 8 45

				elif [[ $col_name == *['!'@#\$%^\&*().\,\:\;\/\\\"\'\{\}\`\~\-\^\%\$\<\>\?\|+" ""]""["]* ]] || [[ $col_name == [0-9]* ]]; then
					dialog --title "Creating Column..." --no-cancel --msgbox "{$col_name} is not valid name, please try again" 8 45

				elif [[ $col_name != *['!'@#\$%^\&*().\,\:\;\/\\\"\'\{\}\`\~\-\^\%\$\<\>\?\|+" ""]""["]* ]] || [[ $col_name == [0-9]* ]]; then

					if [[ $col_name == "" ]]; then
						col_name="Column $count"
						dialog --title "Creating Column..." --infobox "Column created under $col_name" 8 45
						sleep 1.3	
					fi

					### Data type ###
					datatypeMenu=$(dialog --title "Data Type Menu " --fb --no-cancel --menu "select Data Type" 10 50 3 \
							"1" "int" \
							"2" "str" \
							"3" "boolean" 3>&1 1>&2 2>&3)

					case $datatypeMenu in
						1)
								datatype="int"
								;;
						2)
								datatype="str"
								;;
						3)
								datatype="boolean"
								;;
					esac

					### Add to tables ###
						if [[ $count -eq $cols_number ]]; then
							echo  $col_name >> $table;
							echo  $col_name":"$datatype >> .$table;

						else
							echo -n $col_name":" >> $table;
							echo  $col_name":"$datatype >> .$table;
						fi

					### Primary key ###
					if [[ $isPK -ne 1 ]]; then
						PK_menu=$(dialog --title "Primary Key" --fb --no-cancel --menu "Would you like to create it as a primary_key?" 10 50 2 \
							"1" "Yes" \
							"2" "No" 3>&1 1>&2 2>&3)

						case $PK_menu in
							1)
								isPK=1
								pk="(PK)"
								if [[ $count -eq $cols_number ]]; then
									sed -i '$s/$/'":"$pk'/' .$table;
								else
									sed -i '$s/$/'":"$pk'/' .$table;
								fi
								;;
							2)
								isPK=0 
								;;
						esac

					fi
					
				((count++))
			else
				break
			fi	
		done
		((countp=count-1))
		dialog --title "Creating table..." --infobox "$table table with $countp columns has been created sucessfully" 8 55
		sleep 1
		break
	else
		break
	fi
done
