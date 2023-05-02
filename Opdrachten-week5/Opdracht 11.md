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
.

### Gebruikte bronnen


### Ervaren problemen


### Resultaat
