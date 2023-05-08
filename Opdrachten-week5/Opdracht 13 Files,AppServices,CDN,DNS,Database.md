# Opdracht 13 Files,AppServices,CDN,DNS,Database



## Key-terms
 **Files** 
Werkt als een share file. 

 **App Service**   
 Azure app service enables you to build and host web apps, mobile backends and Restful IPI's in the programming language of your choice without managing infrstructure. 

It offerst auto-schaling  
High availability: 99.95% availability
Supports windows and linux
enables automated deployments from GitHub, Azure DevOps or any Git repo.

Webb app examples: facebook, google maps, twitter, dropbox, Slack, LinkedIn. Is a website that has interactive and dynamic features beyond static websites. 

Mobile backends: This is the server-side infrastructure that provides functionality and data storage for mobile applications. It's where the data and logic for an app live and it's responsible for handling tasks such as user authentication, data storage and retrieval, and push notifications.

RESTful APIs:  (Application Programming Interfaces) are a way for mobile apps to communicate with a backend server over the internet. APIs provide a set of standardized rules and protocols for accessing data and functionality from a server, making it easier for developers to build apps that can work with different backends.

Think of it like ordering food at a restaurant: the mobile app is like the customer, and the mobile backend is like the kitchen. The RESTful API is like the menu that tells the kitchen what the customer wants, and then the kitchen prepares the food and sends it back to the customer. In the same way, the mobile app sends requests to the backend server through the RESTful API, and then the server processes the requests and sends back the necessary data and functionality to the app.


**Azure CDN**: 
Key Characteristics:  
- Deliver web content quickly to users so they get a better user experience when they have to make multiple round trips to load the complete conten of a webpage.
- Minimize latency  
- Reduce Workload for frontend services
- content spread over multiple OPOP (points of presence) locations. There are 120 locations available worldwide. This is more locations then there are Azure regions.
- static content is stored/cached on edge servers that are near the end users that are consuming the content. Azure CDN can also accelerate delivery of non-cacheable dynamic content by leveraging many different network optimizations.
- Azure also offers large scaling which allows it to better handle high loads, such as you would expect to see during a product launch. 
- if the POP location/server does not have the conten requested by a customer, it will ask it from the frontend service (Azure Web App, Azure Cloud Service, Azure storage account etc.) and cach te content for 7 days. (that is the time to live ttl that is added to the http header.) Other users will now get the file quicker from the cache. 
- The CDN will periodically refresh its content. This is based on the ttl of the cached content. If you want the content of the cached content to change in the POP location you have to purge the content in de overview tab of the endpoint of the CDN in Azure portal. 

when creating a CDN profile you can choose the following pricing tiers:  
- Standard Microsoft  
- Standard Verizon  
- Standard Akamai  (use if you want to customize rules later on)
- Premium Verizon

 **Azure DNS**

 Public DNS and Private DNS.
 Public used for publicly available websites and webapps.
 Private used for vnet in Azure
 Azure DNS: When creating a virtual network Azure automatically sets up name resolution so the VM's in it can communicate with each other using hostnames instead of P addresses. It does not work across peerde Vnets. But you can solve this by setting up a custom DNS server. A Simpler solution is to use Azure DNS.  

 It is a service for hosting your domains and managing your domain name system records. 
 It can host public domains like contoso.net. And with the new private domain feature you can also host private domains that are only accessible from within your Azure virtual networks. Vaak wordt het verwezen naar de A record. Dit is handig voor als het IP adres gewijzigd moet worden. Dan hoef je het alleen in het A record te doen. 

A record: IPv4  
AAAA record: IPv6   
Cname record: Een alias voor een record die je al eerder hebt gebruikt en wat toegewezen is aan een IP adres. Hiermee zorg je ervoor dat de Cname record verwijst naar dat eerder aangemaakte record en IP adres.  


Private domains:   
Azure DNS now supports private domains that aren't accessible over the internet.   
You can use Azure DNS to set up a custom domain insde a single virtual network.   
It will automatically create a DNS record for each of  the VM's and other resource in the virtual network so you don't have to (auto registration)

Multiple peered networks that need to share name resolution (like in a hub and spoke architecture) can also be created in the private DNS zone. You can use the auto registration option in the private zone and link the VNets  
 

 **Azure Database (+ managed instance)**


## Opdracht
Bestudeer:  
●	App Service   
●	Content Delivery Network (CDN) 	  
●	Azure DNS 					

Opdracht:  
●	Azure Files 
Storage account aangemaakt en een fileshare gecreerd en aan pc gekoppeld.
![Azure file storage](https://user-images.githubusercontent.com/123589199/236883564-66b9b52c-65f3-4fd9-9430-8c082b8afeef.png)

Data toegevoegd via PC. 
![Data toegevoegd via pc](https://user-images.githubusercontent.com/123589199/236883736-342217af-24b1-4b73-8e05-a63abaf33483.png)

File upload via Azure portaal.
![file upload portal](https://user-images.githubusercontent.com/123589199/236883812-67ce30af-59db-4ce9-872c-6858b89fa213.png)

![Toegevoegde data zichtbaar in portaal](https://user-images.githubusercontent.com/123589199/236883876-0917b431-cfed-40a5-bd18-3562eb391160.png)

●	Azure Database (+ managed instance) 	

### Gebruikte bronnen
AppServices:  
https://learn.microsoft.com/en-us/azure/app-service/overview?WT.mc_id=APC-AppServices 

File service + database
https://www.youtube.com/watch?v=_Qlkvd4ZQuo&list=UULFdmEIMC3LBil4o0tjaTbj0w&index=29



### Ervaren problemen


### Resultaat
