
          "dMMMb   dMP  dMMMMb   dM"
         dMP" VP  amr  dMP'dMP  dMP
         "MMMb   dMP  dMMMMK   dM"
       dP .dMP  dMP  dMP.aMF  dMP
       "MMMP'  dMP  dMMMMP'  dMMMMM"
      Shodan IP Block List (SIBL) v0.2

             - whoisbyip.com -

<b>Requirements:</b><br>
Shodan CLI - https://cli.shodan.io/<br>
The current list of IPs used by shodan *Optional

<b>Inteded Use:</b>
Used to generate a list of IPs used by shodan that scan hosts. The script will start a tcpdump session that will listen for new VNC connections, after starting the dump it will initate a scan request to shodan.io logging the IP address that attempts to connect. 

<b>Isnt blocking shodan sticking your head in the sand?</b>
Yes, it is if you are exposing equipment to the internet it will be vulnerable blocking shodan does not fix this. However you would not let users run nmap on the inside of your network so why would you let them do it to the outside. Below is a nifty diagaram of how shodan is used by its userbase:
<pre>
       /\
      /__\ < Actual Infosec
     /    \ 
    /      \
   /        \
  /  ABUSE   \ 
 /            \
/______________\
</pre>
For this reason I find it would be useful to keep a up to date list of IP addresses or scanners that shodan is using. Plus it is interesting to do.

<b>You just said blocking shodan wont fix my equipment so why would I bother logging IPs?</b>
Since the script logs only the IP address that comes from a user iniated scan, you are only blocking the IP addresses that would be used from other users from manually scanning your network using the shodan cli. For a complete list of all IPs see the bottom question.

<b>How can you gaurentee these are shodan IP addresses?</b>
Easy shodan wont let you use shodan to check one of its own IPs, the search will either censor out the IP like this:
xxx.xxx.xxx.xxx or show you a custom 404 page when you attempt to access the scanner. This tool also uses the host utility to check the dns name of the IP address. The tcpdump is set to run for only 60 seconds and the longest a shodan scan usually takes is 10 seconds. While I have gotten false IPs in my tcpdump they all resolved to chineese scanners looking for open VNC sessions.

<b>Do you have a block list of shodan IPs?</b>
Yes they are hosted at romcheckfail.com/URL and whoisbyip.com/URL


