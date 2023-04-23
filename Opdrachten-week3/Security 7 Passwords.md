# Security 7 Passwords


## Key-terms
 **Hash algoritme or message digest**: Een hash algoritme is een getal, vaak in hexadecimaal geschreven, van de som van alles wat in een bestand staat. het bestand wordt samengedrukt en nog eens samengedrukt totdat er een getal over blijft. De hash heeft een vaste groote, ongeacht het bestand. **De hash kan niet uitgepakt worden tot het originele bestand**. Een hash is ter controlle . Hash zijn bedoeld om grote databestande mee te verifieren (authentication) en te versturen. 
 Er zijn drie vereisten:  
 1. Het moet snel zijn. Het moet een groot bestand in een paar seconden kunnen samenvoegen. Het mag ook niet te snel zijn want dan is het snel te ontcijferen.   
 2. Als je een bit in het bestand wijzigd, maakt niet uit waar in het bestand, dan mag de uitkomst van de hash niet meer kloppen.  
 3. Je moet voorkomen dat twee documenten dezelfde hash hebben. Verouderde hash functies zoals md5 daarvan zijn heel veel hash's bekend waardoor die gemakkelijk te kraken zijn.    

 Ander artikelen schrijven het volgende:
 What security properties should a good hash function exhibit?
1.  Deterministic: A given message should always produce the same digest. Otherwise, it's not useful for integrity checks.
2. One-way (pre-image resistance): It should not be feasible to recover the original message given the digest. Otherwise the digest of a message would leak the message, making it difficult to control message confidentiality.
3. Weak collision resistant (second pre-image resistance): It should not be feasible to generate an arbitrary message that produces a given digest. Otherwise, a malicious person could trick your integrity check into accepting the wrong message.
4. Strong collision resistant: It should not be feasible that two reasonably similar messages will result in the same digest. If so, an attacker could simply swap signatures on different messages, for example.
5. Unpredictability: Because otherwise, #3 and #4 are much easier to accomplish, and because changes in a digest could then leak information about the message.

Andere artikelen schrijven het volgende:
  Welke beveiligingseigenschappen moet een goede hashfunctie hebben?
1. Deterministisch: een bepaald bericht moet altijd dezelfde samenvatting opleveren. Anders is het niet nuttig voor integriteitscontroles.
2. One-way (pre-image weerstand): Het zou niet haalbaar moeten zijn om het oorspronkelijke bericht te herstellen gezien de samenvatting. Anders zou de samenvatting van een bericht het bericht uitlekken, waardoor het moeilijk wordt om de vertrouwelijkheid van berichten te controleren.
3. Zwakke weerstand tegen botsingen (tweede voorbeeldweerstand): het zou niet haalbaar moeten zijn om een willekeurig bericht te genereren dat een bepaalde samenvatting produceert. Anders zou een kwaadwillende persoon uw integriteitscontrole kunnen misleiden om het verkeerde bericht te accepteren.
4. Sterk botsingsbestendig: het zou niet haalbaar moeten zijn dat twee redelijk vergelijkbare berichten in dezelfde samenvatting resulteren. Als dat zo is, kan een aanvaller bijvoorbeeld eenvoudig handtekeningen op verschillende berichten verwisselen.
5. Onvoorspelbaarheid: omdat anders nr. 3 en nr. 4 veel gemakkelijker te realiseren zijn en omdat wijzigingen in een samenvatting dan informatie over het bericht kunnen lekken.
  

 Andere hash methodes zijn sha-1, sha-265, sha-512. De nieuwst is SHA-3. National Institute of Standards and Technology  
 Sha3-256 hash betekend dat het derde sha versie is en de output is 256 bits groot. Het maakt dus niet uit hoe groot het bestand is wa wordt gehashed. De uitkomst is altijd 256 bits groot.

 **Hashtable**  

 **Hashmap** 

 **Rainbow table** Is a database of well known passwords and their hashes.   

 **Dictionary Attack**: Proberen om het wachtwoord te raden door veel gebruikte wachtwoorden te voorzien van een hash en deze te vergelijken.   

 **Bruteforce attack**: Allerlei combinaties uitproberen totdat je de hash gevonden hebt. Dit is erg duur en kan lang duren. Hoe langer het wachtwoord hoe moeilijker om te breken. 

 **Hackers**: Omdat dezelfde wachtwoorden dezelfde hash creeeren, zijn de hash van wachtwoorden die veel gebruikt worden algemeen bekend.

 **Salts**: Zijn korte willekeurige rijtjes van tekens die toegevoegd zijn aan het wachtwoord voordat deze een hash krijgen. Als de gebruiker zijn wachtwoord invoert dan wordt dit automatisch toegevoegd en daarna wordt het omgezet naar een hash en vergeleken met de hash in de database. Deze salts worden vaak in 'plain text' bewaard, samen met de hash uitkomst. Zo weet de website welke 'salt' deze moet gebruiken om het wachtwoord en de 'salt' om te zetten naar de hash als er ingelogd wordt. Dit laatste maakt het wel mogelijk om de hash te kraken zolang de aanvaller weet waar de salt geplaatst is in het wachtwoord. Maar rainbow tables kunnen hier niet gebruikt worden waardoor het moeilijker is om te kraken.   

 **Pepper**: Is een korte willekeurige reeks of karakters die voor elk wachtwoord anders zijn. De computer gaat langs alle mogelijkheden die er zijn van alle peppers. Stel alle peppers zijn het alfabet in kleine letters en hoofdletter. Stel het wachtwoord is Mijnhondislief. Dan wordt daar een hoofdletter M aan toegevoegd. En dan wordt er een hash van gemaakt.  Als de gebruiker inlogt zal de computer eerst zoeken naar Mijnhondisliefa, gevolgd door Mijnhondisliefb etc. Dit maakt het moeilijker voor de hacker om de hash te kraken. 


A users password is hashed at login. This hash is compared to the hash in the database. When the same, the user gets access. If someone gets a hold of the passwords of a database, they cannot use the hash as it cannot be decripted.  

Een paswoord wat encrypted is, kan wel decrypt worden. Daarom geeft een hash meer beveiliging. Hoe Moeilijker het wachtwoord hoe minder de kans dat de hash bekend is en in een rainbow table staat. 


## Opdracht
●	Find out what hashing is and why it is preferred over symmetric encryption for storing passwords.  
●	Find out how a Rainbow Table can be used to crack hashed passwords.  
●	Below are two MD5 password hashes. One is a weak password, the other is a string of 16 randomly generated characters. Try to look up both hashes in a Rainbow Table.  
03F6D7D1D9AAE7160C05F71CE485AD31 = welldone!     
03D086C9B98F90D628F2D1BD84CFA6CA
●	Create a new user in Linux with the password 12345. Look up the hash in a Rainbow Table.  
●	Despite the bad password, and the fact that Linux uses common hashing algorithms, you won’t get a match in the Rainbow Table. This is because the password is salted. To understand how salting works, find a peer who has the same password in /etc/shadow, and compare hashes.

### Gebruikte bronnen
Uitleg over hash algoritme:  
https://www.youtube.com/watch?v=b4b8ktEV4Bg  

Rainbow table hash decription site:
https://hashes.com/nl/decrypt/hash  

Password hashing:  
https://www.youtube.com/watch?v=--tnZMuoK3E  
  
Hash funcions:  
https://csrc.nist.gov/projects/hash-functions   

Voordelen en nadelen van verschillende soorten hash algorithm:
https://codesigningstore.com/hash-algorithm-comparison

https://en.wikipedia.org/wiki/Secure_Hash_Algorithms  

site om hash te decoderen:
https://hashes.com/nl/decrypt/hash  

Salt en pepper:   
https://www.youtube.com/watch?v=FvstbO787Qo





### Ervaren problemen


### Resultaat
