> **Versie 1.0 vereisten**  

**Netwerk**  

    - Er zijn 2 Vnets nodig. 10.10.10.0/2 en 10.20.20.0/24 
    - De Vnets moeten via peering aan elkaar gekoppeld worden
    - Er moeten 2 subnets aangemaakt worden 
    - De subnets moeten beschermd worden met een NSG  
    - De NSG moet open staan voor de webserver: SSH  
    - De NSG moet open staan voor de adminserver: RDP      
      
**Managementserver**  

    - Via managementserver moet je toegang creeeren tot:
        a. De webserver
        b. De storage account
        c. De Sql server
        d. De key vault
        e. De backup vault
    - De gegevens op de disk van de server  moet encrypted zijn
    - De server mag alleen vanaf een vertrouwde locatie benaderd worden (thuis of kantoor)
    - De server moet bereikbaar zijn via een publieke adres    
    - De server moet in 2 availability zones geplaatst worden
    - De server moet via vnet 
    - De server een SLA van 99% hebben   


**Webserver**  

    - De webserver moet op een geautomatiseerde manier geinstalleerd worden
    - De gegevens op de disk van de server moet encrypted zijn
    - De gegevens moeten dagelijks een backup krijgen
    - De backup moet 7 dagen bewaard blijven
    - De server moet in 2 availability zones geplaatst worden
    - De webserver zal niet zo druk bezocht worden. Klanten kunnen zich via de webserver aanmelden voor een nieuwsbrief
    - De gegevens van de webserver naar de sql server moet gecodeerd zijn

**Storage account**  

    - Moet een postdeploymentscript bevatten  
    - Mag niet publiekelijk toegankelijk zijn
    - Toegang via management server   
    - Data at rest moet encrypted zijn
    - Koppelen aan key vault

**Key vault**   

    - Hierin alle sleutels opslaan voor toegang naar of encryptie van:
        a. Webserver
        b. Management server
        c. Storage account
        d. Sql server
        e. Backup vault
        
**Sql server**  

- Data in motion moet encrypted zijn  
- Verbinden met web en managementserver 
- Er hoeft geen database aangemaakt te worden   
- SLA is 99%


**Recovery vault**  

- Er moet dagelijks een backup gemaakt worden van de webserver  
- De backup moet 7 dagen bewaard blijven 


**Algehele vereiste**
- Het moet zo goedkoop mogelijk  
- Het budget mag €50 niet overschrijden



**vragen die ik heb**  
- Wat kan gebruikt worden als de management server?  
- Hoe kan ik een connectie maken naar de sql server?  
- Hoe kan ik een connectie maken naar de key vault. Moet dat ook kunnen of gaat dit automatisch?  
- Hoe werkt de verbinding naar de Sql server? Wordt deze aangesloten op het vnet of gaat dat via een andere manier?
- Hoe werkt de verbinding naar de key vault vanuit de verschillende resources?
- Is het nodig om toegang te krijgen tot de key vault als administrator?
- Hoe werkt de verbinding naar de recovery vault vanaf de webserver?
- Hoe zorg ik ervoor dat alle disks encrypted zijn?
- Welke sql service zal ik gebruiken?
- hoe moeten de nsg's ingesteld worden?
- moet de sql server aangesloten worden op de vnet van de webserver? Kan dat?
-Voor een SSH verbinding heb je sleutels nodig. Deze moeten op de management server komen en op de webserver. Hoe krijg je dat voor elkaar bij deployment? Moet dat ook zo? Of kan het op een andere manier?




**beslissingen**
- Voor de webserver gekozen voor een virtuele machine van Ubuntu. De product owner heeft aangegeven dat de goedkoopste mogelijkheid gebruikt moet worden. Dat is dmv een ubuntu web server. 



**Gereed bij 2e sprint revieuw**
 - 2 vnets met peering  
 - 1 webserver met een werkende website
 - 1 managementserver die via rdp benaderd kan worden




 **Versie 1.1 vereisten**
 - Er moet een proxy tussen de webserver en het internet komen.  
 - De webserver mag geen publiek IP meer hebben waarop het benaderd kan worden
 - HTTP connectie naar de webserver moet omgezet worden naar een HTTPS verbinding via de loadbalancer
 - De verbinding naar de webserver moet beveiligd worden via TLS 1.2  
 - De webserver moet een healthcheck krijgen met enige regelmaat  
 - Bij falen van de healthcheck, moet de webserver automatisch hersteld worden
 - De webserver moet automatisch opschalen bij hoge belasting naar max 3 servers
 - Er moet een self-signed certificate aangemaakt worden



 **vragen die ik heb**
 - Wat kan als proxy gebruikt worden?
 - Wat is een TLS 1.2 beveiliging voor een netwerkverbinding?
 - Wat kan voor een healthcheck zorgen en ervoor zorgen dat er een nieuwe webserver wordt aangemaakt. Kan dat via scale set?
 - Hoe maak je een self-signed certificate?
 - Hoe zorg je ervoor dat een self-signed certificat bij de klant komt?



