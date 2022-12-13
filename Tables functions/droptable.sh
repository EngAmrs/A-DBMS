#!/bin/bash

while true
do

droptable=$(dialog --title "Delete Table" --inputbox "Enter table name" 8 45 3>&1 1>&2 2>&3)

if [[ -f $droptable ]] && [[ $droptable != "" ]]; then

	rm $droptable
	rm .$droptable
	dialog --title "Delete table Message" --msgbox "You deleted table { $droptable } sucessfully" 8 45
	break

elif [[ ! -f $droptable ]] && [[ $droptable != "" ]]; then

	dialog --title "Delete table Message" --msgbox "Not found table name { $droptable } please try again" 8 45

else 
	break
fi

done 
