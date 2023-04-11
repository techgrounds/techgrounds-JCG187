# Network 3 Protocols


## Key-terms
**Application layer protocols**:  
**POP3 (TCP 110)**: Staat voor Post Office Protocol versie 3.Een verouderd protocol dat alleen een download synchronizatie van e-mail toestaat vanaf de e-mail server naar één client. Dit houdt in dat als e-mail op één apparaat wordt gewonload en gelezen, het bij het volgende apparaat waarop het gedownload wordt, het weer als ongelezen wordt gemarkeerd. Ook kan je niet vanaf verschillende apparaten mailen. Deze mailtjes worden niet gesynchroniseerd. Mailtjes worden ook niet automatisch gepushed naar je apparaat. Je moet deze zelf ophalen van de e-mail server. Dit kan allemaal wel met het protocol **IMAP (TCP poort 143)**. IMAP staat voor Internet Message Acess Protocol. Beide protocollen zijn om e-mails op te halen van de mail server. 
**SMTP (TCP 25)** : Staat voor Simple Is een protocol om mail te versturen. 

**presentation layer protocols**:  
**SSL (TCP 443)**: Staat voor Secure Socket Layer. Zorgt ervoor dat data veilig tussen client en server getransporteerd wordt. Dit protocol zorgt ervoor dat de client de identiteit van de server kan controleren. Als de server een digitaal certificaat heeft, dan kunnen je met SSL een veilige communicatie realiseren. SSL zorgt voor de encryptie en decryptie van de data gegevens bij overdracht dmv veiligheidssleutels die overeen gekomen zijn. 

**Session layer protocols**:     
**PPTP (TCP 1723)**: Staat voor Point-To-Point Tunneling protocol.  Deze protocol wordt gebruikt binnen een VPN. Dit is een van de oudste protocollen voor een VPN verbinding en ook het minst veilige. Daarom niet te gebruiken bij de overdracht van gevoelige informatie. Er wordt een verbinding gemaakt via het internet  en alle communicatie is encrypted. De veiligste VPN verbinding is nu **Open VPN**. Deze protocol is compatibel met verschillende encryptie mogelijkheden die nog niet zijn gekraakt. Dit protocol is langzamer dan PPTP. 

**Transport layer protocols**:  
**SCTP (**: Staat voor Stream Control Transmission Protocol. Het zorgt ervoor dat er een betrouwbaar transport van dat is op volgorde van verzenden. 



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



### Ervaren problemen
geen

### Resultaat
