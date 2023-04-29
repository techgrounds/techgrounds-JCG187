# Opdracht 2 Azure Cost Mangement + Billing


## Key-terms
 **TCO calculator**: Total Cost of Ownership: helpt je te berekenen wat het kost om je on-prem datacenter te verhuizen naar de cloud. Helpt met het inschatten wat je kosten in de toekomst worden in vergelijking met de kosten die gemaakt worden bij een on-prem datacenter. 

 **Pricing tool/pricing calculator**: helpt berekenen welke Azure services het beste bij je budget past.  Je kiest je subscription, resources, services en eventueel thirth party oplossingen en die kosten telt de pricing tool voor je op.  Je kan daarin aanpassingen maken voor de region (welke is goedkoper en past binnen het beleid), wijze van betalen (maandelijks, jaarlijks, as you go?), testmogelijkheden en mate support opties. Link: https://azure.microsoft.com/en-us/pricing/calculator/?azure-portal=true 

 **Azure advisor**: Hiermee kan je de kosten die je maakt monitoren. Het kan aanbevelingen doen voor resources die niet gebruikt worden maar wel beter/voordeliger zijn. En je kan een limiet instellen voor de kosten die op gaan aan de cloud omgeving.   

 **Capex vs Opex**: Capital expenditure: Kosten die je maakt voor de bedrijfsvoering. Als het gaat om uitgaves die je van dag tot dag doet, dan zijn het vak Opex uitgaven. Uitgave lange termijn uitgaves worden Capex genoemd. Voorbeelden van Capex zijn gebouwen, materiaal, machines, en auto's. Opex voorbeelden zijn salaris, rente, cloud.  

 Capital Expenditure (CapEx) is the up-front spending of money on physical infrastructure, and then deducting that up-front expense over time. The up-front cost from CapEx has a value that reduces over time.  

  Operational Expenditure (OpEx) is spending money on services or products now, and being billed for them now. You can deduct this expense in the same year you spend it. There is no up-front cost, as you pay for a service or product as you use it.  

 **Factoren in de cloud die de opex kosten kunnen beinvloeden zijn**:  
 - Resource type: Hierbij gaat het om de typse resources, de settings voor de resources en de region die gekozen wordt. Bij het aanzetten van een resource wordt de teller gestart voor de berekening van de kosten van het verbruik.    
 Bijvoorbeeld het gebruik van opslag. Wat voor type selecteer je, in welke regio plaats je de opslag, wil je redundancy etc. Elke setting kost geld. Hetzelfde geldt voor VM's. Hoeveel processor, hoe groot is het geheugen en in welke regio bepaald de prijs van de vm.   

 - Consumption: Betaal je per gebruik of ga je gebruik maken van een aanbieding waarin je gebruik maakt van een groep resources met soms wel een korting van 72%. Ook kan je contract afsluiten (vaak voor 1 of 3 jaar) voor het gebruik van bepaalde maximum aan resources met de mogelijkheid om meer af te nemen als dit nodig is. Dit geeft ook korting.  

 - Maintenance: Door het aanmaken van resource groups, zorg je ervoor dat de recourses die je gebruikt overzichtelijk zijn terug te vinden. Denk aan VM die je tijdelijk aanmaakt met opslag en netwerk. Als je de VM uitschakeld/weggooid dan blijven netwerk en geheugen opslag bestaan totdat je ze weggooit. Je kan in de resourcegroup zien of je dat niet vergeet.   

 - Geography: Je kan alles aanzetten aan de ander kant van de wereld dicht bij je klanten of dicht bij het hoofdkantoor. Dit kan een verschil in prijs opleveren. De kosten van stroom, belasting, arbeid is overal anders en daardoor is er een prijsverschil in de verschillende geografische locaties.   

 - Network traffic: Hoe verder weg hoe meer kosten. Bij sommige datacentra's  is het om gratis om data naar het datacentrum te sturen. Voor outbound kan het per zone verschillen wat de kosten zijn.  prijzen voor bandbreedte zijn hier te vinden:  https://azure.microsoft.com/nl-nl/pricing/details/bandwidth/ 

 - Azure Marketplace: Hier kan je ook services van third party vendors. Hier zijn uiteraard ook kosten aan verbonden zowel voor de azure services die je erbij nodig hebt, als de kosten voor de service van de third party vendor.   

 **Cost management**: search for: Cost Management + Billing + Billing accounts: Laat snel je kosten overzicht van je verbruik bij Azure zien. Er zijn drie soort alerts:   
 - budget alerts: geven een melding gebasseerd op het limit wat is ingesteld voor gebruik of kosten als het bedrag is bereikt of overschreden wat is opgegeven in de ingestelde alert. Er wordt een mail gestuurd naar personen die als ontvangen van het alarm zijn ingesteld.   
 - Credit alerts: geven een melding als je azure tegoeden die vooraf afgesproken zijn bij de overeenkomst met Azure voor 90% en 100% verbruikt zijn. De account verantwoordelijke krijgt een mail hiervan.  
 - Department spending quota alerts: Geven een melding wanneer de afdelings quota een vooraf vastgesteld quota overschrijden. De afdelingsmanager krijgt een e-mail wanneer er bijvoorbeeld 75% van de quota is bereikt.   

 **Budget**:Hier zet je een bestedingslimiet voor Azure. Je kan dit doen gebasseerd op subscription, resource group, service type of andere criteria. Je stel hier ook een alarm in die per mail gestuurd wordt. Ook is het zichtbaar in de cost alerts area. Je kan het alarm ook zo instellen dat het verbruik van het budget beperkt wordt zodra er een bepaald % van het limiet bereikt wordt.   

 **Tags**:  https://learn.microsoft.com/en-us/training/modules/describe-cost-management-azure/7-describe-purpose-of-tags: Er zijn verschillende soorten tags die je toe kan voegen om georganiseerd te blijven. Vooral als de cloudomgeving heel groot wordt.  
 - Resource management:  
 - Cost management and optimization:   
 - Operations management:  
 - Security:  
 - Governance and regulatory compliance:  
 - workload optimization and automation: 


## Opdracht
Bestudeer:
●	De Azure principes voor kostenmanagement
●	De voorwaarden van de ‘Free subscription’: De voorwaarde is 12 maanden gratis voor populaire services en $200 tegoed voor 30 dagen voor alle services. . 
●	Het verschil tussen CAPEX en OPEX.
●	De TCO-calculator

Opdracht:
●	Maak een alert aan waarmee je eigen kosten kan monitoren. (zie screenshot)
●	Begrijp de opties die Azure aanbiedt om je uitgaven in te zien.


### Gebruikte bronnen
https://azure.microsoft.com/en-us/pricing/details/monitor/  

https://learn.microsoft.com/en-us/azure/cost-management-billing/ 

### Ervaren problemen
Welk limit is realistisch om in te stellen? Iedereen had daar een verschillend idee over. Ik heb mijn limit op 200 euro gezet.
### Resultaat 

Screenshot toevoeging alert
![Alt text](cost%20management.png)