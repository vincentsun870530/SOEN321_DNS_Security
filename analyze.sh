#!/bin/bash
printf > nortonPornBlacklist.txt;
echo These domains are blocked: >> nortonPornBlacklist.txt;
numOfDomains=0;
numOfDomainsBlocked=0;
for i in `cat filteredPornDomains.txt`; 
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
  echo "$domainName" >> nortonPornBlacklist.txt;
fi
done
printf "%d/%d domains got blocked" "$numOfDomainsBlocked" "$numOfDomains" >> nortonPornBlacklist.txt;