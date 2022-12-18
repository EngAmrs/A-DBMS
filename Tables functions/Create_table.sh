#!/bin/bash
typeset -i isPK=0
pk=""
datatype=""
count=1
fasel=":"

while true
do

table=$(dialog --title "Creating table..." --inputbox "Enter the table name" 9 50 3>&1 1>&2 2>&3)

if [[ -f $table ]] && [[ $table != "" ]]; then
dialog --title "Creating table..." --msgbox "$table is already exist!" 9 50

elif [[ $table == *['!'@#\$%^\&*().\,\:\;\/\\\"\'\{\}\`\~\-\^\%\$\<\>\?\|+" ""]""["]* ]] || [[ $table == [0-9]* ]] || [[ $table == "" ]]; then
	dialog --title "Creating table..." --msgbox "{$table} is not valid name, please try again" 9 50

else
	cols_number=$(dialog --title "Creating columns..." --inputbox "Enter column number" 9 50 3>&1 1>&2 2>&3)
	touch $table
	touch .$table
	while [ $count -le $cols_number ]
		do
			
				col_name=$(dialog --title "column Name" --inputbox "Enter Column $count Name "  9 50 3>&1 1>&2 2>&3)
				
				datatypeMenu=$(dialog --title "Data Type Menu " --fb --menu "select Data Type" 15 60 4 \
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


			if [[ $isPK -ne 1 ]]; then
				PK_menu=$(dialog --title "Primary Key" --fb --menu "Would you like to create it as a primary_key?" 20 50 4 \
					"1" "Yes" \
					"2" "No" 3>&1 1>&2 2>&3)

				case $PK_menu in
					1)
						isPK=1
						pk="(PK)"
						if [[ $count -eq $cols_number ]]; then
							echo  $col_name >> $table;
							echo  $col_name":"$datatype":"$pk >> .$table;

						else
							echo -n $col_name":" >> $table;
							echo  $col_name":"$datatype":"$pk >> .$table;
						fi
						;;
					2)
						isPK=0 
						;;
				esac

			else
				if [[ $count -eq $cols_number ]]; then
					echo  $col_name >> $table;
					echo  $col_name":"$datatype >> .$table;

				else
					echo -n $col_name":" >> $table;
					echo  $col_name":"$datatype":" >> .$table;
				fi

			fi

			
		((count++))
	done
dialog --title "Create table" --infobox "$tableName table has been created sucessfully" 9 50
sleep 1
break

fi
done
