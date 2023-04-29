# Opdracht 1 Azure Global Infrastructure


## Key-terms
 **Azure Global Infrastructure**: Bestaat uit 2 sleutel componenten. Je hebt de fysieke infrastructuur en de netwerk componenten die alles met elkaar verbinden. De fysieke infrastructuur bestaat uit zo'n 200+ fysieke datacentra's over de hele wereld. Deze zijn verdeeld in regio's en met elkaar verbonden via het grootste onderling met elkaar verbonden netwerk. Het wereldwijde Azure netwerk zorgt ervoor dat data in het betrouwbare Microsoft netwerk blijft en dat IP verkeer nooit het publieke internet op gaat. Het zorgt ook voor high availability, low latency, scalability en de laatste technologie op het gebied van cloud infrastructuren. 

**Datacenter**: Zijn gebouwen die overal in de wereld geplaatst zijn met daarin een groep servers verbonden aan het netwerk.   

**Azure region**: Bestaat uit een groep datacentra's in een gebied. De afstand tot elkaar zijn dusdanig dat de overdracht van data binnen een vooraf opgestelde tijd kan plaatsvinden.  Ze zijn via een speciaal netwerk met elkaar verbonden om zo lage latentie te creeeren. In elke datacentre zitten clusters van racks met stroom, netwerk switches, servers. Als je resilancy wil in een region dan zal je minimaal 2 instances of een wat voor een service dan ook op verschillende racks. Mocht één van de instances kapot gaan, dan heb je de andere nog.   

*A region is a geographical area on the planet that contains at least one, but potentially multiple datacenters that are nearby and networked together with a low-latency network. Azure intelligently assigns and controls the resources within each region to ensure workloads are appropriately balanced.*  

**Azure geography**: Is een manier om Azure regions te groeperen die dicht bij elkaar staan en die dezelfde wettelijke regels naleven. Dit is voor klanten die specifieke regels moeten naleven mbt waar de data opgeslagen moet worden die ze ontvangen. Er zijn 36 geography's bij Azure.   

**Azure Availability zone**: Er zijn minimaal 3 verschillende beschikbare zones in alle regio's die een availability zone  hebben. Ze zijn met elkaar verbonden door middel van een heel snel netwerk wat ervoor zorgt dat data binnen 2 ms heen en weer verzonden kan worden tussen de data centers in een andere zone. Door je data te verspreiden over meerdere zone's voorkom je dat als er een grote stroomstoring is in een van de zone's in de region, je over kan gaan naar de andere zone. De andere zone ligt ver genoeg van de eerste om geen last te hebben van de stroomstoring die daar optreed. Availability zones zorgen ervoor dat je data beschikbaar en gesynchroniseerd blijft.   

*Availability zones are physically separate datacenters within an Azure region.  Each availability zone is made up of one or more datacenters equipped with independent power, cooling, and networking. An availability zone is set up to be an isolation boundary. If one zone goes down, the other continues working. Availability zones are connected through high-speed, private fiber-optic networks. To ensure resiliency, a minimum of three separate availability zones are present in all availability zone-enabled regions. However, not all Azure Regions currently support availability zones. Availability zones are primarily for VMs, managed disks, load balancers, and SQL databases.*  

**Azure region pair**: Bestaat uit 2 azure regions in één geografisch gebied. Wordt gebruikt voor disaster recovery. Als er een ramp in een gebied gebeurd, kan je overgaan naar het andere gebied waar de ramp niet plaatsvindt. De region pairs zijn door Microsoft bepaald.  

*Most Azure regions are paired with another region within the same geography (such as US, Europe, or Asia) at least 300 miles away. This approach allows for the replication of resources across a geography that helps reduce the likelihood of interruptions because of events such as natural disasters, civil unrest, power outages, or physical network outages that affect an entire region. For example, if a region in a pair was affected by a natural disaster, services would automatically fail over to the other region in its region pair. Examples of region pairs in Azure are West US paired with East US and South-East Asia paired with East Asia. Because the pair of regions are directly connected and far enough apart to be isolated from regional disasters, you can use them to provide reliable services and data redundancy.*   

Additional advantages of region pairs:

1 if an extensive Azure outage occurs, one region out of every pair is prioritized to make sure at least one is restored as quickly as possible for applications hosted in that region pair.  

2 Planned Azure updates are rolled out to paired regions one region at a time to minimize downtime and risk of application outage.  

3 Data continues to reside within the same geography as its pair for tax- and law-enforcement jurisdiction purposes.*
  

                 


## Opdracht
●	Wat is een Azure Region?  
A region is a geographical area on the planet that contains at least one, but potentially multiple datacenters that are nearby and networked together with a low-latency network. Azure intelligently assigns and controls the resources within each region to ensure workloads are appropriately balanced.   

●	Wat is een Azure Availability Zone?  
Availability zones are physically separate datacenters within an Azure region.  Each availability zone is made up of one or more datacenters equipped with independent power, cooling, and networking. An availability zone is set up to be an isolation boundary. If one zone goes down, the other continues working. Availability zones are connected through high-speed, private fiber-optic networks. To ensure resiliency, a minimum of three separate availability zones are present in all availability zone-enabled regions. However, not all Azure Regions currently support availability zones. Availability zones are primarily for VMs, managed disks, load balancers, and SQL databases.  

●	Wat is een Azure Region Pair?  
Most Azure regions are paired with another region within the same geography (such as US, Europe, or Asia) at least 300 miles away. This approach allows for the replication of resources across a geography that helps reduce the likelihood of interruptions because of events such as natural disasters, civil unrest, power outages, or physical network outages that affect an entire region.   

●	Waarom zou je een regio boven een andere verkiezen? Sommige services of VM's features zijn alleen te verkrijgen in bepaalde regio's. Denk aan bepaalde vm formaten of bepaalde opslag types. Er zijn ook Azure services waarvoor je geen bepaalde regio  hoeft te selecteren. 



### Gebruikte bronnen  

https://azure.microsoft.com/en-us/explore/global-infrastructure/?utm=agencyspotter  

Azure regions with availablity zone support list:
https://learn.microsoft.com/en-us/azure/reliability/availability-zones-service-support#azure-regions-with-availability-zone-support  

https://learn.microsoft.com/en-us/training/modules/describe-core-architectural-components-of-azure/5-describe-azure-physical-infrastructure    

Lijst van region pairs:
https://learn.microsoft.com/en-us/azure/reliability/cross-region-replication-azure


### Ervaren problemen
geen  

### Resultaat
