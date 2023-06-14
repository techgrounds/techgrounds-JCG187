~**Netwerk:**  

subnet1: 10.10.10.0/24
subnet2: 10.10.20.0/24
subnetbescherming met firewall (nsg)


**VM scaleset met webserver:**
Het wordt in eerste instantie een vm met website. Mocht het lukken dan een vm scaleset.

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
- poort via nsg openen voor bastion zodat rdp/ssh sessies via de prive ip adres van bastion gehouden kunnen worden.

**Azure Bastion**

- bastion SLA 99.5%
- Voor het managen van de webserver.
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

The typical connection process in Azure Bastion is as follows:
An administrator connects to the Azure portal using any HTML5 browser by using a connection secured with TLS. The administrator selects the VM they want to connect to.
The portal connects over a secured connection to Azure Bastion through an NSG that's protecting the virtual network that hosts the targeted VM.
Azure Bastion initiates a connection to the target VM.
The RDP or SSH session opens in the browser on the administrator console. Azure Bastion streams the session information through custom packages. These packages are protected by TLS.
Administrators that want to connect to IaaS VMs in Azure through Azure Bastion require the Reader role on:
The target VM.
The network interface with private IP on the target VM.
The Azure Bastion resource.
Tip: The subnet must be called AzureBastionSubnet
Because Azure Bastion is protected by the virtual network's NSG, your NSG needs to support the following traffic flow:
Inbound:
RDP and SSH connections from the Azure Bastion subnet to the target VM subnet
TCP port 443 access from the internet to the Azure Bastion public IP
TCP access from Azure Gateway Manager on ports 443 or 4443
Outbound:
TCP access from the Azure platform on port 443 to support diagnostic logging

Note: Azure Gateway Manager manages portal connections to the Azure Bastion service.

Jump Box

A jump box is an Azure VM with a public IP address, which is accessible from the internet. Used when the VM’s have only private IP addresses. So not usable in this scenario. 

**Storage account:**

- moet een postdeploymentscript bevatten en de bootstrap deployment script?
- script mogen niet publiekelijk toegankelijk zijn.
- dit kan via blob storage
- blob storage koppelen aan de webserver
- storage koppelen aan Key Vault
- Data at rest moet veilig zijn

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

**Recovery service vault:**

- moet in verbinding staan met key vault?
- moet in verbinding staan met vm en website?
- moet in verbinding staan met storage account?
- moet in verbinding staan met SQL server?
- backup moet werken dit testen?

