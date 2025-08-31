# 5 Explaining Code with AI

AI can be used to explain a program helping beginners understand basic program functionalities and speeding up advanced programmers in code comprehension during maintenance tasks (https://en.wikipedia.org/wiki/Software_maintenance#Change_cycle).


## 5.1 Task: Code Explanations

Consider the exercises 1-5 here:
https://sback.github.io/shsg-summerschool-2024/day-1/variables

- Compare the solution that you provide with the one provided by the AI.

- How does the prompt influence the size and the complexity of the explanation? For example, you can ask an explanation for an absolute beginner or you can ask an explanation for an experienced software engineer.


## 5.2 Task: Improving Code Quality

The following code snippet is an example of bad programming practice. The variables used in the code do not have meaningful names and there are no comments.

- Use AI to understand what this code is doing.

- Next, based on the explanation above, use AI to give the variables a more meaningful name and add comments that help other programmers understand the code.



```R
x = 29

y = True

if x > 1:
    for z in range(2, int(x ** 0.5) + 1):
        if x % z == 0:
            y = False
else:
    y = False

if y:
    print(f"{x}: it is!")
else:
    print(f"{x}: no, it isn\'t")
```





```R
# Cleaned up version of the code here
```

## 5.3 Task: Deciphering Code with AI

Use the AI to understand the following code. This program uses boolean values in an arithmetic operation, which might be confusing because booleans are typically not used in this way.
Warning: this is not a good programming style!



```R
x = True
y = False
z = x - y

print(z)
```

## 5.4 Task: Refactoring Code with AI

This program uses chained assignment and chained comparison, both of which can be tricky to grasp at first. Warning: this is not a good programming style!

- Use the AI to understand the following code.

- Working with the AI, translate it to a version that is immediately comprehensible.



```R
a = b = c = 5

if a == b == c:
    print("All variables are equal.")

a = 6

if a < b < c:
    print("a is less than b and b is less than c.")
else:
    print("The chain of comparisons is not true.")
```
