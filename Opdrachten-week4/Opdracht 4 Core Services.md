# Opdracht 4 Core Services


## Key-terms
wat doen ze:  
●	**Regions and Region Pairs**: To protect an application against a regional outage, you can deploy the application across multiple regions, using Azure Traffic Manager to distribute internet traffic to the different regions. Each Azure region is paired with another region. Together, these form a regional pair. With the exception of Brazil South, regional pairs are located within the same geography in order to meet data residency requirements for tax and law enforcement jurisdiction purposes.

Unlike Availability Zones, which are physically separate datacenters but may be in relatively nearby geographic areas, paired regions are typically separated by at least 300 miles. This design ensures that large-scale disasters only affect one of the regions in the pair. Neighboring pairs can be set to sync database and storage service data, and are configured so that platform updates are rolled out to only one region in the pair at a time.

Azure geo-redundant storage is automatically backed up to the appropriate paired region. For all other resources, creating a fully redundant solution using paired regions means creating a full copy of your solution in both regions.  

●	**Availability Zones**: In Azure, a region is divided into two or more Availability Zones. An Availability Zone corresponds with a physically isolated datacenter in the geographic region. An Availability Zone is a physically separate zone within an Azure region. Each Availability Zone has a distinct power source, network, and cooling. Deploying VMs across availability zones helps to protect an application against datacenter-wide failures.  

●	**Resource Groups**: You can use resource groups to organize the company's Azure resources. A container that holds related resources for an Azure solution. The resource group can include all the resources for the solution, or only those resources that you want to manage as a group. You decide how you want to allocate resources to resource groups based on what makes the most sense for your organization.

●	**Subscriptions**: A subscription is an agreement with Microsoft to use one or more Microsoft cloud platforms or services, for which charges accrue based on either a per-user license fee or on cloud-based resource consumption.

Microsoft's Software as a Service (SaaS)-based cloud offerings (Microsoft 365 and Dynamics 365) charge per-user license fees. Microsoft's Platform as a Service (PaaS) and Infrastructure as a Service (IaaS) cloud offerings (Azure) charge based on cloud resource consumption.

You can also use a trial subscription, but the subscription expires after a specific amount of time or consumption charges. You can convert a trial subscription to a paid subscription.

Organizations can have multiple subscriptions for Microsoft's cloud offerings.  

●	**Management Groups**: If your organization has many Azure subscriptions, you may need a way to efficiently manage access, policies, and compliance for those subscriptions. Management groups provide a governance scope above subscriptions. You organize subscriptions into management groups; the governance conditions you apply cascade by inheritance to all associated subscriptions.  

●	**Azure Resource Manager**: Azure Resource Manager is the deployment and management service for Azure. It provides a management layer that enables you to create, update, and delete resources in your Azure account. You use management features, like access control, locks, and tags, to secure and organize your resources after deployment.  

●	**Virtual Machines**: An Azure virtual machine gives you the flexibility of virtualization without having to buy and maintain the physical hardware that runs it. However, you still need to maintain the virtual machine by performing tasks, such as configuring, patching, and installing the software that runs on it. 

●	**Azure App Services** : Azure App Service enables you to build and host web applications in the programming language of your choice without managing infrastructure. Learn how to create a website through the hosted web app platform in Azure App Service.

●	**Azure Container Instances (ACI)**: Containers are becoming the preferred way to package, deploy, and manage cloud applications. Azure Container Instances offers the fastest and simplest way to run a container in Azure, without having to manage any virtual machines and without having to adopt a higher-level service.  
Containers offer significant startup benefits over virtual machines (VMs). Azure Container Instances can start containers in Azure in seconds, without the need to provision and manage VMs.
Bring Linux or Windows container images from Docker Hub, a private Azure container registry, or another cloud-based docker registry. Visit the FAQ to learn which registries are supported by ACI. Azure Container Instances caches several common base OS images, helping speed deployment of your custom application images.  

●	**Azure Kubernetes Service (AKS)**: Azure Kubernetes Service (AKS) simplifies deploying a managed Kubernetes cluster in Azure by offloading the operational overhead to Azure. As a hosted Kubernetes service, Azure handles critical tasks, like health monitoring and maintenance. When you create an AKS cluster, a control plane is automatically created and configured. This control plane is provided at no cost as a managed Azure resource abstracted from the user. You only pay for and manage the nodes attached to the AKS cluster.  

●	**Azure Virtual Desktop**: Azure Virtual Desktop is a desktop and app virtualization service that runs on the cloud.
Here's what you can do when you run Azure Virtual Desktop on Azure:

    Set up a multi-session Windows 11 or Windows 10 deployment that delivers a full Windows experience with scalability
    Present Microsoft 365 Apps for enterprise and optimize it to run in multi-user virtual scenarios
    Bring your existing Remote Desktop Services (RDS) and Windows Server desktops and apps to any computer
    Virtualize both desktops and apps
    Manage desktops and apps from different Windows and Windows Server operating systems with a unified management experience

●	**Virtual Networks**: An Azure Virtual Network (VNet) is a representation of your own network in the cloud. It is a logical isolation of the Azure cloud dedicated to your subscription. You can use VNets to provision and manage virtual private networks (VPNs) in Azure and, optionally, link the VNets with other VNets in Azure, or with your on-premises IT infrastructure to create hybrid or cross-premises solutions. Each VNet you create has its own CIDR block and can be linked to other VNets and on-premises networks as long as the CIDR blocks do not overlap. You also have control of DNS server settings for VNets, and segmentation of the VNet into subnets.

Use VNets to:

    Create a dedicated private cloud-only VNet. Sometimes you don't require a cross-premises configuration for your solution. When you create a VNet, your services and VMs within your VNet can communicate directly and securely with each other in the cloud. You can still configure endpoint connections for the VMs and services that require Internet communication, as part of your solution.

    Securely extend your data center. With VNets, you can build traditional site-to-site (S2S) VPNs to securely scale your datacenter capacity. S2S VPNs use IPSEC to provide a secure connection between your corporate VPN gateway and Azure.

    Enable hybrid cloud scenarios. VNets give you the flexibility to support a range of hybrid cloud scenarios. You can securely connect cloud-based applications to any type of on-premises system such as mainframes and Unix systems. 

●	**VPN Gateway**: Azure VPN Gateway connects your on-premises networks to Azure through Site-to-Site VPNs in a similar way that you set up and connect to a remote branch office. The connectivity is secure and uses the industry-standard protocols Internet Protocol Security (IPsec) and Internet Key Exchange (IKE). Azure VPN Gateway is a service that uses a specific type of virtual network gateway to send encrypted traffic between an Azure virtual network and on-premises locations over the public Internet. You can also use VPN Gateway to send encrypted traffic between Azure virtual networks over the Microsoft network. Multiple connections can be created to the same VPN gateway. When you create multiple connections, all VPN tunnels share the available gateway bandwidth.  

●	**Virtual Network Peering**: n this tutorial, you learn to create a virtual network peering between virtual networks created through different deployment models. The virtual networks exist in different subscriptions. Peering two virtual networks enables resources in different virtual networks to communicate with each other with the same bandwidth and latency as though the resources were in the same virtual network. Learn more about Virtual network peering.  

●	**ExpressRoute**: Use Azure ExpressRoute to create private connections between Azure datacenters and infrastructure on premises or in a colocation environment. ExpressRoute connections don't route through the public internet, and they offer more reliability, faster speed, and lower latency than typical internet connections. In some cases, using ExpressRoute connections to transfer data between on-premises systems and Azure gives you significant cost benefits.  

●	**Container (Blob) Storage**: Azure Blob Storage is Microsoft's object storage solution for the cloud. Blob Storage is optimized for storing massive amounts of unstructured data. Unstructured data is data that doesn't adhere to a particular data model or definition, such as text or binary data.  
Blob Storage is designed for:

    Serving images or documents directly to a browser.
    Storing files for distributed access.
    Streaming video and audio.
    Writing to log files.
    Storing data for backup and restore, disaster recovery, and archiving.
    Storing data for analysis by an on-premises or Azure-hosted service.

Users or client applications can access objects in Blob Storage via HTTP/HTTPS, from anywhere in the world. Objects in Blob Storage are accessible via the Azure Storage REST API, Azure PowerShell, Azure CLI, or an Azure Storage client library. Client libraries are available for different languages, including:

    .NET
    Java
    Node.js
    Python
    Go

Clients can also securely connect to Blob Storage by using SSH File Transfer Protocol (SFTP) and mount Blob Storage containers by using the Network File System (NFS) 3.0 protocol.  

●	**Disk Storage**: Designed to be used with Azure Virtual Machines and Azure VMware Solution, Azure Disk Storage offers high-performance, durable block storage for your mission- and business-critical applications. Confidently migrate to Azure infrastructure as a service (IaaS) with disk storage options built for the cloud—–Ultra Disk Storage, Premium SSD, Standard SSD, and Standard HDD—to optimize costs and performance for your workload. Get sub-millisecond latency for high-throughput and transaction-intensive workloads such as SAP HANA, SQL Server, and Oracle.  

●	**File Storage**: Azure Files offers fully managed file shares in the cloud that are accessible via the industry standard Server Message Block and Network File System protocols. Azure file shares can be mounted concurrently by cloud or on-premises deployments of Windows, Linux, and macOS.  
Use Azure Files for the following situations:
Many on-premises applications use file shares. Azure Files makes it easier to migrate those applications that share data to Azure. If you mount the Azure file share to the same drive letter that the on-premises application uses, the part of your application that accesses the file share should work with minimal changes, if any.
Store configuration files on a file share and access them from multiple VMs. Tools and utilities used by multiple developers in a group can be stored on a file share, ensuring that everybody can find them, and that they use the same version.
Write data to a file share, and process or analyze the data later. For example, when you handle diagnostic logs, metrics, and crash dumps.  

●	**Storage Tiers**: Azure Storage offers different access tiers for your blob storage, helping you store object data in the most cost-effective manner. The available access tiers include:

Hot access tier: Optimized for storing data that is accessed frequently (for example, images for your website).
Cool access tier: Optimized for data that is infrequently accessed and stored for at least 30 days (for example, invoices for your customers).
Archive access tier: Appropriate for data that is rarely accessed and stored for at least 180 days, with flexible latency requirements (for example, long-term backups).   

**●	Cosmos DB**: Relational databases store data in relational tables, but sometimes the structure imposed by this model can be too rigid, and often leads to poor performance unless you spend time implementing detailed tuning. Other models, collectively known as NoSQL databases, exist. These models store data in other structures, such as documents, graphs, key-value stores, and column family stores.
Azure Cosmos DB is a highly scalable cloud database service for NoSQL data.    

●	**Azure SQL Database**: Azure SQL Database is a fully managed platform as a service (PaaS) database engine that handles most of the database management functions such as upgrading, patching, backups, and monitoring without user involvement. Azure SQL Database is always running on the latest stable version of the SQL Server database engine and patched OS with 99.99% availability. PaaS capabilities built into Azure SQL Database enable you to focus on the domain-specific database administration and optimization activities that are critical for your business.    

●	**Azure Database for MySQL**: Easily build or migrate your workloads to Azure Database for MySQL. Set up, manage, and automate the maintenance of your database server, including routine updates, backups, and security. Achieve a 48 percent lower total cost of ownership1 and save with burstable instances or stop-start capabilities, paying for storage only when your database is stopped. Build with the latest MySQL Community Edition using existing tools, drivers, and programming languages of your choice.  

●	**Azure Database for PostgreSQL**: Focus on application innovation instead of database management. Migrate with ease to a fully managed open-source database with support for the latest PostgreSQL versions. Azure Database for PostgreSQL offers a service-level agreement (SLA) of up to 99.99 percent uptime, AI-powered performance optimization, and advanced security.  

●	**SQL Managed Instance**: Azure SQL Managed Instance is the intelligent, scalable cloud database service that combines the broadest SQL Server database engine compatibility with all the benefits of a fully managed and evergreen platform as a service. SQL Managed Instance has near 100% compatibility with the latest SQL Server (Enterprise Edition) database engine, providing a native virtual network (VNet) implementation that addresses common security concerns, and a business model favorable for existing SQL Server customers. SQL Managed Instance allows existing SQL Server customers to lift and shift their on-premises applications to the cloud with minimal application and database changes. At the same time, SQL Managed Instance preserves all PaaS capabilities (automatic patching and version updates, automated backups, high availability) that drastically reduce management overhead and TCO.  

●	**Azure Marketplace**: Azure Marketplace is an online store that contains thousands of IT software applications and services built by industry-leading technology companies. In Azure Marketplace you can find, try, buy, and deploy the software and services you need to build new solutions and manage your cloud infrastructure. The catalog includes solutions for different industries and technical areas, free trials, and also consulting services from Microsoft partners.
 


## Opdracht
.

### Gebruikte bronnen  
region, region pairs en availability zones: 
https://learn.microsoft.com/en-us/azure/architecture/aws-professional/regions-zones?wt.md_id=searchAPI_azureportal_inproduct_rmskilling&sessionId=1654cab0b5d34281b9e787a8554ac625  

Resource groups:  
https://learn.microsoft.com/en-us/training/modules/use-azure-resource-manager/3-review-terminology    

Subscriptions:   
https://learn.microsoft.com/en-us/microsoft-365/enterprise/subscriptions-licenses-accounts-and-tenants-for-microsoft-cloud-offerings?wt.md_id=searchAPI_azureportal_inproduct_rmskilling&sessionId=1654cab0b5d34281b9e787a8554ac625&view=o365-worldwide

Management groups:  
https://learn.microsoft.com/en-us/azure/governance/management-groups/overview

Azure Resource manager:  
https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/overview  

Virtual Machines:  
https://learn.microsoft.com/en-us/azure/virtual-machines/overview?wt.md_id=searchAPI_azureportal_inproduct_rmskilling&sessionId=1654cab0b5d34281b9e787a8554ac625

Azure App Services:
https://learn.microsoft.com/en-us/training/modules/host-a-web-app-with-azure-app-service/

Azure Container Instances (ACI): 
https://learn.microsoft.com/en-us/azure/container-instances/container-instances-overview

Azure Kubernetes Service (AKS):  
https://learn.microsoft.com/en-us/azure/aks/intro-kubernetes

Azure Virtual Desktop:  
https://learn.microsoft.com/en-us/azure/virtual-desktop/overview?WT.mc_id=Portal-Microsoft_Azure_WVD

Virtual Networks:  
https://learn.microsoft.com/en-us/azure/virtual-network/virtual-networks-faq?wt.md_id=searchAPI_azureportal_inproduct_rmskilling&sessionId=1654cab0b5d34281b9e787a8554ac625

VPN Gateway:  
https://azure.microsoft.com/en-us/products/vpn-gateway/  
https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-bgp-overview?wt.md_id=searchAPI_azureportal_inproduct_rmskilling&sessionId=1654cab0b5d34281b9e787a8554ac625  
https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpngateways

Virtual Network Peering:  
https://learn.microsoft.com/en-us/azure/virtual-network/create-peering-different-deployment-models-subscriptions?wt.md_id=searchAPI_azureportal_inproduct_rmskilling&sessionId=1654cab0b5d34281b9e787a8554ac625

ExpressRoute:   
https://azure.microsoft.com/en-us/products/expressroute/

Container (Blob) Storage:  
https://learn.microsoft.com/en-us/azure/storage/blobs/storage-blobs-overview  
https://learn.microsoft.com/en-us/training/modules/azure-storage-fundamentals/azure-storage-accounts  
https://learn.microsoft.com/en-us/training/modules/azure-storage-fundamentals/azure-blob-container-storage

Disk Storage:  
https://azure.microsoft.com/en-us/products/storage/disks/  
https://learn.microsoft.com/en-us/training/modules/azure-storage-fundamentals/azure-storage-accounts  
https://learn.microsoft.com/en-us/training/modules/azure-storage-fundamentals/azure-disk-storage

File Storage: 
https://learn.microsoft.com/en-us/training/modules/azure-storage-fundamentals/azure-storage-accounts   
https://learn.microsoft.com/en-us/training/modules/azure-storage-fundamentals/azure-file-storage

Storage Tiers:  
https://learn.microsoft.com/en-us/training/modules/azure-storage-fundamentals/azure-storage-tiers

Cosmos DB:  
https://learn.microsoft.com/en-us/training/modules/explore-non-relational-data-stores-azure/?wt.md_id=searchAPI_azureportal_inproduct_rmskilling&sessionId=1654cab0b5d34281b9e787a8554ac625

Azure SQL Database:  
https://learn.microsoft.com/en-us/azure/azure-sql/database/sql-database-paas-overview?view=azuresql

Azure Database for MySQL:  
https://azure.microsoft.com/en-us/products/mysql/

Azure Database for PostgreSQL:  
https://azure.microsoft.com/en-us/products/postgresql/

SQL Managed Instance:  
https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/sql-managed-instance-paas-overview?view=azuresql

Azure Marketplace:  
https://learn.microsoft.com/en-us/marketplace/azure-marketplace-overview?wt.md_id=searchAPI_azureportal_inproduct_rmskilling&sessionId=1654cab0b5d34281b9e787a8554ac625



### Ervaren problemen


### Resultaat
