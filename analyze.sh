#!/bin/bash
printf > domains_ip.txt;
echo These domains are blocked: >> domains_ip.txt;
numOfDomains=0;
numOfDomainsBlocked=0;
for i in `cat domains.txt`; 
do 
let "numOfDomains++";
domainLookupOutput=$(nslookup $i);
domainName=$(echo "$domainLookupOutput" | grep ^Name | awk '{print $2}');
domainAddress=$(echo "$domainLookupOutput" | grep ^Address | awk '/Address/{i++}i==2{print $2}');
addressLookupOutput=$(nslookup "$domainAddress");
redirect=$(echo "$addressLookupOutput" | grep "name = " | awk '{print $4}');
if [ "$redirect" == "hit-adult.opendns.com." ]
then
  let "numOfDomainsBlocked++";
  echo "$domainName" >> domains_ip.txt;
fi
done
printf "%d/%d domains got blocked" "$numOfDomainsBlocked" "$numOfDomains" >> domains_ip.txt;