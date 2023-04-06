# Linux 7 bash scripting


## Key-terms
 $PATH : Is een omgevings variabel die het wordt gebruikt voor het uitvoeren van een script. Voor het uitvoeren van een code moet het systeem de weg weten naar de folders waar de script zich bevindt. Anders kan het systeem het programma de code niet gebruiken om de script uit te voeren. 
 .profile
 nano: text editor in de terminal
 shebang: #!/bin/bash. Dit is de taal die gebruikt wordt
 ./ : hiermee zeg de tegen de bash vertaler dat de script die je geschreven hebt in die folder zit waar je de commando geeft om het script uit te voeren.
 chmod +x "filenamescript.sh": geeft aan dat iedereen toestemming heeft om de script uit te voeren
 which "filenaamscript.sh":
 BASH: Born Again Shell

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
### Ervaren problemen
#### oefening 1
Ik ben nieuw met het schrijven van scripts. Het aanmaken van een nieuwe folder en file ging goed. Wat niet goed ging was de folder in de variabel van $PATH zetten. Ik heb links gekregen hoe ik het moest doen. En ik wou de variabel ook vastzetten zodat die er niet komt te vervallen als ik de connectie met de server verbreek. En dat is mijn grootste probleem. Ik snap niet goed hoe ik de syntax moet lezen/gebruiken. Het heeft lang geduurd voordat het mij lukte om de de code export PATH="/scripts/:$PATH" erin te krijgen. Ik begrijp nu nog steeds niet waarom het persé in hoofdletters moet wezen de variabel PATH.

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
Zie printscreen 1.


### Resultaat
