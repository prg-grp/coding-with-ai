# 12 Software Testing with AI

Software testing refers to the process of systematically validating a software
artifact against a given specification to ensure its quality. Software testing
is a classic topic in software engineering and many techniques have been
proposed over the years.

Some dimensions to classify testing solutions include the following:

- **Granularity**: it is possible to test single functions, modules, or whole
  systems. Concepts like unit testing, integration testing, system testing,
  end-to-end testing belong to this category.

- **Access**: it is possible to organize tests based on the access to source
  code or only based on the input/output at the boundaries (white box testing,
  black box testing).

- **Testing methodology**: different testing methods correspond to different
  techniques to produce the test input. For example, fuzzing, property-based
  testing, model-based testing.

Writing tests for your code is always a good practice: not only it helps in
finding bugs (misattentions most of the times), but it also helps in preventing
future bugs when the software will be modified (so called **regressions**).
Additionally, they also serves as documentation about how to use your software.

As of now, we mostly had to trust the implementation given by our AI assistant.
In this section, we will verify it by means of **unit tests**.

## 12.1 Unit Tests

**Unit tests** verify "unit"s of software. A unit is not formally defined and it
can be interpreted the same way as a module.

Best practices want unit tests to be:

- **Simple**: easy to implement. Simple tests can be easily understood,
  facilitating the detection of the cause of failure.
- **Isolated**: independent of other unit tests. Dependencies between unit tests
  make it more difficult to detect the cause of failure.
- **Reproducible**: always yielding the same results under the same initial
  conditions (i.e., determinism). Non-determinism may cause a test to succeed
  under breaking changes or to fail even with no changes at all.
- **Finite**: yielding a result in a limited amount of time, ideally short for
  supporting frequent repeatability.
- **Automated**: executed each time a relevant (preferably small) increment of
  software is completed.

Note that unit tests are usually incomplete, because it is often impossible to
verify a functionality for all possible inputs. Therefore, some skill is
required to identify the subset of interesting cases that should be verified.


## 12.2 Task: Getting Started With Testing

Consider the following program. Read the code to convince yourself that it is correct. Next, run the program with some different input/output pairs. In the process, you may want to explore cases that you consider particularly important to check that the program functionalities are the ones advertised by the specification.



```python
def transform_number(number):
    """
    Transforms the number by squaring it if even, or tripling it if odd.
    Returns the transformed number.
    """
    # Check if the number is even or odd
    if number % 2 == 0:
        return number ** 2  # Square even numbers
    else:
        return number * 3   # Triple odd numbers

# Example usage
number = 5
result = transform_number(number)
print(f"Input/output pair: {number}, {result}")
```

Using the AI, do the following tasks:

- Provide the specification of the program. Ask the AI to generate some interesting test cases (i.e., input/output pairs) for the specification.

- Provide the AI with the actual program. Ask the AI to generate the tests for the program based on the pairs identified above.



```python

```

## 12.3 Task: Testing With PyTest

[PyTest](https://docs.pytest.org/en/stable/) is the de-facto standard for
defining unit tests in Python. By default, PyTest considers all functions
starting with "test" as test cases, executes them, and reports the results to
the user.

You can install it by decommenting and running the following cell:

- Run the tests and check that the output of pytest confirms that the tests are correct.

- Modify one of the tests in a way that it is expected to fail, and check the corresponding output.

- Use the AI to generate additional tests using pytest.



```python
# !pip install ipytest
```

Try running the following test to check your installation:



```python
import ipytest
ipytest.autoconfig()

def add(a, b):
    """Returns the sum of two numbers."""
    return a + b

# This test succeeds
def test_add():
    # Test that adding 2 and 3 returns 5
    assert add(2, 3) == 5

    # Test that adding -1 and 1 returns 0
    assert add(-1, 1) == 0

    # Test that adding 0 and 0 returns 0
    assert add(0, 0) == 0

# This test fails
def test_should_fail():
    assert add(2, 3) == 6

ipytest.run()
```


```python
def sumAll(xs: list[int]) -> int:
    """Return the sum of all elements in the list."""
    if xs == []: return 0
    head, *tail = xs
    return head + sumAll(tail)
```


```python
# Write your tests here
```

## 12.4 Task: Test Generation With AI

The following program receives a string as an input and it returns a string created by reversing the words and capitalizing the first letter of each word.

- Use the AI to generate a set or relevant input/output test pairs for the function and explain why they are significant.

- Use the AI to generate the code that executes the test cases for the function.



```python

def manipulate_string(input_string):
    """
    Manipulates the input string by reversing the words
    and capitalizing the first letter of each word.
    """
    # Split the string into words
    words = input_string.split()

    # Reverse the order of words
    reversed_words = words[::-1]

    # Capitalize the first letter of each word
    capitalized_words = [word.capitalize() for word in reversed_words]

    # Join the words back into a single string
    output_string = ' '.join(capitalized_words)

    return output_string

# Example usage
input_string = "hello world from python"
output_string = manipulate_string(input_string)
print(f"Input string: {input_string}")
print(f"Manipulated string: {output_string}")

```


```python
# Write your tests here
```

## 12.5 Task: Designing Unit Tests

Let's start by designing some tests for the `ITree` implementation from Task 11.1:

1. *Identify the unit that you want to test*.

   In this case, we can consider each method as a separate unit.

2. *Identify the interesting cases that should be verified*.

   Here, we can consider the cases involving a singleton tree (containing only
   one element) and a general tree (note that you cannot construct the empty
   `ITree`, but it would be an interesting case for testing). Among interesting
   cases, we should also consider interactions between different methods, but
   these are usually covered inside **integration tests**.

Now that we have a plan, let's ask the AI assistant to generate some unit tests
for its implementation of `ITree`.

Here is the prompt:

*Create unit tests with `ipytest` for the class `ITreeImpl`. The tests should verify all methods in the class on two types of tree, a singleton tree and on a general tree. Separate tests by method and type of tree.*



```python
# AI-Generated Tests
import ipytest
ipytest.autoconfig()

# Singleton tree
singleton_tree = ITreeImpl(1)

def test_singleton_size():
    assert singleton_tree.size() == 1

def test_singleton_height():
    assert singleton_tree.height() == 1

def test_singleton_root():
    assert singleton_tree.root() == 1

def test_singleton_leaves():
    assert [leaf.value for leaf in singleton_tree.leaves()] == [1]

def test_singleton_search():
    assert singleton_tree.search(1) == singleton_tree
    assert singleton_tree.search(2) is None

def test_singleton_add():
    new_tree = singleton_tree.add(2)
    assert new_tree.size() == 2
    assert new_tree.search(2) is not None

def test_singleton_remove():
    new_tree = singleton_tree.remove(1)
    assert new_tree is None

# General tree
general_tree = ITreeImpl(4).add(2).add(3).add(8).add(7).add(9)

def test_general_size():
    assert general_tree.size() == 6

def test_general_height():
    assert general_tree.height() == 3

def test_general_root():
    assert general_tree.root() == 4

def test_general_leaves():
    assert [leaf.value for leaf in general_tree.leaves()] == [3, 7, 9]

def test_general_search():
    assert general_tree.search(8).value == 8
    assert general_tree.search(10) is None

def test_general_add():
    new_tree = general_tree.add(1)
    assert new_tree.size() == 7
    assert new_tree.search(1) is not None

def test_general_remove():
    new_tree = general_tree.remove(8)
    assert new_tree.size() == 5
    assert new_tree.search(8) is None

ipytest.run()
```

After looking at the tests, we can be more confident that the implementation
provided by the AI is correct.


## 12.6 Task: Test Design

Try to design some unit tests for your `IListImpl` from Task 11.2.

1. How do you define your software unit?
2. Which are interesting cases to verify?



```python
# Software Unit:
# ...

# Interesting Cases:
# ...
```

Ask the AI assistant the same questions and compare with your design.



```python
# Software Unit:
# ...

# Interesting Cases:
# ...
```

## 12.7 Task: From Implementation to Testing

Now that you have a plan for testing, ask the AI assistant to generate unit
tests for you.



```python
# AI-Generated Tests
```

## 12.8 Task: Testing of Complex Specifications

The following program manipulates an input string according to the following specification:

1. Remove Punctuation: All punctuation characters will be removed from the string.

2. Convert to Lowercase: The string will be converted to lowercase.

3. Reverse Words of Even Length: Any word in the string that has an even number of characters will be reversed.

4. Capitalize Words Starting with Vowels: Any word that starts with a vowel will be capitalized.

5. Sort Words Alphabetically by Length: The final string will contain words sorted by their length in ascending order.



```python
import string

def complex_string_manipulation(input_string):
    """
    Manipulates the input string by:
    1. Removing punctuation.
    2. Converting to lowercase.
    3. Reversing words of even length.
    4. Capitalizing words starting with a vowel.
    5. Sorting words alphabetically by length.
    """
    # Step 1: Remove punctuation
    input_string = input_string.translate(str.maketrans('', '', string.punctuation))

    # Step 2: Convert to lowercase
    input_string = input_string.lower()

    # Step 3: Split into words
    words = input_string.split()

    # Step 4: Reverse words of even length and capitalize words starting with a vowel
    vowels = 'aeiou'
    modified_words = []
    for word in words:
        if len(word) % 2 == 0:
            word = word[::-1]  # Reverse if length is even
        if word[0] in vowels:
            word = word.capitalize()  # Capitalize if starts with a vowel
        modified_words.append(word)

    # Step 5: Sort words by their length
    modified_words.sort(key=len)

    # Step 6: Join the words back into a single string
    output_string = ' '.join(modified_words)

    return output_string
```

- Manually invoke the program with different input values to ensure that some basic cases are properly covered.

- Think about a test plan (i.e., a set of input/output values) that would give you confidence that the program is correctly implemented.

- Ask the AI to generate a test plan and explain why the generated cases are relevant. Compare this result with the the plan you genereted manually.

- Ask the AI to generate the code for a test suite using pytest.



```python
# AI-Generated Tests
```
