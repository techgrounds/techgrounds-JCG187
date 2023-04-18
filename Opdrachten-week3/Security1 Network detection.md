# Network Detection
**Opdracht 1**
Opgezocht wat Nmap is.  
Een tutorial bekijken.   
De scan gedaan met gebruik van Nmap.  
**Opdracht 2**  
Wireshark geopend.
In wireshark geselecteerd op http verkeer.    
In de edge browser www.microsoft.com ingevoerd.   
Daarna een capture gedaan naar www.bol.com.
Bij beide kwamen de protocollen HTTP en OCSP naar voren als in de filterbalk http is ingevoerd. 





## Key-terms
Nmap: Staat voor Network Mapper. Het is een command tool wat gebruikt wordt om IP adressen en poorten in het netwerk te scannen en om geinstalleerde applicaties te detecteren. Het zorgt ervoor dat een admin weet welke apparaten er op hun netwerk zitten, welke poorten en services open zijn en of er zwakheden zijn. 

**Handige command zijn:** 
Scan hele netwerk: nmap -sP 10.171.154.0/24
Scan je eigen computer met de tcp handshake uitgezonderd de laatste stap. En zie welke poorten open zijn (de eerste 1000): nmap -sT 10.171.154.91 

protocollen die bij de capture van www.microsoft getoond werden zijn:  
HTTP: Hyper Tekst Transfer Protocol. Communicatie tussen webservers en client computers wordt uitgevoerd door aanvragen te sturen en hier antwoord op te geven. Deze standaard zorgt ervoor dat onderlinge communicatie mogelijk is op het wereldwijde web, en webpagina’s weergegeven kunnen worden in de browser. 
OCSP: Online Certificate Status Protocol. Dit is een browserprotocol dat de geldigheid van een SSL sertificaat controleert mbv een whitelist.   
SSL sertificaat: Dit certificaat zorgt voor het slotje in de adresbalk van je browser. Als 

## Opdracht
●	Scan the network of your Linux machine using nmap. What do you find?
●	Open Wireshark in Windows/MacOS Machine. Analyse what happens when you open an internet browser. (Tip: you will find that Zoom is constantly sending packets over the network. You can either turn off Zoom for a minute, or look for the packets sent by the browser between the packets sent by Zoom.)

### Gebruikte bronnen  
**Opdracht 1**
Tutorial voor NMAP.  
https://www.youtube.com/watch?v=4t4kBkMsDbQ    

https://www.freecodecamp.org/news/what-is-nmap-and-how-to-use-it-a-tutorial-for-the-greatest-scanning-tool-of-all-time/

**Opdracht 2**    
Uitleg over HTTP protocol:  
https://www.doubleweb.nl/wat-is/http/

Uitleg over OCSP protocol:  
https://www.networking4all.com/nl/helpdesk/faq/wat-is-ocsp

Uitleg over ssl certificaat.  
https://www.yourhosting.nl/blog/wat-is-ssl-hoe-werkt-het-en-welke-voordelen-biedt-het/
### Ervaren problemen


### Resultaat

