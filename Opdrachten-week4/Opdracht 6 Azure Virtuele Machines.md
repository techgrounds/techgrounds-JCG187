# Opdracht 6 Azure Virtuele Machines


## Key-terms
 


## Opdracht
Opdracht:
●	Log in bij je Azure Console.
●	Maak een VM met de volgende vereisten:
○	Ubuntu Server 20.04 LTS - Gen1
○	Size: Standard_B1ls
○	Allowed inbound ports:
■	HTTP (80)
■	SSH (22)
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

VM aangemaakt:  
![Alt text](Ubuntutest6%20VM%20aangemaakt..png)



○	Controleer of je server werkt.

website:  
![Alt text](website%20werkt.png)

○	Let op! Vergeet na de opdracht niet alles weer weg te gooien. Je kan elk onderdeel individueel verwijderen, of je kan in 1 keer de resource group verwijderen.





### Gebruikte bronnen


### Ervaren problemen


### Resultaat

https://learn.microsoft.com/en-us/azure/architecture/aws-professional/regions-zones?wt.md_id=searchAPI_azureportal_inproduct_rmskilling&sessionId=1654cab0b5d34281b9e787a8554ac625  

To protect against localized hardware failures, such as a disk or network switch failing, deploy two or more VMs in an availability set. An availability set consists of two or more fault domains that share a common power source and network switch. VMs in an availability set are distributed across the fault domains, so if a hardware failure affects one fault domain, network traffic can still be routed to the VMs in the other fault domains. For more information about Availability Sets, see Manage the availability of Windows virtual machines in Azure.