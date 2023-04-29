# Opdracht 8 Azure Firewalls


## Key-terms  
**Basic Firewall**: is a managed, cloud-based network security service that protects your Azure Virtual Network resources.  Azure Firewall Basic is intended for small and medium size (SMB) customers to secure their Azure cloud environments. It provides the essential protection

It has the following features:  

    Built-in high availability: 
    Availability Zones
    Application FQDN filtering rules
    Network traffic filtering rules
    FQDN tags
    Service tags
    Threat intelligence in alert mode
    Outbound SNAT support
    Inbound DNAT support
    Multiple public IP addresses
    Azure Monitor logging
    Certifications  

Standard firewall:   

**Premium firewall**: Azure Firewall Premium provides advanced threat protection that meets the needs of highly sensitive and regulated environments, such as the payment and healthcare industries.  

It has the following extra features:  

    TLS inspection  
    IDPS  
    URL filtering  
    Web categories  
    Supported regions  

**NSG Network Security Groups**:  
 You can use an Azure network security group to filter network traffic to and from Azure resources in an Azure virtual network. A network security group contains security rules that allow or deny inbound network traffic to, or outbound network traffic from, several types of Azure resources. For each rule, you can specify source and destination, port, and protocol.




 


## Opdracht
Opdracht:  
●	Zet een webserver aan. Zorg dat de poorten voor zowel SSH als HTTP geopend zijn.  
●	Maak een NSG in je VNET. Zorg ervoor dat je webserver nog steeds bereikbaar is via HTTP, maar dat SSH geblokkeerd wordt.


### Gebruikte bronnen
info over basic firewalls:  
https://learn.microsoft.com/en-us/azure/firewall/basic-features  

Korte uitleg over alle type firewalls:  
https://learn.microsoft.com/en-us/azure/firewall/overview    

verschil NSG en Azure firewall:   
https://learn.microsoft.com/en-us/answers/questions/1164114/whats-the-difference-between-an-nsg-and-azure-fire  

NSG  
https://learn.microsoft.com/en-us/azure/virtual-network/network-security-group-how-it-works 

https://learn.microsoft.com/en-us/azure/virtual-network/network-security-groups-overview
  
https://learn.microsoft.com/en-us/azure/virtual-network/tutorial-filter-network-traffic  
### Ervaren problemen


### Resultaat
