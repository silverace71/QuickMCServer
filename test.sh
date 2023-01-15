#!/bin/bash

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="Backtitle here"
TITLE="Title here"
MENU="Choose one of the following options:"

OPTIONS=(1 "Option 1"
         2 "Option 2"
         3 "Option 3")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        1)
            echo "You chose Option 1"
            ;;
        2)
            echo "You chose Option 2"
            ;;
        3)
            echo "You chose Option 3"
            ;;
esac






clear
dialog -- backtitle ""




#!/bin/bash

# Declare an array of options with the same number of elements as the number of options you want to present
options=("Option 1" "Option 2" "Option 3" "Quit")

# Set the prompt for the select command
PS3="Enter your choice: "

# Use the select command to display the menu
select opt in "${options[@]}"; do

    # Case statement for each option
    case $opt in
        "Option 1")
            
            ;;
        "Option 2")
            echo "You chose option 2"
            ;;
        "Option 3")
            echo "You chose option 3"
            ;;
        "Quit")
            break
            ;;
        *) echo "Invalid option";;
    esac
    ./5.sh
done
