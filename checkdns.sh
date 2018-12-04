#!/bin/sh
echo $PWD
for HOSTNAME in `cat DomainNames.txt` 
do 
echo "Name servers of [$HOSTNAME]" 
nslookup $HOSTNAME 
done
