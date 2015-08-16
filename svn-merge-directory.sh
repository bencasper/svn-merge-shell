#/bin/sh
#assume workpath is branch letvcms

#merge files from trunk to branches
#make sure  the filename is passed as a parameter

if [ $# -ne 1 ]
then 
	echo "Please input the filename that u want to merge!"
	exit 1
fi
echo "the file want to be merged is :"$1
#0.define the root path of branches
svn=
letvcms=
echo "path of svn trunk:"$svn
echo "branches of workspace:"$letvcms

#3.find the file under the path $letvcms
cd $letvcms
svn update
filePath=($(find . -type d -name $1))
relfilePath=$(echo $filePath|cut -d'.' -f2,3)
echo "filePath is:"$filePath
fileDir=$(dirname $filePath)
#fileDir=$filePath

#4.display the abosolute path of the file just found,make sure if to merge this file
echo "fileDir"$fileDir

echo "r u sure to merge this file?yes:no"

read sureMerge
echo $sureMerge

if [ $sureMerge != "yes" ]
then
	exit 0				
fi
getSVNVersionFromLog(){
        version=$(echo $1 | awk '{print $2}'|awk -F 'r' '{print $2}')
	echo $version
	
}

mergeFile(){
	filename=$1
	svn=$2
	letvcms=$3
	fileDir=$4
	filePath=$5	

	cd $fileDir

	svnlog=$(svn log $filename)
	#echo $svnlog
	cd $filename
	pwd
	currentVersion=$(getSVNVersionFromLog "$svnlog")
        echo "current svn version is "$currentVersion",svn branch path of this file is:"$svn$relfilePath"   make ur decision(yes|no):"
	read decision
	if [ "$decision" != "yes" ]
	then
		exit 0;
	fi
	svn merge -r $currentVersion:HEAD  $svn$relfilePath
	

}

mergeFile $1 $svn $letvcms $fileDir $filePath

#function of do merge business

#1.cd to the path of file wanted to be merged

#2.svn log --stop-on-copy filename

#set branches version(branchesVersion) of the file from the second row of the log output as 1458

#3.svn update filename

#set trunk new version(trunkVersion) of the file as 1466

#svn merge -r 





