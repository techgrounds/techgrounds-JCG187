"""
import random 

def play_game():
    print("Enter the upper limit for the range of numbers: ")
    limit = int(input())
    number = random.randint(1, limit)
    print("I'm thinking of a number from 1 to " + str(limit) + "\n")
    count = 1 #new line
    while True:
        guess = int(input("Your guess: "))
        if guess < number:
            print("Too low.")
        elif guess > number:
            print("Too high.")
        elif guess == number:
            print("You guessed it in " + str(count) + " tries.\n")
        count = count+1 #new line

guess = 0
number = 35
score = 0

while guess != number:
    guess = int(input("Can you give me a number between 0 and 100?: "))

    if guess < number:
        print(str(guess) + " That number isn't high enough.")
    elif guess > number:
        print(str(guess) + " That number is too high.")
    else:
        print(str(guess) + " Hurray! You win!!!")

    score += 1  # Increment the score by 1
    if guess != number:
        print("Try again!")

print("You guessed the right answer in " + str(score) + " attempts.")

with open('Python_Course/user_info.csv', 'a', newline='') as file:
    writer = csv.writer(file)
    if file.tell() == 0:  # Check if the file is empty
        writer.writerow(header)  # Write header if the file is empty
    writer.writerow(data)
"""
speler_naam = "Jennifer"
speler_score = 50

bestand = open("test.csv", "a")

bestand.write("\n")
bestand.write(speler_naam)
bestand.write(",")
bestand.write(str(speler_score))

bestand.close()
print()