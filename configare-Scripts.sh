#!/bin/bash 

#for manage permission to be excuted on nay system
#for run script run using ./configare-Scripts.sh "your permission"  
setPermissionForScripts=$1
user=$(whoami)

#give all permission to execute scripts--------------------
if [[ -z  $setPermissionForScripts  ]]
then 

	echo "Warning : set permission for Scripts rwx------ !"
	chmod -R 700 ./*

else 

	echo "Warning : set permission for Scripts $setPermissionForScripts ! "
	chmod -R $setPermissionForScripts ./* 
fi
#Create Cache and Credential files for Enhance Scripts
#---------------------------------------------------------
touch .cache
touch .credential




#Create Files For Privite used by Scripts 
#----------------------------------------------------------
touch .repositoryComponents




