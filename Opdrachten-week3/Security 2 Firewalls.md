# Security 2 Firewalls
Zoeken naar webserver ubuntu/linux.  
Installeren van webserver apache2 op ubuntu.
Zoeken naar tonen van standaard browser in ubuntu.
Verkeerd begrepen. Nu zoeken naar hoe ik de default pagina van apache2 kan openen in de browser op mijn pc. 
Ik moest de firewall eerst nog activeren en de toegangsregels toepassen.   
Na lang zoeken niet gevonden hoe het moest. Navraag gedaan bij collega's. Het bleek dat ik de webpoort moest gebruiken die in de lijst op de cloud stond. Ik moest eerst door de "poort" van de host om bij de vm van mij te komen.  

## Key-terms
 Statefull: Hierbij wordt al het verkeer gemonitoord. Aan de hand van het bekijken van het verkeer kan de status van het verkeer gemonitoord, gevolgd en beschermd worden aan de hand van patronen en bewegingen. c
 Stateless: Is het filteren van verkeer door de firewall wat door mag gaan door middel van accesslists en poortnummers. Deze vorm van filteren kijkt naar elk pakketje afzonderlijk en checkt dat pakketje tegen vooraf ingestelde regels.   
  



## Opdracht
●	Installeer een webserver op je VM.
●	Bekijk de standaardpagina die met de webserver geïnstalleerd is.
●	Stel de firewall zo in dat je webverkeer blokkeert, maar wel ssh-verkeer toelaat.
●	Controleer of de firewall zijn werk doet.

### Gebruikte bronnen
**Uitleg over firewalls:**
https://www.cisco.com/c/nl_nl/products/security/firewalls/what-is-a-firewall.html 


**Uitleg installatie Apache2 webserver op een ubuntu OS:**  
https://www.transip.nl/knowledgebase/artikel/1998-apache-webserver-installeren-ubuntu-1804/    



**Command om standaard pagina te openen in de CLI:**  
https://stackoverflow.com/questions/45721790/how-can-one-access-http-localhost-using-the-command-line   

**Hoe een browser te krijgen in Ubuntu:**   
https://www.youtube.com/watch?v=4pfVpxqSjjc  

https://zoomadmin.com/HowToInstall/UbuntuPackage/links   

**Hoe een poort te sluiten:**   
https://askubuntu.com/questions/410218/how-to-close-an-open-port-in-ubuntu  

https://superuser.com/questions/127863/manually-closing-a-port-from-commandline   

**Hoe de firewall te activeren en poorten open te zetten**

https://www.youtube.com/watch?v=_kYAzJG_68s  

### Ervaren problemen
Ik weet niet zeker of ik "links" nodig heb om de browser the zien in de ubuntu cli, die in apache standaard zit.   
Het bleek achteraf ook dat ik de webpagina in de browser van mijn eigen pc moest openen. Niet in ubuntu. Dus weer verder zoeken.
Ik moest hiervoor eerst de firewall activeren. Ik vergat ondanks de waarschuwing dat ik ook poort 22 toe moest openen op de firewall. Hierdoor kon ik niet meer in mijn vm komen en moest de firewall worden uitgezet door Casepr.  
En om alles nog leuker te maken had ik helaas ook niet begrepen dat ik de poort 58004 moest gebruiken om via de host toegang te krijgen via een browser naar de default webpagina van apache in de vm. Daarom de hele ochtend lopen zoeken hoe ik de default pagina moest openen via de browser van mijn pc. Toen ik dat uiteindelijk gevraagd had en ingevoerd had, was de rest makkelijk. 

### Resultaat
