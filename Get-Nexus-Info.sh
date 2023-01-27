#!/bin/bash 

#Script used for download spacific artifact from nexus artifact repository manager 

# run this script using ./   "repo name"   "nexus server ex: 192.168.1.2:8080 ex: example.nexus.com" "nexus user " "nexus password"  

repoName=$1
nexusApi=$2
nexusUser=$3 
nexusPass=$4 
credentialFile=./.credential

checkCachedCred=$(cat .credential | grep -i nexusUsername | cut -d= -f 1 )
if [[  $checkCachedCred == NexusUsername   ]]
then 
	nexusApi=$(grep -i  nexusapi .credential | cut -d= -f 2 | cut -d\' -f 2 )
	nexusUser=$(grep -i  nexususer .credential | cut -d= -f 2 | cut -d\' -f 2 )
	nexusPass=$(grep -i  nexuspass .credential | cut -d= -f 2 | cut -d\' -f 2  )
	repoName=$(grep -i nexuscache .cache | cut -d= -f 2 | cut -d\' -f 2 )

else
	read -p "Enter User Name of Nexus :" nexusUser
	echo "NexusUsername='$nexusUser'" >> .credential
	read -p "Warning(Password not shared with anyone) Enter Password:" nexusPass
	echo "NexusPassword='$nexusPass'" >> .credential
	read -p "Enter Nexus URL: example(192.168.1.X:8080):" nexusApi
	echo "NexusApi='$nexusApi'" >> .credential
	read -p "Enter Repository Name: " repoName
	echo "NexusCache='$repoName'" > .cache

fi 
#echo $nexusPass
#echo $nexusUser
#echo $nexusApi

#-------------------------------------------------------------------------------
#nexus get artifact 
curl -u $nexusUser:$nexusPass -X GET "http://$nexusApi/service/rest/v1/components?repository=$repoName" 1> .repositoryComponents
listGroups=$(grep -i '\"group\"' --after-context=1  .repositoryComponents )
artifact="x"
#listNames=$(grep -i '\"name\"' .repositoryComponents | cut -d: -f 2 | cut -d \" -f 2 )
#echo $listGroups
#echo $listNames






function download_asset() {
groupName=$1
artifactName=$2
echo $groupName
echo $artifactName
	componentLocation=$(grep -i "\"group\" : $groupName," --after-context=4 .repositoryComponents | grep -i "\"name\" : $artifactName," --after-context=4  )
	downloadLink=$(echo $componentLocation | grep -i downloadUrl | cut -d{ -f 2 | cut -d, -f 1 | cut -d\" -f 4  )

	echo $downloadLink

	wget --no-check-certificate --user=$nexusUser --password=$nexusPass "$downloadLink" 

}





function assets_names() {
	readReq=7
	group=1
	groupValue=3
	name=4
	nameValue=6
	choosesGroup="x"
	choosesName="x"
	itr=1
	for group in $listGroups
	do
		
		if [[ itr -eq $groupValue  ]] 
		then 
			echo " \"group\" : $group "
			choosesGroup=$group
			groupValue=$(($groupValue+7))
		elif [[ itr -eq $nameValue  ]]
		then 
			echo " \"name\" : $group" 
			choosesName=$group
			nameValue=$(($nameValue+7))
		elif [[ itr -eq $readReq ]] 
		then 
			read -p "Warning : Download Artifact (yes/no):" artifact
			readReq=$(($readReq+7))
			echo -n "prepare"
			sleep 1
			echo -n "."
			sleep 2 
			echo -n "." 
			sleep 1
			echo -n "."
		        sleep 2 
			echo "."
			sleep 1
		        arr=()
			arr=$listGroups
			echo ${listGroups[@]}	
			length=${#arr[@]}
			length=$(($length-1))
			echo $length 	
			if [[ $itr -eq $length  || $artifact == yes ]]
			then
				artifact=" \"group\" : $choosesGroup , \"name\" : $choosesName "
				groupName=$(echo $artifact | cut -d, -f 1 | cut -d: -f 2  )
				artifactName=$(echo $artifact | cut -d, -f 3 | cut -d: -f 2  )
				echo $groupName
				echo $artifactName
				download_asset $groupName $artifactName
		  
			fi
		fi
		itr=$(($itr+1))	
	done 

	echo $choosesName
	echo $choosesGroup 
	artifact=" \"group\" : $choosesGroup , \"name\" : $choosesName "
        	


}


assets_names




