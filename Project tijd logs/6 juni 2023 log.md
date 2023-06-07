# Log  
6-6-2023  

## Dagverslag  
Vandaag via microsoft learn (nog meer) geleerd over bicep en via een youtube filmpje een storage account gemaakt.

## Obstakel  
Bij het aanmaken van een storage account via bicep, kreeg ik een foutmelding bij het aangeven van de locatie. Dit samen met de collega's opgelost. 

Ik vermoed dat ik de meeste problemen ga krijgen met bicep. Het aanmaken van de code. Ik wil als eerste de vnet opzetten met de subnets en de NSG's. Daarna de web servers etc. Hoe ga ik dit alles aan elkaar koppelen? 

Ik heb een grof idee van hoe ik de architectuur op wil zetten. Voor de webservers zit ik te denken aan scale set, maar ik moet uitzoeken of het ook gaat lukken met Azure app service of Azure app service met database. En is het voordeliger?

Als het de vm's worden dan in scale set en met loadbalancer. Uitzoeken welke. Azure Application Gateway lijkt voor nu het beste.  

Uitzoeken wat de management server is en of daar verschillende soorten in zijn.

Voor de postdeploymentscripts kan denk ik gewoon gebruik gemaakt worden van de storage account en de blob storage?

DDos protectie staat niet in de omschrijving. Als ik het red zal ik dat toevoegen. Afhankelijk van de prijs. 

## Learnings    
Het was geen foutmelding die ik kreeg bij het aanmaken van de storage account,  maar een melding dat het niet best practise was. De kleur van het golvende lijntje was niet rood maar oranje. Daar dus beter op letten. 

