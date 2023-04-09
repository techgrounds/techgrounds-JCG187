# Linux
stappen:  
opzoeken code voor datum en tijd ..
dat is 'date'. Dit in de terminal gezet en bij enter komt er de datum en tijd als antwoord.  
crontime.txt aangemaakt rechten aangepast  naar rwx
crontime.sh aangemaakt en rechten aangepast naar rwx 
script gemaakt en getest in de terminal. Dat ging een paar keer mis. 
opzoeken wat een cronjob is   
logfile met touch aangemaakt in de juiste directory en de rechten aangepast naar rw- 
crontab -e gebruikt om de cron aan te maken.
opgezocht hoe de tijdschedule werkt bij een cronjob  
crontime.sh toegevoegd aan crontab -e  
gekeken of de cronjob werkte in de tekst bestand.   

stappen:   
opgezocht hoe je de kan zien wat er is gebruikt van de harde schijf  
script gescreven en getest in de terminal  
logfile aangemaakt en rechten aangepast  
crontab -e geopend en .sh script toegevoegd.   
getest door elke minuut te laten lopen.  
schedule aangepast naar wekelijks. 


## Key-terms
cron jobs: script wat automatisch opstart en op gespecificeerde tijden de opdracht uitvoert.   



## Opdracht
●	Create a Bash script that writes the current date and time to a file in your home directory.

●	Register the script in your crontab so that it runs every minute.

●	Create a script that writes available disk space to a log file in ‘/var/logs’. Use a cron job so that it runs weekly.



### Gebruikte bronnen
gezocht op date and time bash  
https://tecadmin.net/get-current-date-and-time-in-bash/  

gezocht op youtube naar korte tutorial cronjobs 
https://www.youtube.com/watch?v=7MFMnsnfBJs    
  
website met info over cron  
https://www.cyberciti.biz/faq/how-do-i-add-jobs-to-cron-under-linux-or-unix-oses/

gezocht naar available disk space linux  
https://www.hostinger.com/tutorials/vps/how-to-check-and-manage-disk-space-via-terminal 

### Ervaren problemen
#### cronjob time  
Ik heb in eerste instantie een spatie gezet in de crontime.sh script tussen >> /home/jennifer/crontime.txt. Dat werkt niet. Het moet >>/home/jennifer/crontime.txt zijn.
bij het schrijven van het script begon ik met echo. Toen kreeg ik steeds het woord date in crontime.txt. Echo weggehaald en toen lukt het.  
Ik had veel problemen  met de uitvoer van de cron. De datum en tijd kwam maar niet in het tekst bestand. Ik heb verschillende varianten geprobeerd van de script. Uiteindelijk bleek de instelling van cron op elk 1 minuut na elk uur te staan ipv elk minuut van het uur. Ik denk dat het het beste is om cron altijd met een tool te berekenen ipv het zelf doen.    
#### cronjog log available disk space   
In eerste instantie dacht ik dat ik geen log.file zelf aan kon maken via touch. Daarom lopen zoeken naar hoe je een log.file aanmaakt via google. Dan kom je op dingen als Rsyslog en logrotate, maar dat zag er toch te moeilijk uit. Toen maar geprobeerd om in de log directory zelf een .log bestand aan te maken via touch. En dat lukte. De rest was makkelijk te doen. Vooral met de cron schedule editor.  

### Resultaat
#### deel 1  








#### deel 2
