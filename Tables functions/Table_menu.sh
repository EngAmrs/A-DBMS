#!/bin/bash

function Table_menu (){

Table_menu=$(dialog --title "Table options" --fb --menu "select... :" 17 60 0\
                                "1" "Create Table" \
                                "2" "List Tables" \
                                "3" "Drop Table" \
                                "4" "Insert Into Table" \
                                "5" "Select from Table" \
                                "6" "Delete from Table" \
                                "7" "Update Table" \
                                "8" "Back to DBMS menu" 3>&1 1>&2 2>&3)

                        case $Table_menu in
                                


                                8)
                                        cd ../../
                                        ;;
                                *)
                                        cd ../../
                                        ;;
                        esac
}

Table_menu