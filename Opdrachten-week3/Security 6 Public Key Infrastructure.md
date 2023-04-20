# Security 6 Public Key Infrastructure


## Key-terms
PKI: Public Key Infrastructure. Dit zorgt er in het kort voor dat je website veilig is om naar toe te gaan. Er wordt als eerste een sleutelpaar gecreeerd. Een publieke sleutel en een prive sleutel. Omdat communicatie met symmetrische sleutels sneller is, wordt er ook een symmetrische sleutel gemaakt. Deze symmetrische sleutel wordt encrypted met een asymmetrische sleutel. De encrypted symmetrische sleutel wordt naar de klant gestuurd die dan met de publiek sleutel het asymmeteric ingepakte symmetric sleutel kan decrypten. Daarna maak je een **certificate request**. Daar zit info in zoals de website die je gaat gebruiken, De naam van de administrator van de website en heel belangrijk, je publieke sleutel, etc. Deze request verstuur je naar een **certifcate authority**. Zij accorderen de aanvraag en dan krijgt je het certificaat. Het certificaat zorgt ervoor dat je kan laten zien aan de wereld dat jou site veilig is en dat jou sleutel van jou is. De certificat authority zal een aantal vragen stellen en de antwoorden in het certificaat zetten. Het is een zogenaamde trusted **thirt party**. Omdat de CA een betrouwbaar derde partij is, kan je ervan uit gaan dat het certificaat goed is (en daarmee de website betrouwbaar is) wat zij afgegeven hebben. Er zijn meerdere CA's. Maar zolang die vertrouwd worden door andere CA's, is jou ontvangen certificaat ook betrouwbaar. De CA staat garant voor de veiligheid van jou website dmv het certificaat. En de CA die het afgeeft is betrouwbaar omdat/zolang andere CA's garant staan voor die CA. Als het request is goedgekeurd, wordt er een digitale handtekening aan toegevoegd door de CA. Hierdoor kan iedereen zien dat zij garant staan voor de echtheid. Hoe maken ze die digitale handtekening? Dit doen ze door een speciale algorithme op de certificaat uit te voeren. Dit wordt een **hash** genoemd. De hash vat alle info in de certificaat samen. Als er een wijziging aangebracht wordt in de certificaat dan veranderd de hashwaarde. De CA gebruikt zijn prive sleutel om die hash waarde te encrypten. De klant kan de public sleutel van de CA gebruiken om de hash te decrypten. Zo weet je dat het certificaat goed is. De publieke sleutel van de CA zit al in de browers ingebakken.   

**Openssl**: Dit is een gratis open-source bibliotheek wat je kan gebruiken voor digitale certificaten. Je kan er je eigen certificat authority meer maken. 

**FQDN**: Is een absolute domeinnaam. Het is een domeinnaam die de exacte locatie aangeeft in de boomhierarchy van het DNS. Dus www.yahoo.com.  




## Opdracht
.

### Gebruikte bronnen
https://ubuntu.com/server/docs/security-certificates 

https://www.youtube.com/watch?v=0ctat6RBrFo  

Hoe je eigen CA te maken:  
https://networklessons.com/uncategorized/openssl-certification-authority-ca-ubuntu-server 

Tijdzone aanpassen:  
https://phoenixnap.com/kb/how-to-set-or-change-timezone-date-time-ubuntu

### Ervaren problemen


### Resultaat
