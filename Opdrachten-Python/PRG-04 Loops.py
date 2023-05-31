#Er zijn for loops en while loops. 
#Een for loop is een (A for loop is used for iterating over a sequence (that is either a list, a tuple, a dictionary, a set, or a string).
#ofwel een herhaaldelijk uitvoeren van een reeks instructies of bewerkingen van gegevens in een list, tuple etc. 

#Een while loop kan een reeks instructies uitgevoerd worden zolang een voorwaarde waar is. 

#OPDRACHT 1
#Maak een variabel met de waarde 0
x = 0
#Maak een while loop waarbij de waarde van x bij elke volgende stap met 1 stap omhoog gaat totdat het 10 bereikt.
#Totdat x kleiner of gelijk is aan 10:
while x <= 10:
   print(x)
#Zegt dat x elke keer met 1 stap omhoog moet gaan.     
    x +=1   
#Zegt dat x weer van voren af aan moet beginnen.
if x == 10:
    x -= 1


#for loop tot 10, betekend alle getallen van 0 tot en met 9. Dat zijn in totaal 10 getallen. 
for number in range(10):
    print(number)


#Is dit goed?
x = 5
for i in range(50):
    print(x * i)
    

arr = ["Coen", "Casper", "Joshua", "Abdessamad", "Saskia"]
for x in arr:
    print(x)


