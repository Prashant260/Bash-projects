#!/bin/bash
#$revision:oo1$
#tue aug 13 22:07:55 ist 2024$


#this script helps us to compress old files 

#variables

BASE=/home/prashant/scripts
DAYS=10
DEPTH=1
RUN=0

#check if the directory is present or not
if [[ ! -d $BASE ]]
then 
	echo "directory does not exist : $BASE"
	exit 1
fi

#create 'archive' folder if not present
if [[ ! -d $BASE/archive ]]
then 
	mkdir $BASE/archive
fi

#finding all the folder more than 20 mb
 
find $BASE -maxdepth $DEPTH -type f -size +20M | while read -r i;

do
        if [[ $RUN -eq 0 ]]
	then
		echo "archiveing $i==>$BASE/archive"
	 	gzip $i || exit 1
	   	mv $i.gz $BASE/archive ||exit 1
	 
	fi
done

