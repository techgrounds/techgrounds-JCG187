# Network 2 Network devices  
Network devices zijn: Hardware devices that are used to connect computers, printers, fax machines and other electronic devices to a network.
  
modem: modulator demodulator  
router: koppelt verschillende netwerken aan elkaar. Het routeerd data pakketjes adhv ip adressen. Kan data pakketjes routeren naar de externe netwerken.    
Switch: doorgeefluik voor datapakketjes naar andere gerichte netwerkapparaten in de LAN. In tegenstelling tot de hub is de switch wel intelligent. De switch onthoudt welk apparaat aan welke port is gekoppeld. Hiermee Het stuurt pakketjes door adhv de MAC adres. Er zijn ook layer 3 switches die ook kunnen doorsturen advh IP adressen.   
Hub: broadcast data pakketjes door naar alle aangesloten apparaten aan het netwerk. Een hub weet niet welk apparaat welke MAC heeft. Dit zorgt voor opstoppingen in het netwerk.
Hotspot: Een accesspoint om met wifi verbonden apparaten te verbinden met internet.  
Gateways: Het is een single access point om verschillende  type netwerken met elkaar te verbinden en de verschillende protocollen te vertalen en door te geven.   
Repeater: herhaalt het datapakket bij verzwakking van het signaal.  
Bridges: Verbindt meerderde LAN's samen om zo een grotere LAN te vormen. Het voegt meerdere verzamelingen of groepen tot een groot geheel.  Het verbindt verschillende componenten zodat het net lijkt alsof het een netwerk is. Het wordt gebruikt om een frame, niet de packet naar de bestemming te vervoeren door gebruik te maken van de meest efficiente route
Firewall: Is een beveiligingsapparaat om ongeoorloofde toegang tot een prive netwerkt tegen te houden of te verminderen.    
Ethernetcard: Zorgt dat een apparaat kan verbinden met het netwerk. Zowel een wificard als een Ethernetcard kan data klaarmaken voor transport en het beheerd de stroom aan dat verzonden wordt en controleerd de datastroom.  




## Key-terms
 
DHCP: Dynamic Host Configuration Protocol: geeft automatisch het IP adres aan alle apparaten in de LAN. 

## Opdracht
-	Benoem en beschrijf de functies van veel voorkomend netwerkapparatuur
-	De meeste routers hebben een overzicht van alle verbonden apparaten, vind deze lijst. Welke andere informatie heeft de router over aangesloten apparatuur?
-	Waar staat je DHCP server op jouw netwerk? Wat zijn de configuraties hiervan?


### Gebruikte bronnen

https://www.tutorialspoint.com/communication_technologies/communication_technologies_network_devices.htm  
https://www.lepide.com/blog/the-most-common-types-of-network-devices/  


### Ervaren problemen
geen

### Resultaat
  
**vraag**:  De meeste routers hebben een overzicht van alle verbonden apparaten, vind deze lijst. Welke andere informatie heeft de router over aangesloten apparatuur?   

**antwoord**:De router heeft een overzicht van apparaten verbonden via ethernet, wifi en Voip. Het geeft de IP adressen aan van de apparaten en de naam van de apparaten. Zie schermprint:


![aangesloten apparaten op router](https://user-images.githubusercontent.com/123589199/231149929-ea84f75a-6f48-4efd-b52a-e4924048c10c.png)



**vraag**: Waar staat je DHCP server op jouw netwerk? Wat zijn de configuraties hiervan?
**antwoord**:  De DHCP server is de router. Het netwerk is 192.168.2.0/24 netwerk. De op adressen 192.168.2.1 tot en met 192.168.1.200 kunnen verstrekt worden aan apparaten in de LAN. Zie schermprint:

