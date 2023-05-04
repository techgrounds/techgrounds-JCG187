# Opdracht 10 Azure Virtual Network (Vnet)


## Key-terms
A Vnet exists:
- within a specific subscription
- within a specific region
- it cannot span subscriptons nor regions
A Vnet consists of one or more IP Ranges
Typically from RFC 1918 
The address space is broken up into subnets with the smalles subnet possible being a /29 which wll give 3 usable IP addresses. 
A Vnet can span availability zones

**NIC**
- A VM nic always get's it IP address via Azure Fabric (via DHCP). This way Azure makes sure each resource in Azure will be given a unique IP address. 
- An IP address can be reserved for specific source via the Azure Resource Manager. The quest operating system thinks it is giving out a DHCP.
- Many VM support accelerated networking is possible. 
- Multiple IP on one NIC possible to configure.  
- Vm NIC always has a prive IP an optional public IP. 

 Use VNets to:

    Create a dedicated private cloud-only VNet. Sometimes you don't require a cross-premises configuration for your solution. When you create a VNet, your services and VMs within your VNet can communicate directly and securely with each other in the cloud. You can still configure endpoint connections for the VMs and services that require Internet communication, as part of your solution.

    Securely extend your data center. With VNets, you can build traditional site-to-site (S2S) VPNs to securely scale your datacenter capacity. S2S VPNs use IPSEC to provide a secure connection between your corporate VPN gateway and Azure.

    Enable hybrid cloud scenarios. VNets give you the flexibility to support a range of hybrid cloud scenarios. You can securely connect cloud-based applications to any type of on-premises system such as mainframes and Unix systems.
  Azure assigns resources in a virtual network a private IP address from the address space that you provision. For example, if you deploy a VM in a VNet with subnet address space 192.168.1.0/24, the VM will be assigned a private IP like 192.168.1.4. Azure reserves the first four and last IP address for a total of 5 IP addresses within each subnet. These are x.x.x.0-x.x.x.3 and the last address of the subnet.  

  0 = network address
  1 = gateway 
  2 + 3 = DNS
  255 = Broadcast  

  The smallest supported IPv4 subnet is /29, and the largest is /2 (using CIDR subnet definitions). IPv6 subnets must be exactly /64 in size. When planning to implement subnets, you need to consider the following:

    Each subnet must have a unique address range, specified in Classless Inter-Domain Routing (CIDR) format.
    Certain Azure services require their own subnet.
    Subnets can be used for traffic management. For example, you can create subnets to route traffic through a network virtual appliance.
    You can limit access to Azure resources to specific subnets with a virtual network service endpoint. You can create multiple subnets, and enable a service endpoint for some subnets, but not others.





## Opdracht

Opdracht 1:  
●	Maak een Virtual Network met de volgende vereisten:  
○	Region: West Europe  
○	Name: Lab-VNet  
○	IP range: 10.0.0.0/16  
●	Vereisten voor subnet 1:  
○	Name: Subnet-1  
○	IP Range: 10.0.0.0/24  
○	Dit subnet mag geen route naar het internet hebben  
●	Vereisten voor subnet 2:  
○	Name: Subnet-2   
○	IP Range: 10.0.1.0/24  

Opdracht 2:  
●	Maak een VM met de volgende vereisten:  
○	Een apache server moet met de volgende custom data geïnstalleerd worden:  

#!/bin/bash  
sudo su  
apt update  
apt install apache2 -y  
ufw allow 'Apache'  
systemctl enable apache2  
systemctl restart apache2  
○	Er is geen SSH access nodig, wel HTTP  
○	Subnet: Subnet-2  
○	Public IP: Enabled  
●	Controleer of je website bereikbaar is


### Gebruikte bronnen
https://learn.microsoft.com/en-us/azure/virtual-network/virtual-networks-faq  

https://learn.microsoft.com/en-us/azure/virtual-network/    

https://learn.microsoft.com/en-us/azure/virtual-network/virtual-networks-udr-overview

https://learn.microsoft.com/en-us/azure/virtual-network/quick-create-portal    



https://www.youtube.com/watch?v=3NttBv92sY8



### Ervaren problemen  

Het lukt aanvankelijk niet om de subnets aan te maken. Ik kreeg een foutmelding. Maar na de derde keer, waarbij ik eigenlijk hetzelfde deed als de eerste keer ging het wel goed. 


### Resultaat
