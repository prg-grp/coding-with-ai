# 3 Fixing Syntax Errors with AI

To properly execute, computer programs should be syntactically correct. This means that they need to follow the conventions of the language. If you are curious, the full specification of the Python syntax is vailable here https://docs.python.org/3/reference/grammar.html

For example, in Python, the assignment of a variable should be done using the equals operator '='.



```R
myVariable = 1
```

An attempt to use a different symbol for an assignment will result in an error.



```R
# The arrow is not a valid symbol for assignment in Python
myVariable <- 1
```

## 3.1 Task: Fixing Syntax Errors

The following Python program contains several syntactic errors. Can you fix them using AI?



```R
# List of numbers
numbers := [10, 20, 30, 40, 50]

# Check if the list is not empty to avoid division by zero
if numbers:
    total_sum = sum(numbers)  # Sum of all numbers in the list
    count = len{numbers}  # Count of numbers in the list
    average = total_sum / count  # Compute the average
else;
    average = 0  # Handle the case of an empty list

print(f"The average of the list is: {average}")
```

## 3.2 Task: Breaking the AI

Consider the following (elementary) program. Before running it:

- Ask the AI to check if it contains any syntactic error.

- Introduce some syntactic errors (note, these are errors about the program keywords, operators, structure, etc, not errors about the correct behavior) and ask the AI to spot them.

- Introduce more errors and check the ability of the AI to find them. How much do you need to change the program before the AI starts failing at detecting errors?



```R
import random

# Welcome message
print("Welcome to the Number Guessing Game!")

# Set the range for the random number
min_number = 1
max_number = 100

# Generate a random number between min_number and max_number
secret_number = random.randint(min_number, max_number)

# Explain the rules to the user
print(f"I am thinking of a number between {min_number} and {max_number}.")
print("Try to guess the number!")

# Initialize the number of attempts
attempts = 0

# Boolean to track if the game is over
game_over = False

# Main game loop
while not game_over:
    # Ask the user for their guess
    guess = int(input("Enter your guess: "))
    attempts += 1  # Increment the attempt counter

    # Check if the guess is too low
    if guess < secret_number:
        print("Too low! Try again.")

    # Check if the guess is too high
    elif guess > secret_number:
        print("Too high! Try again.")

    # Check if the guess is correct
    else:
        print(f"Congratulations! You guessed the number in {attempts} attempts.")
        game_over = True  # End the game

# End of game message
print("Thank you for playing the Number Guessing Game!")
```
