#Opdracht 1: print een random getal tussen 0 en 100. Print vijf verschillende random getallen achter elkaar. 
import random

for n in range(5):
    a = (random.randint(0,100))
    print(a)

#Opdracht 2: write a fucntion
"""
def my_function():
    print("Hello, world!")

# write function with that takes a string as argument. 
my_function()
"""
""""
def my_function(name):
    print ("Hello"+name)

my_function(" Everybody!")    
"""
#Opdracht 3: write costum function so that it returns the average of the given parameters.

import math

def avg(number1, number2):
    return(number1 + number2)/ 2

x = 128
y = 255
z = avg(number1=x,number2=y)
print(z)