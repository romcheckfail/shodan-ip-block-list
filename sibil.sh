#
#          "dMMMb   dMP  dMMMMb   dM"
#         dMP" VP  amr  dMP'dMP  dMP
#         "MMMb   dMP  dMMMMK   dM"
#       dP .dMP  dMP  dMP.aMF  dMP
#       "MMMP'  dMP  dMMMMP'  dMMMMM"
#          Shodan IP Block List v0.2
#
#             - whoisbyip.com -

#Gather your current IP from shodan so you can sanatize the file
#Scan IP may differ depending on if you are running on the same host or not
wanip=$(shodan myip)
echo External IP is: $wanip
#Start a TCP dump for 60 seconds and then start the shodan scan on the host
timeout 60 /usr/sbin/tcpdump -ni any port 5901 >> tcpdump.txt &
#Start the shodan scan
sleep 10 ; /usr/local/bin/shodan scan submit $wanip >> shodanlogs.txt
date +"%d-%m-%y %T" >> shodanlogs.txt
wait
#Get all the IP addresses out of the generated log
grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' tcpdump.txt >> newips.txt
#Remove the localhost IP addresses
sed '/'$wanip'/d' newips.txt >> ShodanIPsOnly.txt
tail ShodanIPsOnly.txt >> ShodanIPOnly.lst
#Get the DNS address for those hosts in the file
cat ShodanIPsOnly.txt | xargs -I % bash -c 'echo "%:$(host %)"' >> DNSlist.txt
#Clean up the DNS list a little
grep -Eo ' pointer .*' DNSlist.txt >> DNStrimmed.txt
#Export into a somwhat formatted list
paste -d '' ShodanIPsOnly.txt DNStrimmed.txt >> final.txt
#Replace the word ' pointer ' with a comma , trim the trailing period
sed -i 's/ pointer /\,/g' final.txt
sed 's/.$//' final.txt >> ShodanIPList.txt
#Remove duplicates from the list of servers
sort ShodanIPList.txt | uniq >> ShodanList.lst
#Make a IP Block or Drop list
sort ShodanIPsOnly.txt | uniq >> IPDropList.lst
#Clean up all the worker files leaving just the .lst
rm *.txt