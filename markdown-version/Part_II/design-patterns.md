# 11 Design Patterns with AI

**Design patterns** are general, reusable solutions to common software design problems. They are not code templates, but rather best practices and conceptual *blueprints* for solving particular challenges in object-oriented software design.

AI tools like large language models (LLMs) can help:

- Recognize which design pattern fits a situation
- Refactor procedural code into patterns
- Compare and contrast patterns
- Implement variants in different languages or paradigms

In this notebook, you'll explore a few common design patterns and see how AI can help you understand and apply them.

Design patterns, as a formalized concept in software engineering, were popularized by the “Gang of Four” (GoF) with the publication of their influential book: “Design Patterns: Elements of Reusable Object-Oriented Software”
Authors: Erich Gamma, Richard Helm, Ralph Johnson, and John Vlissides
Published in 1994


## 11.1 Singleton Pattern


The following code is an implementation fo the Singleton pattern in Python. The Singleton pattern ensures that a class has only one instance and provides a global point of access to it.


```python
class Singleton:
    _instance = None

    def __new__(cls):
        if cls._instance is None:
            cls._instance = super(Singleton, cls).__new__(cls)
        return cls._instance

# Example usage
singleton1 = Singleton()
singleton2 = Singleton()
print(singleton1 is singleton2)  # True
```

### 11.1.1 Task:

Use an AI assistant to explain how the Singleton pattern works, in general and specifically referring to the provided code. 
Then, ask the assistant to refactor the code to use a different approach to implement the Singleton pattern.


## 11.2 Strategy Pattern


The following code is an implementation of the Strategy pattern in Python. The Strategy pattern defines a family of algorithms, encapsulates each one, and makes them interchangeable. This pattern lets the algorithm vary independently from the clients that use it.


```python
class StrategyBase:
    def execute(self, data):
        pass

class AddStrategy(StrategyBase):
    def execute(self, data):
        return data + 10

class MultiplyStrategy(StrategyBase):
    def execute(self, data):
        return data * 10

class Context:
    def __init__(self, strategy):
        self.strategy = strategy

    def run(self, data):
        return self.strategy.execute(data)

# Example
ctx = Context(AddStrategy())
print(ctx.run(5))
ctx.strategy = MultiplyStrategy()
print(ctx.run(5))
```

### 11.2.1 Task:

Use the AI to:
- Explain the code of the Strategy pattern
- Suggest other scenarios where Strategy would be helpful
- Add a new strategy that uses a lambda


## 11.3 Observer Pattern


The following is an implementation of the Observer pattern in Python. The Observer pattern defines a one-to-many dependency between objects so that when one object changes state, all its dependents are notified and updated automatically.


```python
class Subject:
    def __init__(self):
        self._observers = []

    def register(self, observer):
        self._observers.append(observer)

    def notify(self, message):
        for observer in self._observers:
            observer.update(message)

class Observer:
    def update(self, message):
        print(f"Observer received: {message}")

# Example
subject = Subject()
subject.register(Observer())
subject.notify("Hello observers!")
```

### 11.3.1 Task:

Use AI to:
- Explain the Observer pattern referring to the provided code
- Turn the Observer into an event logger
- Add support for unregistering observers


## 11.4 Factory Pattern


The Factory design pattern is a creational pattern that provides an interface for creating objects in a superclass but allows subclasses to alter the type of objects that will be created. It is used when the exact type of the object to be created is determined at runtime.


```python
class Animal:
    def speak(self):
        pass

class Dog(Animal):
    def speak(self):
        return "Woof!"

class Cat(Animal):
    def speak(self):
        return "Meow!"

class AnimalFactory:
    @staticmethod
    def create_animal(animal_type):
        if animal_type == "dog":
            return Dog()
        elif animal_type == "cat":
            return Cat()
        else:
            raise ValueError("Unknown animal type")

# Example
animal = AnimalFactory.create_animal("dog")
print(animal.speak())
```

### 11.4.1 Task:

Use the AI to:

- Add another type of animal
- Replace the if-else with a registry for cleaner extension


## 11.5 AI-Assisted Refactoring Prompt

Refactor the following script using a design pattern to improve modularity and reuse. Suggest the most appropriate pattern and implement it.



```python
class NotificationSender:
    def send(self, message, channel):
        if channel == "email":
            print(f"Sending Email: {message}")
        elif channel == "sms":
            print(f"Sending SMS: {message}")
        elif channel == "push":
            print(f"Sending Push Notification: {message}")
        else:
            raise ValueError("Unknown channel")

# Usage
sender = NotificationSender()
sender.send("Hello World!", "email")
sender.send("Hello again!", "sms")
```

Hint: the strategy pattern is a good candidate for this task:
- Extensibility: Adding a new notification type only requires a new class.
- Maintainability: No need to touch existing logic to add new behaviors.
