#Variabelen kunnen in verschillende soorten data types worden opgeslagen. Hoe je ze opslaat is belangrijk voor opvolgende verwerkingen.
#De volgende types zijn voorbeelden: 
#Een stuk tekst is een string of str.
#Een getal heeft verschillende types. Er is: 
#Een heel getal en dat is een int(eger) (20).
#Een getal met een decimaal is een float (20.5).
#Een getal met een j, waarbij de j altijd gebruikt wordt als "imaginair" getal. Het type is, een complex (20j)?
#Een list zijn opsommingen van woorden of getallen. Deze opsommingen staan tussen [] en kunnen veranderd worden.
#Een tuple zijn opsommingen van woorden of getallen. Deze opsommingen staan tussen (). Deze opsommingen kunnen niet veranderd worden.
"""
#OPDRACHT 1.1
#Zoek uit wat de datatype is van onderstaande gegevens in a t/m d. 
a = 'int'
b = 7
c = False
d = "18.5"
#Door type toe te voegen, krijg je als antwoord wat voor datatype de waarde a,b,c of d is. 
print(type(a))
print(type(b))
print(type(c))
print(type(d))

#OPDRACHT 1.2
#Hier is een nieuwe variabel toegevoegd, namelijk x. Deze telt de waarde van b en d bij elkaar op. Omdat "18.5" een type string is,
#(door de aanhalingstekens, kan de optelsom niet gemaakt worden. Om dat te doen moet je ervoor zorgen 
#dat "18.5" door het programma gelezen wordt als een float. Een float kan wel met een integer opgeteld worden. Niet met een string. 
a = 'int'
b = 7
c = False
d = float("18.5")
x = b+d
print(x)

#OPDRACHT 2
#Vraag input van een gebruiker, en sla die input op in een variabel.Print het type van de waarde in de variabel die ingegeven is. 
name = input("What is your name?: ")
age = input("What is your age?: ")
print(type(name))
print(type(age))

"""
