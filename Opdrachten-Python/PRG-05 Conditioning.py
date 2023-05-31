#Hier wordt om input van je naam gevraagt. 
name = input("What is your name?: ")
#Als de naam gelijk is aan Jennifer dan wordt de tekst Hello! Welcom Jennifer! getoont
if name == "Jennifer":
    print("Hello! Welcome Jennifer!")
#Als er geen Jennifer wordt ingevoerd, dan krijg je de tekst You are "name", not Jennifer....    
else: 
    print("You are "+name+", not Jennifer. Please leave.")

#Zolang de waarde 100 niet ingevoerd wordt zal de loop doorgaan.
while True:
#Vraag om een getal. Dmv de int wordt het ingevoerde getal van een string naar integer veranderd.     
    number = int(input("Can you give me a number?: "))
#Als het ingevoerde getal kleiner is dan 100 moet de zin "That number is very low" getoont worden. Door de while true zal de vraag
#voor een nieuw getal weer getoont worden. 
    if number < 100:
        print(str(number)+" That number is very low") 
#Als het ingevoerde getal groter is dan 100 zal de tekst "That is a high number" getoont worden. Omdat het getal 100 niet ingevoerd is,
#zal de vraag voor een getal opnieuw getoont worden.         
    elif number > 100:
        print(str(number)+" That is a high number") 
#Als het juiste getal ingevoerd wordt wat 100 is, dan krijg je de tekst "That is a nice number indeed". Omdat het juiste getal 
# ingevoerd is, zal de vraag om een getal niet meer getoont worden.         
    else:
        print(str(number)+ " That is a nice number indeed")
#De break zorgt ervoor dat de vraag om een getal niet meer getoont wordt.         
   




  
     
  
