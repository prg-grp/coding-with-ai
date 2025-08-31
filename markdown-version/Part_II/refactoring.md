# 14 Refactoring

Refactoring is about performing a code transformation that improves software design without changing its behavior([Code Refactoring](https://en.wikipedia.org/wiki/Code_refactoring)). Classic examples of refactoring include renaming variables and functions, breaking down a long method into multiple ones, and synthetizing setters and getters for a class field.

Refactoring can be done manually or automatically (many IDEs provide support for automated refactoring, e.g., [here](https://en.wikipedia.org/wiki/Code_refactoring)). Automatic methods are analytical, correct by design, and based on static analysis. Yet AI can support refactoring -- even if with less correctness guarantees.


## 14.1 Task: Variable Renaming

Refactor the following code to rename the variable ''numbers''



```python
# Initialize a list of numbers
numbers = [1, 2, 3, 4, 5]

# Outer loop: iterates 5 times
for i in range(5):
    print(f"Iteration {i+1} of the outer loop:")
    
    # Inner loop: iterates over the list 'numbers'
    for number in numbers:
        print(f"Number from the list: {number}")

    print("-" * 20)

```


    Error in parse(text = input): <text>:2:11: Unerwartete(s) '['
    1: # Initialize a list of numbers
    2: numbers = [
                 ^
    Traceback:



## 14.2 Variable Renaming

Create a Python program where the scoping of a variable is complex enough that the correct refactoring (renaming) with AI fails.



```python
# Program goes here
```

## 14.3 Semantic Refactoring: Procedural to Object-Oriented

There are refactorings that an LLM Can Do but an IDE Typically cannot. A good example are semantic or high-level intent-based refactoring, even without a rigid project structure.

**Warning:** The correctness of the refactoring is not guaranteed. The LLM may produce code that does not compile or that does not work as intended. Always test the refactored code before using it in production.

Refactor the following procedural script into an object-oriented design based on natural language goals, such as: "Transform this data analysis script into a reusable Python class with methods for loading, cleaning, analyzing, and exporting data."



```python
import pandas as pd
import matplotlib.pyplot as plt

# Load the data
df = pd.read_csv("data/sales_data.csv")

# Clean the data
df = df.dropna()
df["date"] = pd.to_datetime(df["date"])

# Compute total sales per month
df["month"] = df["date"].dt.to_period("M")
monthly_sales = df.groupby("month")["sales"].sum()

# Plot the results
plt.figure(figsize=(10, 5))
monthly_sales.plot(kind="bar")
plt.title("Total Monthly Sales")
plt.xlabel("Month")
plt.ylabel("Sales")
plt.tight_layout()
plt.savefig("monthly_sales.png")
plt.show()
```

This script performs the following tasks:

- Loads a CSV file.
- Cleans the data.
- Computes summary statistics.
- Plots the results.

However, the script is entirely procedural: it lacks functions, classes, and separation of concerns.



```python
# The refactored program goes here
```

## 14.4 Semantic Refactoring: Dependency Injection

Dependency Injection is a design pattern that allows a class to receive its dependencies from an external source rather than creating them internally. This promotes loose coupling and makes the code more testable and maintainable. You can read more about dependency injection in Python in the [Python documentation](https://docs.python.org/3/glossary.html#term-dependency-injection).

We’ll refactor the SalesAnalyzer class to:

- Inject dependencies like the data loader and plotting function.
- Allow for flexible testing, extension, or customization — e.g., switching between CSV, database, or mocked data.

This is beyond what IDEs do, and it’s something an LLM can generate from a natural-language prompt like:

“Refactor this class to use dependency injection for the data loading and plotting steps.”



```python
# Refactored code with dependency injection goes here
```
