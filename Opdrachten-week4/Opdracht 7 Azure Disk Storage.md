# Opdracht 7 Azure Disk Storage


## Key-terms
Managed disk:  
Unmanaged disk:  
Snapshot:  




## Opdracht
Opdracht:  
●	Start 2 Linux VMs. Zorgt dat je voor beide toegang hebt via SSH.  
●	Maak een Azure Managed Disk aan en koppel deze aan beide VMs tegelijk.   
Managed disk gekoppeld met 2 vms gekoppeld:  
![Alt text](managed%20disk.png)

●	Creëer op je eerste machine een bestand en plaats deze op de Shared Disk.  
●	Kijk op de tweede machine of je het bestand kan lezen.   
 ![Alt text](vm1shared%20disk%20document.png)
![Alt text](vm2shared%20disk%20document.png)
 
●	Maak een snapshot van de schijf en probeer hier een nieuwe Disk mee te maken    



●	Mount deze nieuwe Disk en bekijk het bestand. 

![Alt text](linux%20vm1%20snapshot%20en%20shareddisk.png)
### Gebruikte bronnen  

filmpje over shared disk:  
https://learn.microsoft.com/en-us/azure/virtual-machines/linux/attach-disk-portal?tabs=ubuntu

mount disk in linux:  
https://learn.microsoft.com/en-us/azure/virtual-machines/linux/attach-disk-portal?tabs=ubuntu    

create snapshot out of disk:  
https://learn.microsoft.com/en-us/azure/virtual-machines/snapshot-copy-managed-disk?tabs=portal

create disk out of snapshot:  
https://www.techtarget.com/searchcloudcomputing/tip/How-to-create-snapshots-for-Azure-VMs-and-managed-disks  

attach disk to vm in azure portal:   
https://learn.microsoft.com/bs-latn-ba/azure/devtest-labs/devtest-lab-attach-detach-data-disk

### Ervaren problemen


### Resultaat
