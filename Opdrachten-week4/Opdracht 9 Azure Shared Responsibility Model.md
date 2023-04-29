# Opdracht 9 Azure Shared Responsibility Model


**Wie is waar verantwoordelijk voor:**  
- Ik ben altijd verantwoordelijk voor:  De informatie en data die ik opsla in de cloud
                                        De apparaten die ik toesta om een connectie te maken met de cloud (mobiel, laptop, pc etc)  
                                        De accounts en identiteiten van de mensen, services en apparaten in mijn organisatie  

- De cloud leverancier is altijd verantwoordelijk voor:     De fysieke datacenter  
                                                            Het fysieke netwerk  
                                                            De fysieke hosts    


***Cloud Computing Catergories***

**Iaas** Infrastructure as a service:  This cloud service model is the closest to managing physical servers; a cloud provider will keep the hardware up-to-date, but operating system maintenance and network configuration is up to you as the cloud tenant. For example, Azure virtual machines are fully operational virtual compute devices running in Microsoft datacenters. An advantage of this cloud service model is rapid deployment of new compute devices. Setting up a new virtual machine is considerably faster than procuring, installing, and configuring a physical server. 

IaaS is the most flexible category of cloud services. It aims to give you complete control over the hardware that runs your application. Instead of buying hardware, with IaaS, you rent it.

Advantages  
- No CapEx. Users have no up-front costs.  
- Agility. Applications can be made accessible quickly, and deprovisioned whenever needed.  
- Management. The shared responsibility model applies; the user manages and maintains the services they have provisioned, and the cloud provider manages and maintains the cloud infrastructure.  
- Consumption-based model. Organizations pay only for what they use and operate under an Operational Expenditure (OpEx) model.  
- Skills. No deep technical skills are required to deploy, use, and gain the benefits of a public cloud. Organizations can use the skills and expertise of the cloud provider to ensure workloads are secure, safe, and highly available.  
- Cloud benefits. Organizations can use the skills and expertise of the cloud provider to ensure workloads are made secure and highly available.  
- Flexibility. IaaS is the most flexible cloud service because you have control to configure and manage the hardware running your application.  

**Paas** Platform as a service:  This cloud service model is a managed hosting environment. The cloud provider manages the virtual machines and networking resources, and the cloud tenant deploys their applications into the managed hosting environment. For example, Azure App Services provides a managed hosting environment where developers can upload their web applications, without having to worry about the physical hardware and software requirements.  

PaaS provides the same benefits and considerations as IaaS, but there are some additional benefits to be aware of.  

Advantages
- No CapEx. Users have no up-front costs.
- Agility. PaaS is more agile than IaaS, and users don't need to configure servers for running applications.
- Consumption-based model. Users pay only for what they use, and operate under an OpEx model.
- Skills. No deep technical skills are required to deploy, use, and gain the benefits of PaaS.
- Cloud benefits. Users can take advantage of the skills and expertise of the cloud provider to ensure that their workloads are made secure and highly available. In addition, users can gain access to more cutting-edge development tools. They can then apply these tools across an application's lifecycle.
-Productivity. Users can focus on application development only, because the cloud provider handles all platform management. Working with distributed teams as services is easier because the platform is accessed over the internet. You can make the platform available globally more easily.    

Disadvantage
- Platform limitations. There can be some limitations to a cloud platform that might affect how an application runs. When you're evaluating which PaaS platform is best suited for a workload, be sure to consider any limitations in this area. 

**Saas** Software as a service:  In this cloud service model, the cloud provider manages all aspects of the application environment, such as virtual machines, networking resources, data storage, and applications. The cloud tenant only needs to provide their data to the application managed by the cloud provider. For example, Microsoft Office 365 provides a fully working version of Microsoft Office that runs in the cloud. All you need to do is create your content, and Office 365 takes care of everything else.

SaaS is software that's centrally hosted and managed for you and your users or customers. Usually one version of the application is used for all customers, and it's licensed through a monthly or annual subscription.

SaaS provides the same benefits as IaaS, but again there are some additional benefits to be aware of too.

Advantages
- No CapEx. Users have no up-front costs.
- Agility. Users can provide staff with access to the latest software quickly and easily.
- Pay-as-you-go pricing model. Users pay for the software they use on a subscription model, typically monthly or yearly, regardless of how much they use the software.
- Skills. No deep technical skills are required to deploy, use, and gain the benefits of SaaS.
- Flexibility. Users can access the same application data from anywhere.  

Disadvantage
Software limitations. There can be some limitations to a software application that might affect how users work. Because you're using as-is software, you don't have direct control of features. When you're evaluating which SaaS platform is best suited for a workload, be sure to consider any business needs and software limitations.

**Serverless Computing**:   
Like PaaS, serverless computing enables developers to build applications faster by eliminating the need for them to manage infrastructure. With serverless applications, the cloud service provider automatically provisions, scales, and manages the infrastructure required to run the code. Serverless architectures are highly scalable and event-driven, only using resources when a specific function or trigger occurs.

It's important to note that servers are still running the code. The "serverless" name comes from the fact that the tasks associated with infrastructure provisioning and management are invisible to the developer. This approach enables developers to increase their focus on the business logic, and deliver more value to the core of the business. Serverless computing helps teams increase their productivity and bring products to market faster, and it allows organizations to better optimize resources and stay focused on innovation.
 

**Consumption-based model**: Organizations pay only for what they use and operate under an Operational Expenditure (OpEx) model.

Skills. No deep technical skills are required to deploy, use, and gain the benefits of a public cloud. Organizations can use the skills and expertise of the cloud provider to ensure workloads are secure, safe, and highly available.

Cloud benefits. Organizations can use the skills and expertise of the cloud provider to ensure workloads are made secure and highly available.

Flexibility. IaaS is the most flexible cloud service because you have control to configure and manage the hardware running your application.

**Azure shared Shared Responsibility model**: Wie verantwoordelijk is voor wat in de cloud wordt gedeelt tussen de cloud provider en de klant. Aan de hand van de verschillende services(Saas, Paas, Iaas) die afgenomen worden veranderd de verantwoordelijkheid tussen provider en klant.   

**Per service model veranderd de verantwoordelijkheid voor bijvoorbeeld**:  Operating system  
                                                                            Netwerk controls  
                                                                            Applicaties  
                                                                            Identiteit en infrastructuur    

***types of Cloud Computing***                                                                            

**Private cloud**: Is een cloud die gebruikt wordt door één gebruiker/entiteit. Het geeft meer verantwoordelijkheid en beheersmogelijkheid voor het bedrijf en de IT afdeling. Het is wel duurder en heeft minder mogelijkheden als de publieke cloud. Een private cloud kan gehost worden vanuit je eigen datacenter onsite of offsite en eventueel datacenters van een derde partij die zijn datacentra heeft toegewijd aan jouw bedrijf.    

Private cloud
Hardware must be purchased for start-up and maintenance.
Organizations have complete control over resources and security.
Organizations are responsible for hardware maintenance and updates.

**Public cloud**: Is een cloud die is gebouwd en wordt beheerd door een derde partij. Iedereen die wil kan daar een cloud service kopen en kan gebruik maken van de resources. Dat iedereen, dus ook een particulier hier gebruik van kan maken is een sleutel verschil met de private cloud. De meeste verantwoording ligt bij de beheerder van de cloud.  

Public cloud
No capital expenditures to scale up.
Applications can be quickly provisioned and deprovisioned.
Organizations pay only for what they use.

**Hybrid cloud**: Maakt gebruik van zowel de private cloud als de public cloud mogelijkheden en zijn met elkaar verbonden.   

Hybrid cloud
Provides the most flexibility.
Organizations determine where to run their applications.
Organizations control security, compliance, or legal requirements.

**Multi-cloud**: Hierbij maak je gebruik van verschillende aanbieders van de public cloud.

**Azure Arc**: Een tool die je helpt om de cloud omgeving te managen. Of dit nu in de public, private cloud is of dat het bij een andere cloud proviader is.   

**Azure VMware Solution**: Met deze oplossing kan je alles wat in de VMware in de private cloud draait migreren naar een publieke of hybryde cloud. Met Azure VMware kan je, je VMware workloads naadloos integreren en als nodig is scalen in Azure. 


## Opdracht  
Bestudeer:  

●	Het Azure Shared Responsibility model

### Gebruikte bronnen


### Ervaren problemen


### Resultaat
