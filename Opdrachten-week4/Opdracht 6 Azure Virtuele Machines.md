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
https://learn.microsoft.com/en-us/azure/architecture/aws-professional/regions-zones?wt.md_id=searchAPI_azureportal_inproduct_rmskilling&sessionId=1654cab0b5d34281b9e787a8554ac625  


### Ervaren problemen


### Resultaat


