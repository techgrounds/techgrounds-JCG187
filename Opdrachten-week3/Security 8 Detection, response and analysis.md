# Security 8 Detection, response and analysis


## Key-terms
**IDS**:  Staat voor Intrusion Detection System: Dit is de bewaker van je netwerk. Het zoekt naar verdachte pogingen en waarschuwd als die er zijn. Er zijn verschillende oplossingen hiervoor in de markt. Het is een technologische oplossing wat het binnenkomende en uitgaande verkeer monitoord voor verdachte activiteiten en inbreuken op vastgestelde beleidsregels. Het primaire doel is om te detecteren/opsporen/ontdekken en het voorkomen van inbraak in de IT infrastuctuur, en daarna stuurt het een waarschuwing naar de relavante personen. De oplossing kan liggen in hardware apparaten of in software applicaties. Over het algemeen maakt een IDS deel uit van een groter **Security Inforamation and Event Management System (SIEM)**. Als het daar deel van uit maakt, is het je eerste verdedigingslinie. Het detecteerd onverwacht gedrag pro-actief en zal daardoor je gemiddelde tijd om te detecteren verminderen. Want hoe eerder je een poging of succesvolle inbraak vindt, hoe eerder er aktie genomen kan worden om het tegen te gaan en je netwerk nog meer te beveiligen.  Het zijn vaak **passieve** apparaten. Ze beveiligen het systeem niet, maar ze geven wel informatie die je nodig hebt om je netwerk te beveiligen.   

Je hebt netwerk based IDS/IPS en software based. 


Er zijn vijf verschillende IDS systemen:  
1. Netwerk intrusion detection system.  
2. Netwerk node intrusion detection system.  
3. Host intrusion detection systen.  
4. Protocol-based intrusion detection system.  
5. Application protocol-based intrusion detection system  

Er zijn 3 intrusion detection system methods:  
1. Signature based intrusion detection:  zijn beveiligingssystemen die bekende bedreigingen kunnen identificeren door gebruik te maken van vingerafdrukken of handtekeningen van bekende malware of andere schadelijke inhoud. Wanneer de IDS-oplossing een bedreiging identificeert, genereert het een handtekening van de bedreiging en voegt deze toe aan de lijst van handtekeningen die door de IDS-oplossing wordt gebruikt om inkomende inhoud te testen.
2. Anomaly based intrusion detection:Anomaliedetectie op anomalie gebaseerde IDS-oplossingen bouwen een model van het "normale" gedrag van een beveiligd systeem. Dit model wordt vervolgens gebruikt om toekomstig gedrag te vergelijken en eventuele afwijkingen te identificeren die kunnen duiden op een potentiële bedreiging. Als er een afwijking wordt gedetecteerd, genereert het systeem een waarschuwing.

In tegenstelling tot op handtekeningen gebaseerde IDS-oplossingen, kunnen anomaliedetectie op anomalie gebaseerde IDS-oplossingen nieuwe of zero-day bedreigingen detecteren, omdat ze zich richten op het detecteren van afwijkingen van het normale gedrag. Er is echter een uitdaging bij het bouwen van een nauwkeurig model van het "normale" gedrag, omdat er veel variabelen en patronen zijn om rekening mee te houden. Hierdoor moeten deze systemen een balans vinden tussen fout-positieven (onjuiste waarschuwingen) en fout-negatieven (gemiste detecties).

Het verschil tussen op handtekeningen gebaseerde IDS-oplossingen en anomaliedetectie op anomalie gebaseerde IDS-oplossingen is dat op handtekeningen gebaseerde IDS-oplossingen gericht zijn op het detecteren van bekende bedreigingen en zich richten op het identificeren van een specifieke handtekening van een bedreiging. Anomaliedetectie op anomalie gebaseerde IDS-oplossingen daarentegen zijn gericht op het detecteren van afwijkingen van het normale gedrag, wat betekent dat ze kunnen worden gebruikt om nieuwe of zero-day bedreigingen te detecteren.
3. hybrid intrusion detection:  Maakt gebruik van zowel signature als anomaly based detection.   


IDS evasion Techniques:  
1. Fragmentation: (Opknippen in kleine stukjes) Kleine pakketjes zijn geen signaleringspunt. De pakketjes worden later weer samengevoegd door de IP laag van de ontvangende node en dan doorgestuurd naar de applicatielaag. Fragmentatieaanvallen genereren kwaadaardige pakketten door gegevens ingefragmenteerde pakketten te vervangen door nieuwe gegevens.  
2. Flooding: (Overstromen met pakketjes) Deze aanval is gebaseerd op het overweldigen van het detectie device. Hierdoor heeft het geen controlle meer en zal het mechanisme  niet meer werken. Hierdoor wordt al het verkeer toegestaan. Een manier om dit te doen is door het legitieme User Datagram Protocol (UDP) en Internet Control Message Protocol (ICMP) te vervalsen. De verkeersoverlast wordt vervolgens gebruikt om de afwijkende activiteiten van de dader te camoufleren. Als gevolg hiervan zou de IDS grote moeite hebben om kwaadaardige pakketten te vinden in een overweldigende hoeveelheid verkeer. 
3. Obfuscation: (Verduistering van info)  De gegevens worden zo gestuurd dat ze moeilijk te begrijpen zijn. Hierdoor kan een aanval verborgen blijven. Dit wordt gedaan door de programmacode op dusdanige manier te wijzigen dat deze functioneel niet van elkaar te onderscheiden is. Door malware te verdoezelen kan deze de IDS omzeilen. 
4. Encrypton:  Makers van malware gebruiken beveiligingskenmerken om aanvallen te verbergen en detectie te omzeilen. Een voorbeeld van deze situatie zou kunnen zijn dat een hacker een versleutelde e-mail probeert te sturen naar een bedrijfsnetwerk. Het IDS kan de versleutelde inhoud niet lezen en kan geen bestaande database-handtekeningen vinden die overeenkomen met de versleutelde verkeersstroom. Hierdoor kan het IDS de aanval niet identificeren en kan de hacker ongemerkt toegang krijgen tot het bedrijfsnetwerk.

**IPS**: Staat voor Intrusion Prevention System. In tegenstelling tot een IDS is dit een **actieve** beveiligings systeem. Het onderneemt acties om een geidentificeerde dreiging te blokkeren of te verhelpen. Het kan ook een waarschuwing geven, maar het helpt 

Waar worden IPS/IDS geplaatst in het netwerk:


**Zero-day-kwetsbaarheden**:   

**Hack response strategies**:   
Maak en stappenplan waarop staat wat gedaan moet worden bij een breuk: Maak een continuiteitsplan. Je kan hiervoor gebruik maken van de NIST Computer Security Incident Handling Guide (SP 800-61).  

Er zijn vier gebieden die bekeken moeten worden.   
A. Voorbereiding: plan vooraf wat te doen en voorkom beveiligingsincidenten.  
B. Detectie en Analyse: omvat alles van mogelijke factoren voor een aanval tot het zoeken naar een incident en opstellen wat prioriteit heeft en wat niet. 
C. Inperking, uitroeiing en herstel: bedenk strategien om de hack te beperken. Identificeer de systemen die geinfecteerd zijn, en plan hoe je deze weer kunt herstellen.  
D. Acties na het incident: Leer van het incident waar de zwakheden zaten en dicht deze voor de toekomst. En zorg voor een plan om bewijsmateriaal te bewaren van het incident.   

Response strategie:  
1. preventie: zorg ervoor dat je data van vorige aanvallen is verwerkt in je continuiteitsplan. Zodra je weet hoe het gebeurd is, gelijk stappen ondernemen om  het nogmaals te voorkomen. Iedereen moet hiervan op de hoogte gesteld worden.
2. communicatie en delegatie: informeer iedereen dat er een hack plaatsvindt/heeft plaats gevonden. Stel iemand aan die de volgende stappen leidt.
3. onderzoek: onderzoek en omschrijf de manier van de hack.   
4. zorg voor zo min mogelijkschade en herstellen van de opgelopen schade: 
5. zorg ervoor dat alle systemen up to date zijn: 
6. schade opnemen: kijk niet alleen naar de kosten ontstaan door de hack maar ook naar kosten van het implementeren van beveiliging hiervoor. Vaak zijn dit de hoogste kosten.  

**System hardening**: is een proces voor het beveiligen van computersystemen voor cyberaanvallen en beveiligings dreigingen door de kwetsbaarheid te verminderen van het computer systeem. Dit wordt gedaan door een combinatie van hardware, software en ingestelde policies zo in te richten dat het moeilijk wordt voor een hacker om het systeem binnen te komen.  

**RPO**: Recovery Point Objective: Is de tijd vanaf een goede volledige backup naar het moment van de storing. De tijd hiertussen is het verlies van data. Deze data krijg je niet meer terug. Die ben je kwijt. Je moet dus bij het maken van een netwerk gaan bedenken hoe lang hoeveel data kan je verliezen zonder in problemen te raken. Dit is iets wat je je per applicatie af moet vragen. Emails zijn belangrijk en daar moet vaak een backup of snapshot van gemaakt worden. Je  hoeft niet zo vaak van een file een backup te maken. Eens in de 24 uur kan voldoende zijn. Het is een kosten en baten afweging. Hoe meer backups of snapshots je maakt hoe meer het kost qua apparaten.  

**RTO**: Recovery Time Objective: Dit is het moment waarop je weer volledig up and running bent vanaf de storing. Hoe lang ben je down vanaf de storing totdat je weer volledig operationeel bent. Dit heeft niks te maken met data wat je verlies. Het heeft te maken met hoe snel je weer operationeel zijn. Heb ik een reserve server of data center? Welke downtime kan ik me veroorloven? Dit is ook iets wat je voor elke appliatie moet afvragen. Je internet kan cruciaal zijn voor de bedrijfsvoering en die moet dus snel weer actief zijn. Dan kan je denken aan DNS servers die het niet meer doen. Een fileserver hoeft misschien niet zo snel weer online te zijn. Het gaat hier om redundancy. Kan ik snel een nieuwe vm opstarten?


## Opdracht  

Study:
●	IDS and IPS.
●	Hack response strategies.
●	The concept of systems hardening.
●	Different types of disaster recovery options.



●	A Company makes daily backups of their database. The database is automatically recovered when a failure happens using the most recent available backup. The recovery happens on a different physical machine than the original database, and the entire process takes about 15 minutes. What is the RPO of the database?  Antwoord 1 dag
●	An automatic failover to a backup web server has been configured for a website. Because the backup has to be powered on first and has to pull the newest version of the website from GitHub, the process takes about 8 minutes. What is the RTO of the website? antwoord 8 minuten.


### Gebruikte bronnen
Info over IDS:  
https://www.helixstorm.com/blog/types-of-intrusion-detection-systems/  

https://www.paloaltonetworks.com/cyberpedia/what-is-an-intrusion-detection-system-ids 

Info over IPS en IDS:  
https://www.checkpoint.com/cyber-hub/network-security/what-is-an-intrusion-detection-system-ids/ids-vs-ips/

Site voor responces to attacks:  
https://www.msp360.com/resources/blog/how-to-respond-to-cyberattacks/    

Sit voor framework responce:  
https://www.nist.gov/cyberframework

system hardening:  
https://ubuntu.com/blog/what-is-system-hardening-definition-and-best-practices   
https://www.beyondtrust.com/resources/glossary/systems-hardening 

Data recovery:  
https://cloudian.com/guides/disaster-recovery/disaster-recovery-solutions-top-5-types-and-how-to-choose/  
https://blog.tbconsulting.com/critical-data-backup-and-recovery-strategy-best-practices    

RPO en RTO:  
https://www.datto.com/nl/blog/het-belang-van-rpo-en-rto#:~:text=RPO%20versus%20RTO%3A%20Wat%20is,wat%20voor%20vorm%20dan%20ook.  
https://www.precisely.com/blog/data-availability/calculate-rpo-rto-disaster-recovery  
https://www.unitrends.com/blog/rpo-rto




### Ervaren problemen


### Resultaat
