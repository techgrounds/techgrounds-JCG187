# Network 2 Network devices  



## Key-terms
 **Network devices**: Hardware devices that are used to connect computers, printers, fax machines and other electronic devices to a network.
  
**modem**: modulator demodulator. Het is een apparaat wat een computer of router aansluit op het internet. Het converteerd de digitale data van de pc naar analoge data zodat het over een telfoonlijn verstuurd kan worden.   
**router**: koppelt verschillende netwerken aan elkaar. Het routeerd data pakketjes adhv ip adressen. Kan data pakketjes routeren van de LAN (prive netwerk) naar de public netwerken.    
**Switch**: doorgeefluik voor data pakketjes naar andere netwerkapparaten in de LAN. In tegenstelling tot de hub is de switch wel intelligent. De switch onthoudt welk apparaat aan welke port is gekoppeld. Het stuurt pakketjes door adhv de MAC adres. Er zijn ook layer 3 switches die ook kunnen doorsturen advh IP adressen.   
**Hub**: broadcasts data pakketjes door naar alle aangesloten apparaten aan het netwerk. Een hub weet niet welk apparaat welke MAC adres of ip adres heeft en stuurt daarom alle data pakketjes door naar alle apparaten aangesloten op de hub. Dit zorgt voor opstoppingen in het netwerk, waardoor de verbinding langzaam wordt. 
**Hotspot/wireless accesspoint**: Een accesspoint om apparaten via wifi te verbinden met internet ipv met een kabel. Een hotspot wordt voornamelijk gemaakt door een telefoon, een tablet of een hotspot apparaat wat verbinding heeft met het cellulaire netwerk. Het stuurt een wifi signaal waarmee andere apparaten die in de buurt zijn, zich kunnen verbinden om zo op het internet te komen via het cellulaire netwerk van de hotspot. 
**Gateways**: Het is een apparaat wat verschillende netwerken met elkaar verbind die verschillende type netwerken protocollen gebruiken of architectuur. De gateway vertaald de communicatie.   
**Repeater**: herhaalt het datapakket bij verzwakking van het signaal.  
**Bridges**: Verbindt meerderde netwerken met elkaar die ver uit elkaar liggen, om zo een grotere netwerk te vormen. Het voegt meerdere verzamelingen of groepen tot een groot geheel.  Het verbindt verschillende componenten zodat het net lijkt alsof het een netwerk is. Het wordt gebruikt om een data frame, niet de data packet naar de bestemming te vervoeren door gebruik te maken van de meest efficiente route. Het werkt op de data link layer. Net als een hub of een switch. 
**Firewall**: Is een beveiligingsapparaat om ongeoorloofde toegang tot een prive netwerkt tegen te houden of te verminderen. Dit doet het door het data pakketje te onderzoeken. Aan de hand van vooraf ingestelde regels mag een data pakket door of niet.    
**Ethernetcard**: Zorgt dat een apparaat kan verbinden met het netwerk dat gebruik maakt van de Ethernet technologie. Het heeft een MAC adres waarmee het zich identificeert. Het converteerd de binaire data in electrische signalen zodat ze over de netwerkkabel verstuurd kunnen worden. 
 

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

![DHCP](https://user-images.githubusercontent.com/123589199/231160488-b2bcfe3b-ac18-432a-a721-2649f38c425c.png)


