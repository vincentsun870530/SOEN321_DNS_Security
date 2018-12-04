#!/bin/sh
#echo $PWD
#Please add name in DomainNames.txt
for HOSTNAME in `cat DomainNames.txt` 
do 
echo "Name servers of [$HOSTNAME]" 
nslookup $HOSTNAME 
done
