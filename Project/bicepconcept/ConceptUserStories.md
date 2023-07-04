~**Netwerk:**  

subnet1: 10.10.10.0/24
subnet2: 10.10.20.0/24
subnetbescherming met firewall (nsg)


**ubuntu vm**

Hiervoor gekozen omdat deze voordeliger is dan een webapp. 
- in scale set en azure loadbalancer (port) o
- verbinden met subnet 10.10.10.0/24
- met encrypted disks
- voormaat disk?
- dagelijkse backup
- backups moeten 7 dagen bewaard blijven
- post deploymentscript in verbinding staan met webserver/vm
- locatie: west europe
- uitvoeren in 2 availability zones ?
- SSH of RDP alleen bereikbaar via bastion
- moet een webserver opkomen die bereikbaar is via poort 80 of 443?
- koppelen aan azure key vault
- koppelen aan recover service vault
- SLA 99%


**nieuwe eisen voor webserver**:  
- het moet een scaleset worden. Maximaal 3 servers moeten aangemaakt worden via de scale set.  
- er moet en proxy tussen de webserver en het internet komen.   
- de webserver mag geen publieke ip adres hebben.  
- de webserver moet regelmatig een 'health check'ondergaan.  
- mocht de health check van de webserver falen dan zou deze automatisch hersteld moeten worden.    
- je moet een zelf signed certificate gebruiken zodat de website via https bereikt kan worden.  
- de website mag alleen via https bereikt worden. Ook al voeren klanten dat niet in. 


**scaleset en loadbalancer**  
- vanwege de nieuw eisen is een scaleset noodzakelijk met daarbij een loadbalancer om het aanbod eerlijk te verdelen naar de webservers bij drukte.  
- de loadbalancer moet verbonden worden met een proxy.    
- de loadbalancer heeft een publieke ip adres nodig als het verbonden is met een proxy? Nee.  
- verkeer wat via http verbinding zoekt met de loadbalancer moet automatisch omgezet worden naar https.   
- de load balancer heeft een gratis basic versie en een standaard versie. Bij de basic versie is er geen SLA waardoor er geen garantie is dat deze service altijd werkt.   
- de standaard versie wordt per uur gefactureerd.   
- de loadbalancer heeft een health probe voor de vm's dit gaat via de prive IP adressen van de vms.   



**proxy**  
- wat voor proxy moet er komen?   
- Ik heb snel gezien dat je voor forward proxies gebruik kan maken van azure firewall of NAT gateway.   
- ik heb gezien dat je voor reverse proxy gebruik kan maken van application gateway of azure front door. De ene is regionaal gebruik en de andere voor global gebruik. Vragen wat nodig is aan product owner.    
- verkeer moet van http naar https omgezet worden. Die mogelijkheid heeft application gateway.  
- 2 versies van application gateway v2 heeft de meeste mogelijkheden. En WAF zit er ook in.   
- versie v2 heeft ook health probes. 
- application gateway v2 kan http headers omzetten naar https. 





**management server**

- bastion SLA 99.5%
- Voor het managen hiervoor een windows server aanmaken die via bastion de webserver kan managen.
- Op deze manier kan alleen poort 80 of 443 op de webserver opengezet worden zodat de site bereikbaar is maar niet de VM zelf.
- implementeren in subnet
- moet bereikbaar zijn met een publiek IP adres hebben die bereikbaar is voor beperkt publiek. Voor nu mijn eigen ip - moet alleen bereikbaar zijn vanaf vertrouwde locaties (office/admin’s huis) conditional access via Azure AD?
- moet via peer netwerk verbonden worden aan subnet 10.0.1.0/27. Subnet heet AzureBastionSubnet!!
- werkt als een soort proxy naar de andere machines toe in het netwerk. 
- 99% SLA
- Hoe zorg ik ervoor dat deze niet uitvalt? (het is een soort RDP connectie, maar dan veiliger. Valt alleen uit als je netwerk uitvalt.)
- maakt gebruik van een html5-based web client over TLS via port 443. Hoe ziet die web client eruit?
- private keys opslaan in Azure key vault. 
- The NSG protecting the VM subnet allows RDP and SSH traffic from the Azure Bastion subnet. 
- Azure Bastion supports communications only through TCP port 443 from the Azure portal.

**Storage account:**

- moet een postdeploymentscript bevatten en de bootstrap deployment script?
- script mogen niet publiekelijk toegankelijk zijn.
- dit kan via blob storage
- blob storage koppelen aan de webserver
- storage koppelen aan Key Vault
- Data at rest moet veilig zijn. Dit gaat via de key vault
- Toegankelijk maken via private endpoints zodat communicatie via het netwerk van microsoft verloopt tussen webserver en storage account

**Key vault:**

- moet verbonden worden met admin/management server?
- moet verbonden worden met vm’s?
- moet verbonden worden met storage?


**SQL database:**

- welke database gebruiken? De makkelijkste?
- moet stabiel zijn. Uitval is duur. Hoe dat in te regelen?
- deploymentscript moet in verbinding staan met SQL database om die te deployen. Houdt dat in dat de SQL database ook een vm moet zijn?
- database hoeft alleen maar aan te staan. Je hoeft er niks in te configureren
- data in motion moet veilig zijn.
- SLA 99%  
- verbinden met de webserver. 

**Recovery service vault:**

- moet in verbinding staan met key vault?
- moet in verbinding staan met vm en website?
- moet in verbinding staan met storage account?
- moet in verbinding staan met SQL server?
- backup moet werken dit testen?

