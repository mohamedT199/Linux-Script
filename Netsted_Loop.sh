#!/bin/bash 


params=$*

paramsNumber=$# 
echo "this loop count the number of paramter under your choise yes/no  "
echo "the number of params is : $paramsNumber"  
i=1
addr=1 
while [ "$paramsNumber" -gt 0 ]  
do 
	for parm in $params 
	do
		#echo "params number :  $#"
		#echo "params is : $* " 
	        echo "paramter is $parm" 	
		echo "parmeter number is : $i" 
		i=$(($i+1))
		paramsNumber=$(($paramsNumber-1))
		break 
	done
	echo "the number of paramter you enter is $i "
	read -p "enter if you need to continue this loop " answer 
	if [ "$answer" != yes ]
	then 	
		echo "number of params form bash that can be alternative bu ansabile or python $# " 
		break 
	fi
done





