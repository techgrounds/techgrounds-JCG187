# Network 3 Protocols
Network protocols are a set of rules outlining how connected devices communicate across a network to exchange information easily and safely. Protocols serve as a common language for devices to enable communication irrespective of differences in software, hardware, or internal processes.

## opdracht 1
**Application layer protocols**:  
**POP3 (TCP 110)**: Staat voor Post Office Protocol versie 3.Een verouderd protocol dat alleen een download synchronizatie van e-mail toestaat vanaf de e-mail server naar één client. Dit houdt in dat als e-mail op één apparaat wordt gewonload en gelezen, het bij het volgende apparaat waarop het gedownload wordt, het weer als ongelezen wordt gemarkeerd. Ook kan je niet vanaf verschillende apparaten mailen. Deze mailtjes worden niet gesynchroniseerd. Mailtjes worden ook niet automatisch gepushed naar je apparaat. Je moet deze zelf ophalen van de e-mail server. Dit kan allemaal wel met het protocol **IMAP (TCP poort 143)**. IMAP staat voor Internet Message Acess Protocol. Beide protocollen zijn om e-mails op te halen van de mail server. 
**SMTP (TCP 25)** : Staat voor Simple Is een protocol om mail te versturen. 

**presentation layer protocols**:  
**SSL (TCP 443)**: Staat voor Secure Socket Layer. Zorgt ervoor dat data veilig tussen client en server getransporteerd wordt. Dit protocol zorgt ervoor dat de client de identiteit van de server kan controleren. Als de server een digitaal certificaat heeft, dan kunnen je met SSL een veilige communicatie realiseren. SSL zorgt voor de encryptie en decryptie van de data gegevens bij overdracht dmv veiligheidssleutels die overeen gekomen zijn. 

**Session layer protocols**:     
**PPTP (TCP 1723)**: Staat voor Point-To-Point Tunneling protocol.  Deze protocol wordt gebruikt binnen een VPN. Dit is een van de oudste protocollen voor een VPN verbinding en ook het minst veilige. Daarom niet te gebruiken bij de overdracht van gevoelige informatie. Er wordt een verbinding gemaakt via het internet  en alle communicatie is encrypted. De veiligste VPN verbinding is nu **Open VPN**. Deze protocol is compatibel met verschillende encryptie mogelijkheden die nog niet zijn gekraakt. Dit protocol is langzamer dan PPTP. 

**Transport layer protocols**:  
**SCTP (132)**: Staat voor Stream Control Transmission Protocol. Stream Control Transmission Protocol (SCTP) is a transport-layer protocol that ensures reliable, in-sequence transport of data. SCTP provides multihoming support where one or both endpoints of a connection can consist of more than one IP address. This enables transparent failover between redundant network paths.

**Network layer protocols**:  
**ICMP**:Internet Control Message Protocol: Dit protocol bekijkt of er een connectie is met het netwerk en of er problemen zijn met transmissie van data tussen twee apparaten.     

**Data link layer protocols**:  
**Token ring**: Is een topology op de LAN dat data in een richting stuurt langs verschillende nodes met een token.  Door de token heeft die data versturing recht om het netwerk te gebruiken. Andere pakketjes mogen niet gestuurd worden. 

**Physical layer protocols**:    
**bluetooth**: is een draadloze technologie dat gebruik maakt van radio frequenties om kleine stukjes data over een korte afstand te sturen.
  
## opdracht 2
Het internet is een wereldwijd openbaar netwerk van computernetwerken, waarvan de afspraken worden beschreven in de Request for Comments die worden beheerd door de Internet Engineering Task Force. Om het internet goed te laten werken, zijn afspraken gemaakt over protocollen voor gegevensuitwisseling tussen computers. Een van die protocollen is het Internetprotocol (IP).

De oorsprong van het internet is terug te voeren tot ARPANET, een in 1969 in de Verenigde Staten gebouwd netwerk. Inmiddels is het internet een mondiaal fenomeen, dat het karakter van massamedium heeft gekregen. Als een van de succesfactoren wordt wel genoemd dat het **volledige internet eigendom van niemand** is, terwijl de fysieke onderdelen wel degelijk een eigenaar hebben.

In het dagelijkse spraakgebruik wordt met internet vaak het wereldwijde web bedoeld, maar dat is slechts een van de vele diensten die kunnen worden gebruikt via het internet. Andere bekende diensten zijn e-mail, IP-telefonie, FTP en Usenet. 


## opdracht 3


![wireshark](https://user-images.githubusercontent.com/123589199/231421611-a5c46ca7-2dd0-4d06-aa56-8fa894e162cb.png)


Een voorbeeld van een wireshark capture.  
Te zien is het volgende:  
Wat geopend is, is laag 4 van de OSI model, de netwerk laag.   
Hier zie je dat de transmission control protocol wordt gebruikt. De source poort is 49963 en de destination poort is 443.   
Daarboven staat de IPv4 adressen van mij en van de destination node.  
Daarboven staat de mac adressen van mij en van de destinatione node.  
En helemaal boven aan, dat is laag 1 de physical laag staat hoeveel bits er in deze data transmissie zitten. 


## Opdracht
●	Identify several other protocols and their associated OSI layer. Name at least one for each layer.
●	Figure out who determines what protocols we use and what is needed to introduce your own protocol.
●	Look into wireshark and install this program. Try and capture a bit of your own network data. Search for a protocol you know and try to understand how it functions.



### Gebruikte bronnen
poorten:  
https://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers#Well-known_ports

Protocols:   
POP3 en IMAP  
https://support.microsoft.com/en-us/office/what-is-the-difference-between-pop-and-imap-85c0e47f-931d-4035-b409-af3318b194a8

SMPT
https://www.socketlabs.com/blog/smtp-or-imap/  

SSH  
https://www.ibm.com/docs/en/ibm-http-server/9.0.5?topic=communications-secure-sockets-layer-ssl-protocol  

PTPP  
https://www.expressvpn.com/what-is-vpn/protocols/pptp

Open VPN  
https://www.top10vpn.com/what-is-a-vpn/vpn-protocols/    

SCTP  
https://www.scaler.com/topics/computer-network/transport-layer-protocols/

Wie beheert protocollen  
https://nl.wikipedia.org/wiki/Internet  
https://nl.wikipedia.org/wiki/Netwerkprotocol


### Ervaren problemen
geen

### Resultaat
