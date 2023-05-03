# Opracht 11 Azure Load Balancer


## Key-terms  

**Azure Load Balancers:**   
Azure Load Balancer is an Azure service that allows you to evenly distribute incoming network traffic across a group of Azure VMs or instances in a Virtual Machine Scale Set

* Operate on IOS layer 4:   
* Source and destination address  
* TCP or UDP  
* Port number  

**public load balancer:** 
Are used to load balance internet traffic to  your VMs.

**Internal load balancers:**
Direct traffic to resources that are insde a virtual network ot that use a VPN to access. 

**Internal load balancer enables 4 types of load balancing:**  
* Within a virtual network  
* For a cross-premisses virtual network  
* For multi-tier applcations  
* For LOB applications  

**Front -end IP:**
Is the IP clients use to connect to your website.
Can be a Public or privat IP address.
Public: (public load balancer) maps the public IP and port of incomming traffic to the private IP and port of the VM.
Private: (private load balancer) distributes traffic to resources that are inside a virtual network. 

**Load Balancer rules:**  
Traffic is managed by default using a 5-tuple hash, made from the following elements:  
Souce IP, Source port, Destination IP, Destination port, Protocol type (TCP, UDP) and Session affinity.

**Back-end pool:**
Is a group of VMs or instances in a Virtual Machine Scale Set.

**Health probe:**   
Health probes allow you to determine whether a back-end pool instance is responding to traffic.

**Session persistence:**  
Session persistence allows you to ensure that traffic from a client computer interacting with Azure Load Balancer is always forwarded to the same server in the back-end pool.

**High availability ports:**  
A load balancer rule configured with protocol - all and port - 0 is called a high availability (HA) port rule. It is a standard internal loadbalancer only (TCP and/or UDP). 

**Inbound Nat rules:**  
You can use load balancing rules in combination with Network Address Translation (NAT) rules. You can for instance configure inbound NAT rules to allow remote desktop protocol access to a VM instance to perform administrative tasks. It is used to directly map a port to an IP address.

**Outbound rules:**  
An outbound rule configures Source Network Address Translation (SNAT) for all VMs or instances identified by the back-end pool. This rule enables instances in the back end to communicate (outbound) to the internet or other public endpoints.  

**Other load-balancing solutions:**
Azure Front Door  
Azure Traffic Manager  
Azure Application Gateway  


**Virtual Scale Set:**  
Virtual Machine Scale Sets in Azure are designed to allow you to deploy and manage many load-balanced VMs. Virtual Machine Scale Sets are intelligent enough to automatically scale up or down the number of VM instances.

**2 ways to scale:**
Scheduled scaling  
Autoscaling

**Azure Spot Virtual Machines:**
Azure Spot Virtual Machines allows you to take advantage of our unused capacity at a significant cost savings. At any point in time when Azure needs the capacity back, the Azure infrastructure will evict Azure Spot Virtual Machines. 

Are removed when resources are required by Azure. You get 30 second notice.

**Health probes:**    
Pings the instance. If ping fails the scale set knows not to use that instance.

**Appplication Health Extension:**  
Pings the instance. If ping fails the scale set knows not to use that instance.



## Opdracht
Opdracht 1:  
●	Maak een Virtual Machine Scale Set met devolgende   vereisten:  
○	Ubuntu Server 20.04 LTS - Gen1  
○	Size: Standard_B1ls  
○	Allowed inbound ports:  
■	SSH (22)  
■	HTTP (80)  
○	OS Disk type: Standard SSD  
○	Networking: defaults  
○	Boot diagnostics zijn niet nodig  
○	Custom data:

#!/bin/bash  
sudo su  
apt update  
apt install apache2 -y  
ufw allow 'Apache'  
systemctl enable apache2  
systemctl restart apache2  
○	Initial Instance Count: 2  
○	Scaling Policy: Custom  
■	Aantal VMs: minimaal 1 en maximaal 4  
○	Voeg een VM toe bij 75% CPU gebruik  
○	Verwijder een VM bij 30% CPU gebruik  

Instellingen VM Scale Set:


![Instellingen_Scale_Set](https://user-images.githubusercontent.com/123589199/235990092-bcc17a31-120f-46db-88ca-d83e4d41fa2d.png)

Opdracht 2:  
●	Controleer of je via het endpoint van je load balancer bij de webserver kan komen. 

website:

![website bereikbaar](https://user-images.githubusercontent.com/123589199/235990191-39bc3515-ebc2-4883-bae9-b63a7d9f26fe.png)

VM:


![VMipadres](https://user-images.githubusercontent.com/123589199/235990440-9d7f343c-82bb-4c4d-8796-a0e710947e05.png)



●	Voer een load test uit op je server(s) om auto scaling the activeren. Er kan een delay zitten in het    reëren van nieuwe VMs, afhankelijk van de settings in je VM Scale Set.


Load test:


![stresstest](https://user-images.githubusercontent.com/123589199/235990680-4aa58bee-c31c-4104-8bca-e014fba00d5b.png)

Upscaling door tresstest:

![toegevoegde_resources_upscaling](https://user-images.githubusercontent.com/123589199/235990742-aa704425-7865-4f04-8bb7-6caef1a5ccbc.png)

Downscaling na stresstest:


![afgenomen_resources_na_refresh](https://user-images.githubusercontent.com/123589199/235990938-bae084d1-3c3c-4c22-b10d-3d82092a8a0a.png)


### Gebruikte bronnen

https://learn.microsoft.com/en-us/azure/virtual-machines/windows/tutorial-create-vmss    

https://learn.microsoft.com/en-us/azure/load-balancer/load-balancer-overview  

https://learn.microsoft.com/en-us/training/paths/intro-to-azure-application-delivery-services/

https://www.youtube.com/watch?v=wJvmXM81tEI&t=1771s  

https://lindevs.com/install-stress-command-on-ubuntu/

### Ervaren problemen
In eeste instantie had ik eerst de vm scale set aangemaakt en daarna de load balancer toegevoegd. Ik had wel gezien dat je die bij het aanmaken van de vm scale set gelijk toe kon voegen maar zo had ik de opdracht niet begrepen. De koppeling tussen de load balancer en de vm scale set is daardoor niet goed gegaan. Ik heb daarna de vm scale set opnieuw aangemaakt en gelijk de loadbalancer tijdens het opmaken toegevoegd. 

Ik heb voor de stresstest als eerst de Azure load tester gebruikt. Daar kreeg ik geen goed resultaat. Ik had begrepen dat andere de test op de vm zelf deden via de CLI. Dit daarna ook gedaan. Op de vm ingelogd en de app stress toegvoegd in de Ubuntu server. Bij het doen van de stresstest had ik 100% voor de CPU gedaan. Hierdoor werd ik uit de VM gegooid. Toen de test klaar was, bestond de VM niet meer en moest ik op een andere overgebleven VM opnieuw inloggen om de test nogmaals te doen. Ik heb toen voor 80% CPU gekozen. 

### Resultaat
