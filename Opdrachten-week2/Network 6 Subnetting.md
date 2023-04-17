# Network 6 Subnetting


## Key-terms
Subnetting: Is het proces van het verdelen van grotere netwerken in meerdere kleinere netwerken. Hiervoor gebruik je het subnetmask en de CIDR notatie. Een IP adres laat met behulp van het subnetmask zien welk gedeelte voor het netwerk wordt gebruikt en welk gedeelte voor de host. 

CIDR notatie: Staat voor Clasless Inter-Domain Routing. Het wordt gebruikt om IP adressen aan te duiden. Met CIDR kan op elke bit nivo aangegeven worden welk gedeelte van het IP adres gebruikt wordt voor het netwerk.   

In je interne netwerk kan je gebruik maken van onderstaande prive IP adressen om toe te kennen aan al je apparatuur. Deze IP adressen zijn niet routeerbaar op het publieke netwerk.   
Het IP adres 127.0.0.0

Private address range:   
10.0.0.0/8 IP addresses: 10.0.0.0 – 10.255.255.255  
172.16.0.0/12 IP addresses: 172.16.0.0 – 172.31.255.255    
192.168.0.0/16 IP addresses: 192.168.0.0 – 192.168.255.255





## Opdracht
●	Maak een netwerkarchitectuur die voldoet aan de volgende eisen:  
○	1 private subnet dat alleen van binnen het LAN bereikbaar is. Dit subnet moet minimaal 15 hosts kunnen plaatsen.  
○	1 private subnet dat internet toegang heeft via een NAT gateway. Dit subnet moet minimaal 30 hosts kunnen plaatsen (de 30 hosts  
    is exclusief de NAT gateway).  
○	1 public subnet met een internet gateway. Dit subnet moet minimaal 5 hosts kunnen plaatsen (de 5 hosts is exclusief de   
    internet gateway).  
●	Plaats de architectuur die je hebt gemaakt inclusief een korte uitleg in de Github repository die je met de learning coach   
    hebt gedeeld.


### Gebruikte bronnen
subnetcalculator  
https://www.calculator.net/ip-subnet-calculator.html?cclass=c&csubnet=26&cip=192.168.0.0&ctype=ipv4&printit=0&x=44&y=14

uitleg over hoe te subnetten  
https://www.youtube.com/watch?v=mJ_5qeqGOaI&list=PLIhvC56v63IKrRHh3gvZZBAGvsvOhwrRF&index=9

### Ervaren problemen
Ik dacht dat we variable subnet masking moesten toepassen, maar dat bleek niet zo te zijn. De opdracht was daardoor moeilijker dan gedacht.

### Resultaat  

In de diagram heeft de router het netwerk 192.168.0.0/24. Het netwerk is opgesplitst in 4 netwerken, maar er zijn er maar 3 nodig voor de opdracht. De nieuwe netwerken krijgen een /26 als CIDR notatie. Hierdoor kan je 2 bits stelen van de host gedeelte. Daarmee creeer je 4 subnets. Alle subnetten zijn verbonden met de router. Alle subnetten hebben genoeg IP adressen om aan hosts te geven. Per subnet zijn  er 62 IP adressen beschikbaar om uit te delen. Genoeg voor wat is gespecificeerd in de opracht. De router vertaald via NAT het interne IP adres naar een externe IP adres. Dit zorgt ervoor dat de interne netwerk met het exteren netwerk kan communiceren. De router is de gateway naar het public internet. 
