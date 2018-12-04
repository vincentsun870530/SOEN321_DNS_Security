#!/bin/bash
read -p "Enter the txt file to analyze: " x;
read -p "Enter result output txt file: " y;

printf > $y;
echo These domains are blocked: >> $y;
numOfDomains=0;
numOfDomainsBlocked=0;
for i in `cat $x`; 
do 
let "numOfDomains++";
domainLookupOutput=$(nslookup $i);
domainName=$(echo "$domainLookupOutput" | grep ^Name | awk '{print $2}');
domainAddress=$(echo "$domainLookupOutput" | grep ^Address | awk '/Address/{i++}i==2{print $2}');
addressLookupOutput=$(nslookup "$domainAddress");
redirect=$(echo "$addressLookupOutput" | grep "name = " | awk '{print $4}');
if [ "$redirect" == "hit-adult.opendns.com." ] || [ "$redirect" == "safe2.yandex.ru." ]
then
  let "numOfDomainsBlocked++";
  echo "$domainName" >> $y;
fi
done
printf "%d/%d domains got blocked" "$numOfDomainsBlocked" "$numOfDomains" >> y;