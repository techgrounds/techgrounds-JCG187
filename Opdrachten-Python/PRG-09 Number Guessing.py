
guess = 0
number = 35
score = 0
while guess != number:    
    guess = int(input("Can you give me a number between 0 and 100?: "))
    if guess < number:
        print(str(guess)+" That number isn't high enough.") 
    elif guess > number:
        print(str(guess)+" That number is to high.") 
    else:   
        print(str(guess)+ " Hurray! You win!!!")
    
    score += 1
    if guess != number:
        print("Try again!")
    else:    
        print("You guessed the right answer in "+ str(score)+" times.") 
  
    
