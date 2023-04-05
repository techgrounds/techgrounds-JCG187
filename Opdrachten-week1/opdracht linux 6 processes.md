# Linux 6 Processes


## Key-terms
 daemons: speciale services die in de achtergrond draaien zodat programma's uitgevoerd kunnen worden. Een daemon service heeft altijd een d achter de naam staan. Zoals sshd. Je kan een lijst van services oproepen via 

inetd en xinetd: beide zijn daemons services en zorgen ervoor dat telnet uitgevoerd kan worden. inetd (internet daemon) is voor ftp, pop3 en telnet. xinetd (extended internet daemon) is voor ftp of telnet.
in de folder zit de folder etc/inetd.conf of etc/xinetd.conf. 

geleerd dat je met de commando sudo bash root gebruiker wordt. via de commando exit bash ga je er weer uit. 

## Opdracht
●	Start the telnet daemon.

●	Find out the PID of the telnet daemon.

●	Find out how much memory telnetd is using.

●	Stop or kill the telnetd process.



### Gebruikte bronnen
https://www.javatpoint.com/linux-daemon: wat is daemons

https://www.youtube.com/watch?v=wOWhfNB_r-0  : info over daemons en commands

https://www.cyberciti.biz/faq/how-to-tell-if-your-linux-server-uses-xinetd-or-inetd-sever/ 

https://www.baeldung.com/linux/telnet : telnet is inetd

### Ervaren problemen
Het duurde even voordat ik doorhad dat inetd/xinetd de service was voor telnet. Uiteindelijk gevonden door te zoeken naar is inetd of xinetd hetzelfde als telnet. 

### Resultaat
