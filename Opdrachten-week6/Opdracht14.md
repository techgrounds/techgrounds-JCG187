# Linux


## Key-terms
 
 **Azure Container Instance (ACI)**: 
 Is een geisoleerde omgeving waarin softwareprogramma's kunnen worden uitgevoerd. Het emuleert een OS. Je kan verschillende onderdelen toevoegen die je nodig hebt van verschillende applicaties toevoegen aan een container en die in een afgeschermde omgeving gebruiken.   
 Zijn kosten besparend omdat je alleen voor de consumptie van CPU en geheugen hoeft te betalen. 
 Makkelijk op te schalen.  
 Met ACI is  het mogelijk om een groep containers (van linux) te beheren. Deze draaien allemaal op dezelfde hostmachine, met hetzelfde besturingssysteem, lifecycle, lokale netwerk, resources/bronnen en opslag.

 Kan samenwerken met Azure files om daar data in op te slaan die later weer gebruikt kan worden voor de bewerkingen in de container instance. 

 Wordt gebruikt voor kleine/simple web apps/servies, background jobs of ingeplande scripts. 

 **Azure support plans**:  
 Je kan support krijgen van Azure bij het ontwikkelen van je cloudomgeving. Hiervoor zijn verschillende abonnementen.  
 Je hebt basis, ontwikkelaar, standaard en professioneel direct. Aan elk abonnement hangt een ander prijskaartje en ondersteuningsopties.   
 Deze moet je goed weten voor het examen. Basic support is de goedkoopste 24\7 optie voor support. Dit omdat je altijd de documentatie kan nalezen op internet. 

 **Azure Advisor**: 
Een dienst die aanbevelingen doet om je te helpen je Azure-resources te optimaliseren voor een betrouwbaar, beveiligd, operationeel uitmuntend, prestatieverbeterend en kostenbewust gebruik.  
Het doet voorstellen die je direct kunt uitvoeren, uit kan stellen of negeren door op het advies te klikken wordt je geleid naar de mogelijkheid om het advies te realiseren. 
Het is te vinden in het portaal van Azure.   
Het is gratis. 

**Azure app configuration**:
Gecentraliseerde service dat helpt met het managen van alle applicatie settingen en feature flag.   
Je kan de nieuwe functie in de app configuration zetten en koppelen aan de app. Als alles getest is kan je de nieuwe funcit via app configuration implementeren in de app.  

**Event grid**:  
Daar kan je de data op laten slaan die voortkomt uit het aan of uitschakelen van de feature flag. Je kan een toepassing informatie, die jij wilt, door laten geven, van wat er gebeurd tijdens het aan en uitdoen van een feature flag. Deze info kan je per mail ontvangen, het kan een webhook zijn die aangeroepen wordt of het kan een functie uit laten voeren. Afhankelijk van de instellingen die je meegeeft.

**webhook**:


**Feature Flag**:
Een feature flag helpt met het implementeren van een nieuwe functie aan een applicatie. Je kan hiermee de nieuwe functie aan of uitzetten. Hierdoor kan je de nieuwe functie testen voordat je het uitrolt aan alle gebruikers. Je kan met deze functie ook het verkeer naar je app omleiden zodat de nieuwe functie alleen voor een selecte groep beschikbaar is. 

**Azure Functions App**"
Is een oplossing voor het laten uitvoeren van kleine stukjes code ofwel functies in de cloud. 

Het zorgt ervoor dat je alleen de code hoeft te gebruiken voor het probleem wat je op wil lossen zonder te hoeven denken aan de algehele onderliggende applicatie of the infrastructuur om de code uit te voeren. Het is een goedkope en schaalbare manier om scripts serverless uit te voeren. 

- Betalen per gebruik. Eerste 400000GB en 1000000 executies zijn gratis. Daarna nog steeds erg goedkoop. €0.169 per miljoen executies. 
- Je kan je eigen    


**Azure Active Directory**:
Een systeem voor identiteits en toegangs management. Azure Active Directory geeft toegang voor cloud applicaties.   
Dat geldt ook voor toegang tot Microsoft 365.   
Het kan ook gebruikt worden voor toegang tot web gebaseerde applicaties in de on-prem omgeving.  
Het is een service die door Azure onderhouden wordt. Je hoeft je dus geen zorgen te maken over de onderliggende infrastuctuur.
Met Azure AD connect kan je de on-prem AD verbinden met de Azure AD.  
Dit zorgt ervoor dat accounts automatisch aangemaakt worden in Azure AD en gesynchroniseerd wordt met je on prem AD. 
Het zorgt ervoor dat gebruikers, gebruik kunnen maken van Single Sing On (SSO). Hierdoor hoeven ze maar 1 keer in te loggen voor de Azure omgeving en de on prem omgeving. 
Je kan SSO ook gebruik voo inlog in de Microsoft 365 omgeving. 

Wanneer je aanmeld voor een abonnement op Azure, dan wordt er automatisch een Azure AD Tenant aangemaakt. Deze tenant is een instance/gebruiker/ van Azure AD dat wordt toegewezen aan jou.
Voor elke nieuwe klant wordt een nieuwe tenant aangemaakt.
Elke tenant heeft zijn eigen map voor gebruikers, groepen en apps. 

Je organisatie kan meerdere abonnementen willen. Waarbij elk abonnement een eigen tenant heeft. Bijvoorbeeld een abonnement per afdeling zodat elke afdeling zijn eigen Azure resources kan beheren. Het makkelijkste is om bij meerdere abonnementen toch 1 tenant te creeeren. Dit maakt beheer makkelijker. Elke afdeling kan dan zijn eigen resources creeeren en beheren. Je kan maar één tenant per subscriptie hebben. Je kan wel de tenant wijzigen van subscripty. Dus één tenant kan meerder subscripties bevatten. 

De belangrijkste taak van Azure AD is authenticatie. Voorheen bestond dat uit een inlognaam en wachtwoord maar nu bestaat dat uit meerdere checks. Dus niet alleen iets wat een gebruiker weet maar ook iets wat een gebruiker heeft (telefoon) of iets wat een gebruiker is (vingerprint)
De belangrijkste MFA (Multi Factor Authentication methods) in Azure  voor wat je hebt zijn:  
Access code sent by SMS  
Access codes sent by Voice call  
Microsoft Authentication App 
Hardware keys  
OATH software tokens

En voor wat je bent is:
Windows Hello for business. Dat bestaat uit gezichtsherkenning en vingerafdruk herkenning. 

Je kan ook gebruik maken van inloggen zonder wachtwoord. Je maakt dan alleen gebruik van wat je hebt en wat je bent. 

Je hebt  hier drie opties voor:
Windows Hello  
Microsoft Authencticator  
FID02 security key 

Het gebruik van deze methodes kan meer kosten in Azure. Gratis is het gebruik van alleen de Microsoft Authenticator app.   

Bij een premium account kan je ook, naast alle andere opties, instellen dat gebruikers alleen met een windows 10 of hoger mogen inloggen.  

Het idee erachter is, dat het identiteitsignalen gebruikt om wel of geen toegang te geven.   

Een ander voorbeeld is lokatie. Je kan land, regio, IP adres ranges gebruiken om in te loggen. Komen deze niet overeen met de vooraf ingestelde bepalingen dan wordt je geblokt of moet je een MFA gebruiken. Je kan bepalen dat er een limiet is op het aantal applicaties waarop een gebruiker inlogt. Je kan een limiet stellen vanaf welk applicatie een gebruiker inlogt. De apparaten moeten aangemeld zijn in Azure AD. 

Microsoft Intune: Is een apparaat management







## Opdracht
Bestudeer: 
●	Containers    
●	Azure Support Plans	  
●	Azure Advisor  
●	Azure App Configuration  
●	Azure Activity Log 

Opdracht:  
●	Azure Active Directory  
●	Azure Monitor  
●	CosmosDB  
●	Azure Functions  
●	Event Grid, Queue Storage, Service Bus 



### Gebruikte bronnen
Azure support plans:  
https://azure.microsoft.com/nl-nl/support/plans 

Azure Advisor:  
https://azure.microsoft.com/nl-nl/products/advisor/#features


Azure App configuration:  
https://www.youtube.com/watch?v=t6m13DxUJMc
### Ervaren problemen


### Resultaat
