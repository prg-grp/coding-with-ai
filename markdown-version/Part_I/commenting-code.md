# 6 Commenting Code with AI

AI can be used to add code comments and improve code comprehension.


## 6.1 Task: Explaining Code with AI

The following program does not include any comment.

- Use the AI to add comments at suitable points in the code.

- Based on the comments, understand the logic of the program.



```R
string = "madam"
normalized_string = string.lower()

if normalized_string == normalized_string[::-1]:
    print(f'"{string}" is a palindrome')
else:
    print(f'"{string}" is not a palindrome')
```

## 6.2 Task: Finding the Right Balance

Too few comments make a program hard to understand, but too many comments clutter the code and are unnecessary. Note that the Python features used in this code may be well beyond your current knowledge.

- With the help of AI, add an increasing number of comments to the following program.

- What is the right level of commenting?



```R
import json
from datetime import datetime

class Task:
    def __init__(self, title, description, due_date):
        self.title = title
        self.description = description
        self.due_date = due_date
        self.completed = False

    def mark_complete(self):
        self.completed = True

    def __repr__(self):
        status = "Completed" if self.completed else "Pending"
        return f"Title: {self.title}\nDescription: {self.description}\nDue Date: {self.due_date}\nStatus: {status}\n"

class TaskManager:
    def __init__(self):
        self.tasks = []

    def add_task(self, title, description, due_date):
        task = Task(title, description, due_date)
        self.tasks.append(task)

    def remove_task(self, title):
        self.tasks = [task for task in self.tasks if task.title != title]

    def mark_task_complete(self, title):
        for task in self.tasks:
            if task.title == title:
                task.mark_complete()

    def display_tasks(self):
        if not self.tasks:
            print("No tasks available.")
        else:
            for task in self.tasks:
                print(task)

    def save_tasks(self, filename):
        with open(filename, 'w') as file:
            json.dump([task.__dict__ for task in self.tasks], file)

    def load_tasks(self, filename):
        try:
            with open(filename, 'r') as file:
                tasks = json.load(file)
                self.tasks = [Task(**task) for task in tasks]
        except FileNotFoundError:
            print(f"No saved tasks found in {filename}.")

def main():
    manager = TaskManager()
    while True:
        print("\nTask Manager")
        print("1. Add Task")
        print("2. Remove Task")
        print("3. Mark Task Complete")
        print("4. Display Tasks")
        print("5. Save Tasks")
        print("6. Load Tasks")
        print("7. Exit")
        choice = input("Choose an option: ")

        if choice == '1':
            title = input("Enter the task title: ")
            description = input("Enter the task description: ")
            due_date = input("Enter the task due date (YYYY-MM-DD): ")
            manager.add_task(title, description, due_date)
        elif choice == '2':
            title = input("Enter the title of the task to remove: ")
            manager.remove_task(title)
        elif choice == '3':
            title = input("Enter the title of the task to mark complete: ")
            manager.mark_task_complete(title)
        elif choice == '4':
            manager.display_tasks()
        elif choice == '5':
            filename = input("Enter the filename to save tasks: ")
            manager.save_tasks(filename)
        elif choice == '6':
            filename = input("Enter the filename to load tasks: ")
            manager.load_tasks(filename)
        elif choice == '7':
            print("Exiting Task Manager.")
            break
        else:
            print("Invalid choice. Please try again.")

if __name__ == "__main__":
    main()
```


```R
# Program with comments

```

## 6.3 Task: Understanding Python Comments with AI

By asking the AI, learn about the different types of comments that exist in Python.

- Ask the AI to explain them to you and to provide examples for each type.

Hint: there are three types of comments in Python:

* Single-line Comments (#): Used for short explanations or notes about specific lines of code.
* Multi-line Comments: Can be created using consecutive single-line comments or triple-quoted strings for larger blocks of text.
* Docstrings (""" or '''): Used for documenting modules, functions, classes, and methods, providing a formal way to describe what the code does.

