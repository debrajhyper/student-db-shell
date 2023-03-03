#!/bin/sh

# Reset
RESET_COLOR='\033[0m'

# Regular Colors
BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'

echo -e $GREEN"******************************************* STUDENT DATABASE *******************************************"$RESET_COLOR

declare -A student
current_roll=1
tableHeader="Roll\tName\tClass\tSection\tTransport\n"

addStudent() {
	echo -e $CYAN"=================== 💧Add Student Details ==================="$RESET_COLOR
	read -p "$(echo -e $CYAN"-> Enter Student Name : "$RESET_COLOR)" name
	read -p "$(echo -e $CYAN"-> Enter Student Class : "$RESET_COLOR)" class
	read -p "$(echo -e $CYAN"-> Enter Student Section : "$RESET_COLOR)" section
	read -p "$(echo -e $CYAN"-> Enter Transport Mode : "$RESET_COLOR)" transport

	student[$current_roll]="$name|$class|$section|$transport"

	echo -e $GREEN"✅Student successfully added with roll no : $current_roll"$RESET_COLOR
	((current_roll++))
}

viewAllStudents() {
	echo -e $CYAN"==================== 🌈View All Students ===================="$RESET_COLOR
	if [ ${#student[@]} -eq 0 ]
	then
		echo -e $RED"No students found!"$RESET_COLOR
	else
		rows=""
		for roll in ${!student[@]}
		do
			roll=$roll
  			name=$(echo "${student[$roll]}" | cut -d '|' -f 1)
  			class=$(echo "${student[$roll]]}" | cut -d '|' -f 2)
			section=$(echo "${student[$roll]]}" | cut -d '|' -f 3)
			transport=$(echo "${student[$roll]]}" | cut -d '|' -f 4)
  			rows="${rows}${roll}\t${name}\t${class}\t${section}\t${transport}\n"
		done
		echo -e $YELLOW
		echo -e "${tableHeader}${rows}" | column -t
		echo -e $RESET_COLOR
	fi
}

viewStudentByRoll() {
	echo -e $CYAN"================== 🌊View Student by Roll =================="$RESET_COLOR
	read -p "$(echo -e $CYAN"-> Enter student roll number : "$RESET_COLOR)" roll
	
	if [[ ${student[$roll]+exists} ]]
	then
		rows=""
			roll=$roll
                	name=$(echo "${student[$roll]}" | cut -d '|' -f 1)
                	class=$(echo "${student[$roll]]}" | cut -d '|' -f 2)
                	section=$(echo "${student[$roll]]}" | cut -d '|' -f 3)
                	transport=$(echo "${student[$roll]]}" | cut -d '|' -f 4)
                	rows="${rows}${roll}\t${name}\t${class}\t${section}\t${transport}\n"
		echo -e $YELLOW
		echo -e "${tableHeader}${rows}" | column -t
		echo -e $RESET_COLOR
	else
		echo -e $RED"Sorry, roll number $roll not found!"$RESET_COLOR
	fi
}

modifyStudent() {
	echo -e $CYAN"================= ⚡Modify Student Details ================="$RESET_COLOR
	read -p "$(echo -e $CYAN"-> Enter student roll number to modify : "$RESET_COLOR)" roll

        if [[ ${student[$roll]+exists} ]]
        then
		read -p "$(echo -e $CYAN"-> Enter Student Name : "$RESET_COLOR)" name
        	read -p "$(echo -e $CYAN"-> Enter Student Class : "$RESET_COLOR)" class
        	read -p "$(echo -e $CYAN"-> Enter Student Section : "$RESET_COLOR)" section
        	read -p "$(echo -e $CYAN"-> Enter Transport Mode : "$RESET_COLOR)" transport

        	student[$roll]="$name|$class|$section|$transport"
        	
		echo -e $GREEN"✅Student successfully modified for roll no : $roll"$RESET_COLOR
        else
                echo -e $RED"Sorry, roll number $roll not found!"$RESET_COLOR
        fi
}

deleteStudent() {
	echo -e $CYAN"===================== 🔥Delete Student ====================="$RESET_COLOR
        read -p "$(echo -e $CYAN"-> Enter student roll number to detele : "$RESET_COLOR)" roll

        if [[ ${student[$roll]+exists} ]]
        then
                unset student[$roll]

		echo -e $GREEN"✅Student successfully deleted for roll number : $roll"$RESET_COLOR
        else
                echo -e $RED"Sorry, roll number $roll not found!"$RESET_COLOR
        fi
}

quit() {
	echo -e $RED"Exiting Application..."$RESET_COLOR
	echo -e $PURPLE"Bye! Bye! C U again 💜"$RESET_COLOR
	echo
}

while true
do
	echo
	echo -e $CYAN"============================================================="$RESET_COLOR
	echo "1. 💧Add student"
        echo "2. 🌈View all students"
	echo "3. 🌊View student by roll number"
	echo "4. ⚡Modify student details"
	echo "5. 🔥Delete student"
	echo "6. 💔Quit"
	read -p "$(echo -e $CYAN"-> Enter Choice : "$RESET_COLOR)" choice
	echo

	case $choice in
		1) addStudent ;;
		2) viewAllStudents ;;
		3) viewStudentByRoll ;;
		4) modifyStudent ;;
		5) deleteStudent ;;
		6) quit; exit 0 ;;
		*) echo -e $RED"Wrong input! Please enter a valid input 🙏"$RESET_COLOR ;;
	esac
done

