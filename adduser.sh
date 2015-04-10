#!/bin/bash
#this is just a POC for me to setup deluge on my server
#any on this script may be problem on your setup
#distribute under MIT license.
if [ $USER != 'root' ]; then
	echo "Sorry, you need to run this as root"
	exit
fi


addgroup HR
addgroup Engineering
addgroup IT
addgroup Finance

while :
do
clear
	echo "Please provide all the information that is requested"
	echo ""
	if [ $(id -u) -eq 0 ]; then
		read -p "Enter username : " username
		read -s -p "Enter password : " password
		egrep "^$username" /etc/passwd >/dev/null
		if [ $? -eq 0 ]; then
			echo "$username exists!"
			exit 1
		else
			pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
			useradd -m -p $pass $username
			[ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
		fi
	else
		echo "Only root may add a user to the system"
		exit 2
	fi
	
	echo "Group:"
	echo "1)HR"
	echo "2)Engineering"
	echo "3)IT"
	echo "4)Finance"
	read -p "Select an option [1-4]:" option
	
	if [ $option = 1 ]; then $group = "HR"
	elif [ $option = 2 ]; then $group = "Engineering"
	elif [ $option = 3 ]; then $group = "IT"
	elif [ $option = 4 ]; then $group = "Finance"
	else
	echo "Please select from the list!"
	fi
done

useradd -G $group $username
