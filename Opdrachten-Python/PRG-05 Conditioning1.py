name = input("What is your name?: ")
if name == "Jennifer":
    print("Hello! Welcome Jennifer!")
else: 
    print("You are "+name+", not Jennifer. Please leave.")   


while True:    
    number = int(input("Can you give me a number?: "))
    if number < 100:
        print(str(number)+" That number is very low") 
    elif number > 100:
        print(str(number)+" That is a high number") 
    else:
        print(str(number)+ " That is a nice number indeed")
        break