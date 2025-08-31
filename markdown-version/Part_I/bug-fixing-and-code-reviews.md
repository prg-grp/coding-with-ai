# 7 Bug Fixing - Semantic Errors

Finding bugs and potential issues (e.g., security vulnerabilities) in a program is important in several stages of software development.

During development, programmers may need to remove the bugs that they spot in their code. This activity is often called debugging.


## 7.1 Task: Finding Hidden Bugs

AI can help identify a bug in program code. Note that the code does not generate an error when executed and the result is correct. If you want to see an execution with a wrong result, change this line:

`numbers = [3, 5, 2, 8, 1]`

to, e.g., this line:

`numbers = [10, 5, 2, 8, 1]`

- Use AI to find the issue in this code without running it.

- Using the AI, generate a correct version of the program.

- Ask the AI to explain the bug.



```R
def find_max_in_list(numbers):
    # Initialize the maximum value with the first element
    max_value = numbers[0]

    # Iterate through the list to find the maximum value
    for i in range(1, len(numbers)):  # Bug: This loop should run from index 0, not 1
        if numbers[i] > max_value:
            max_value = numbers[i]

    return max_value

# Example usage
numbers = [3, 5, 2, 8, 1]
max_number = find_max_in_list(numbers)
print(f"The maximum number is: {max_number}")
```

    The maximum number is: 8



```R
# COMPLETE: Correct version of the code
```

Explanation of the bug:


## 7.2 Task: Debugging with AI

The following program contains a bug and fails with an error.

- Provide only the error message to the AI and find the bug using the explanation given by the AI

- Provide the AI with both the program and the error message and check if the explanation improves



```R
def calculate_average(numbers):
    # Attempt to calculate the average of a list of numbers
    total = sum(numbers)
    count = len(numbers)

    # Bug: Division by zero error if the list is empty
    average = total / count

    return average

# Example usage
numbers = []
average = calculate_average(numbers)
print(f"The average is: {average}")
```

Error explanation:



```R
# COMPLETE: correct version of the program
```
