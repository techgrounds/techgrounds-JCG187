# Opdracht 12 Microsoft Azure Well-Architected Framework  



## Key-terms
The Azure Well-Architected Framework is a set of guiding tenets that you can use to improve the quality of a workload. This has to be evaluated or improved continuasly as you go on. It is a constant process. The framework consists of five pillars of architectural excellence:  

- **Reliability**:  The ability of a system to recover from failures and continue to function. Anticipate failure at all levels and design a system that can recover from failure within the time required.   


    Recovery point objective (RPO): The maximum duration of acceptable data loss. RPO is measured in units of time, not volume. Examples are "30 minutes of data," "four hours of data," and so on. RPO is about limiting and recovering from data loss, not data theft.

    Recovery time objective (RTO): The maximum duration of acceptable downtime, where your specification defines "downtime". For example, if the acceptable downtime duration is eight hours if there's a disaster, then your RTO is eight hours.

- **Security**: Protecting applications and data from threats. Data must be protected the entire lifecycle of an app. Use Azure protection and build in your own protection for apps, processes and organizational culture.    
**defense in depth**  
Data layer: Exposing encryption key or using weak encryption.  
Applications layer: SQL injection or cross-site scripting.  
VM/compute layer: Malware.  
Networking layer: Open ports.  
Perimeter layer: Ddos.    
Policies and access layer: Here authentication occurs for your application. Like Kerberos based authentication such protocol as Active Directory  
Physical security: Access to facilities unorthorized.

- **Cost optimization**: Managing costs to maximize the value delivered. Identify inefficiency and waste in cloud spending. (CapEx vs OpEx)
- **Operational excellence**: Operations processes that keep a system running in production. Have a monitoring architecture to detect failures and problems before they happen. Work lean and together, Test apps before deploying, use automation for common (human) activities.  
- **Performance efficiency**: The ability of a system to adapt to changes in load. Design with performance and scalability in mind. Make sure there are no preformance issue because of great demand, or inefficient use of resources. *Scale up/vertical scaling* (adding more resources to a single instance) and *scale out/horizontal scaling* (adding more instances).  
Autoscaling takes advantage of the elasticity of cloud-hosted environments while easing management overhead. It reduces the need for an operator to continually monitor the performance of a system and make decisions about adding or removing resources.

To help with the optimization there 6 elements/tools that can support you.  
- Azure Well-Architected Review: this examines your workload through the lenses of reliability, cost management, operational excellence, security and performance efficiency.  
- Azure Advisor: a free tool in Azure that scans your Azure configuration and recommends changes to optimize deployments, increase security, and save you money. 
- Documantation: Microsoft docs.
- Partners, Support, and Services Offers: Find a company that can help.  
- Reference architectures: Guidance for architecting solutions on Azure using established patterns and practices on (Microsoft docs)
- Design principles: principles for designing Azure applications. 

General design principles:  
- Evolve with the help of new services, tools and technology if possible/available.  
- Collect data to analyze and make decisions.
- Educate teams about new technologies , document and share configurations.  
- Automate manual activities to reduce costs and reduce errors and provide consistency between environments. 

Every descission made will effect another pillar.   
When you're building an Azure architecture, there are many considerations to keep in mind. You want your architecture to be secure, scalable, available, and recoverable. To make that possible, you have to make decisions based on cost, organizational priorities, and risk.



## Opdracht
.

### Gebruikte bronnen
https://learn.microsoft.com/en-us/azure/well-architected/

https://learn.microsoft.com/en-us/training/paths/azure-well-architected-framework/
### Ervaren problemen


### Resultaat
