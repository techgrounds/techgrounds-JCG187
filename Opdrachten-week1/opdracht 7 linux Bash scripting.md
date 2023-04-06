# Linux 7 bash scripting


## Key-terms
 $PATH : Is een omgevings variabel die het wordt gebruikt voor het uitvoeren van een script. Voor het uitvoeren van een code moet het systeem de weg weten naar de folders waar (de) script(s) zich bevindt(en). Anders kan het systeem het programma/code niet gebruiken om de script uit te voeren. Deze variabel wordt niet alleen voor het systeem gebruikt, ook gebruikt door programmeurs om informatie op te  op te slaan die door hun app's worden gebruikt. 
 PATH: zijn diverse folders die via : gescheiden zijn van elkaar. Executable files die in een van die folders zitten kunnen uitgevoerd worden zonder dat je aan hoeft welke route het programma moet gaan om in de correcte folder te komen waar de code zit. Het systeem begint bij de eerste folder en gaat zo alle folders langs totdat het systeem een script gevonden heeft wat hoort bij de uitvoer die is ingevoerd door de gebruiker. Dan voert het systeem de code in die script uit. Heb je een script nodig wat altijd in dezelfde folder moet worden uitgevoerd, dan hoef je de PATH variabel er niet aan te geven. 
  
 .profile : folder in de gebruikers folder waarje de variabel PATH die je hebt aangemaakt kan vastleggen zodat het de route vastligt, ook al sluit je de verbinding naar het systeem. 
 nano: text editor in de terminal
 shebang: #!/bin/bash. Dit is de taal die gebruikt wordt voor coderen. Hier wordt aangeven dat BASH gebruikt wordt. 
 ./ : hiermee zeg je tegen de bash vertaler dat de script die je geschreven hebt in de huidige folder zit, van waaruit je de commando geeft om het script uit te voeren.
 chmod +x "filenamescript.sh": geeft aan dat iedereen toestemming heeft om de script uit te voeren
 which "filenaamscript.sh":
 BASH: Born Again Shell

Apache2 is de http server voor Debian based distro's zoals ubuntu. Het is Apache HTTP server. 

route vraag 1:
Ik heb eerste een nieuwe folder aangemaakt via mkdir script aangemaakt in de root directory.
Daarna heb ik de nieuwe abc.sh file gemaakt. 
via chmod 777 heb ik alle toestemmingen geopend.
Daarna gezocht hoe ik de folder in de variabel $PATH kon krijgen en deze ook permanent erin te zetten. 




## Opdracht
#### oefening 1
●	Create a directory called ‘scripts’. Place all the scripts you make in this directory.

●	Add the scripts directory to the PATH variable.

●	Create a script that appends a line of text to a text file whenever it is executed.

●	Create a script that installs the httpd package, activates httpd, and enables httpd. Finally, your script should print the 
    status of httpd in the terminal.
#### oefening 2

●	Create a script that generates a random number between 1 and 10, stores it in a variable, and then appends the number to a text file.

#### oefening 3

●	Create a script that generates a random number between 1 and 10, stores it in a variable, and then appends the number to a text file only if the number is bigger than 5. If the number is 5 or smaller, it should append a line of text to that same text file instead.

### Gebruikte bronnen
uitleg over $PATH
https://janelbrandon.medium.com/understanding-the-path-variable-6eae0936e976

uitleg over httpd in linux en apache2 voor debian based distro's zoals ubuntu. 
https://askubuntu.com/questions/248404/is-there-any-difference-between-apache2-and-httpd

uitleg over hoe apache te installeren
https://ubuntu.com/tutorials/install-and-configure-apache#1-overview


### Ervaren problemen
#### oefening 1
Ik ben nieuw met het schrijven van scripts. Het aanmaken van een nieuwe folder en file ging goed. Wat niet goed ging was de folder in de variabel van $PATH zetten. Ik heb links gekregen hoe ik het moest doen. En ik wou de variabel ook vastzetten zodat die er niet komt te vervallen als ik de connectie met de server verbreek. En dat is mijn grootste probleem. Ik snap niet goed hoe ik de syntax moet lezen/gebruiken. Het heeft lang geduurd voordat het mij lukte om de de code export PATH="/scripts/:$PATH" erin te krijgen. Ik begrijp nu nog steeds niet waarom het persé in hoofdletters moet wezen de variabel PATH. Ik dacht aanvankelijk ook dat als je de folder in één van de folders deed die al in de route van de PATH variabel zit, dat het dan al voldoende was. Maar dat bleek niet zo te zijn.   
Ik ben nog verder gaan zoeken naar een manier om de variabel vast te zetten in de .profile folder zoals aangeven werd. 
Ik heb dat gedaan door de volgende toevoeging:  
fi  
#add script to PATH  
export PATH="/scripts:$PATH"  
--insert--  
Ik weet nog niet of dit zo gelukt is.

Toen heb ik een klein testscript geschreven om te testen of ik de script abc.sh in verschillende directories uit kon voeren.
echo "hello world" en dat lukte. Daarna heb ik de code gemaakt:
echo "hello world">>/home/jennifer/file1.txt  
cat -n /home/jennifer/file1.txt   
Zie printscreen 1. (de # voor de scripst even wegdenken)  
En daarna de script uit laten voeren.  
Zie printscreen 2.

De volgende deelopdracht geeft de volgende vraag. Hoe installeer ik httpd . Dit moet ik opzoeken. Ik zoek op httpd install ubuntu distro. Ik krijg als resultaten alleen hoe ik Apache web server kan installeren. Daarna gezocht naar uitleg over hoe te installeren. En toen de script gemaakt voor de uitvoer.  
Ik had een probleem met de uitvoer van de commando sudo systemctl status apache2. Ik dacht dat daar httpd moest staan ipv apache2. En dat er echo voor moest staan. Ook nog een variabel met de systemctl status apache2 als input. Dit met cat uitgevoerd. Lukte ook niet. En het bleek helemaal niet ingewikkeld te zijn. Ik moest alleen de syntax systemctl status apache2 intypen. Dat op zich is al de commando. Alles wat je in nano zet wordt uitgevoerd. Dat deed het ook bij de andere opdrachten. Omdat er bij de laatse stond dat het in de terminal uitgeprint moest worden, ben ik te ver gaan zoeken. Zie schermprint script-install-http en uitvoer-script-http. 


### Resultaat

printscreen1

![printscreen1](https://user-images.githubusercontent.com/123589199/230458061-1f453706-256e-49e0-8008-23b652f37849.png)

printscreen2

![screenshot2](https://user-images.githubusercontent.com/123589199/230471268-b8175f00-bb73-471c-ae85-c07930e0b55e.png)

printscreen script-install-http


printscreen uitvoer-script-http



