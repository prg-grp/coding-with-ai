# 4 Writing Algorithms with AI

An algorithm is a finite sequence of well-defined instructions used to solve a problem. See, for example https://en.wikipedia.org/wiki/Algorithm.
AI can be used to generate the programs that implement a certain algorithm.


## 4.1 Task: Giving Granular Steps

To get the help of the AI, you can specify the steps that the algorithm should follow. For example:

Using AI, implement an algorithm that:

- Receives as input a list of numbers
- Computes the sum of the numbers
- Computes the size of the list
- Divides the sum of the numbers by the size of the list
- Prints the result



```R
# The algorithm goes here
```

## 4.2 Task: Giving High-Level Specifications

Instead of specifying the individual steps, one can provide the AI with a higher level specification of the algorithm.

For example, 'Generate a program that computes the average of a list of numbers and prints the result'.

- Try to generate the algorithm above using AI.

- Compare this approach with the step-by-step approach. Note that the resulting program might not be broken down into steps and may be harder to understand.



```R
# The algorithm goes here
```

## 4.3 Task: Linear Regression

Generate an algorithm to compute a linear regression (https://en.wikipedia.org/wiki/Linear_regression). You can also ask the AI to explain what linear regression is if you are not familiar with it or need a refresher.

- First, generate a step-by-step algorithm.
- Next, generate the whole algorithm from a high-level specification.

Hint: ask the AI for the exact steps that are required in the algorithm (in natural language), then use those steps to obtain a step-by-step formulation of the algorithm in Python.



```R
# Linear regression step-by-step
```


```R
# Linear regression from a high-level specification
```

## 4.4 Task: Banking System

Consider a program that implements the following specification:

Create a simple text-based banking system. The system allows users to create an account, deposit money, withdraw money, and check their balance. It uses basic programming constructs such as variables, loops, conditionals, and input/output operations.

Requirements:

1. Account Creation:

* Users can create an account by entering their name and an initial deposit amount.
* The system should store the account balance and the account holder’s name.

2. Deposit Money:

* Users can deposit money into their account.
* The account balance should be updated accordingly.

3. Withdraw Money:

* Users can withdraw money from their account.
* The system should check if there is enough balance for the withdrawal. If not, an appropriate message should be displayed.

4. Check Balance:

* Users can check their current account balance.

5. Exit:

* Users can exit the program.

6. Menu-Driven Interface:

* The program should display a menu with options to create an account, deposit money, withdraw money, check balance, and exit.
* The user should be able to select an option to perform an action.

A possible implementation for this specification follows. You can spot that the program has a regular structure: Each number input provided by the user corresponds to a different functionality.

- Try to generate the program incrementally, providing the AI one or more points in the specification and then asking the AI to add the order gradually. In between, make sure that you understand the (partial) implementation suggested by the AI.

- Propose a new functionality in the specification and implement it on top of the existing ones using the AI.



```R
# Initialize variables
account_created = False
account_holder_name = ""
balance = 0.0

# Main program loop
while True:
    # Display menu
    print("\nSimple Banking System")
    print("1. Create an Account")
    print("2. Deposit Money")
    print("3. Withdraw Money")
    print("4. Check Balance")
    print("5. Exit")
    choice = input("Choose an option: ")

    if choice == '1':
        if account_created:
            print("Account already exists.")
        else:
            account_holder_name = input("Enter your name: ")
            initial_deposit = input("Enter the initial deposit amount: ")

            # Input validation: Ensure the initial deposit is a valid number
            if initial_deposit.replace('.', '', 1).isdigit() and float(initial_deposit) >= 0:
                balance = float(initial_deposit)
                account_created = True
                print(f"Account created successfully for {account_holder_name} with balance ${balance:.2f}")
            else:
                print("Invalid deposit amount. Please enter a positive number.")

    elif choice == '2':
        if not account_created:
            print("No account found. Please create an account first.")
        else:
            deposit_amount = input("Enter the amount to deposit: ")

            # Input validation: Ensure the deposit amount is a valid number
            if deposit_amount.replace('.', '', 1).isdigit() and float(deposit_amount) > 0:
                balance += float(deposit_amount)
                print(f"${float(deposit_amount):.2f} deposited successfully. New balance: ${balance:.2f}")
            else:
                print("Invalid deposit amount. Please enter a positive number.")

    elif choice == '3':
        if not account_created:
            print("No account found. Please create an account first.")
        else:
            withdrawal_amount = input("Enter the amount to withdraw: ")

            # Input validation: Ensure the withdrawal amount is a valid number
            if withdrawal_amount.replace('.', '', 1).isdigit() and float(withdrawal_amount) > 0:
                withdrawal_amount = float(withdrawal_amount)
                if withdrawal_amount > balance:
                    print("Insufficient funds. Withdrawal failed.")
                else:
                    balance -= withdrawal_amount
                    print(f"${withdrawal_amount:.2f} withdrawn successfully. New balance: ${balance:.2f}")
            else:
                print("Invalid withdrawal amount. Please enter a positive number.")

    elif choice == '4':
        if not account_created:
            print("No account found. Please create an account first.")
        else:
            print(f"Account holder: {account_holder_name}")
            print(f"Current balance: ${balance:.2f}")

    elif choice == '5':
        print("Exiting the banking system. Goodbye!")
        break

    else:
        print("Invalid choice. Please choose a valid option.")
```
