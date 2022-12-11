#!/bin/bash 

user=$(whoami)
day=$(date +%F )
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

vnstati -vs -o /home/$user/Summries-Network-Traffic/Network-$day-Staticties.png

result=$( echo "$?" )

distro=$( lsb_release -i | cut -d: -f2 | sed s/'^\t'// | tr [:upper:] [:lower:] )

if [ "$result" -ne 0 ]
then 
	read -p "need to install vnstat to monitor the Network (yes / no )" request 

	if [ "$request" == "yes" ]
	then
		if [[ "$distro" == "ubuntu"  ||  "$distro" == "kubuntu" || "$distro" == "kali"  ]]
		then 
			echo "Install Start "  
			sudo apt install vnstat
			sudo apt install vnstati
			vnstati -vs -o /home/$user/Summries-Network-Traffic/Network-$day-Staticties.png
			echo "New Monitor Screen Applied " 

		elif [[ "$distro" == "redhat" || "$distro" == "fedora" || "$distro" == "rokey" ]]
		then 
			echo "Install Start " 
			sudo yum install vnstat
			vnstati -vs -o /home/$user/Summries-Network-Traffic/Network-$day-Staticties.png
			echo "New Monitor Screen Applied " 

		fi
	else
		echo "PLease instal then Manage Network Traffic"
		
	fi	
	 	 	
else 

	echo "New Monitor Screen Applied " 

fi
