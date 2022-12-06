#!/bin/bash 

user=$(whoami)

if [ -d "/home/$user/Summries-Network-Traffic" ]
then
	cd ~/Summries-Network-Traffic
	echo "directory is found "
	echo "manage New Monitor Screen for Network Traffic " 
	rm -rf ./summery.png
	echo "last Monitor deleted ! " 	
else 
	mkdir -p ~/Summries-Network-Traffic 
	cd ~/Summries-Network-Traffic
	"dir is created and entered" 

fi

vnstati -vs -o /home/$user/Summries-Network-Traffic/summery.png
result=$( echo "$?" )
if [ "$result" -ne 0 ]
then 
	echo "Please Install vnstat previuios" 
else 

	echo "New Monitor Screen Applied " 

fi
