# 13 Mutation Testing

Mutation testing is a technique to evaluate the quality of your test suite. It works by making small changes (mutations) to your code — called *mutants* — and then running your tests. If the tests fail, the mutant is said to be *killed*; if the tests pass, the mutant *survived*, indicating a potential weakness in the test suite.

It is crucial to understand that mutation testing is a technique to improve the quality *of the test suite*.

Mutation testing can help uncover:

- Untested branches of logic
- Missing edge cases
- Overly specific or weak assertions

We will apply mutation testing to the same function we used in unit testing:



```python
def transform_number(number):
    """
    Transforms the number by squaring it if even, or tripling it if odd.
    Returns the transformed number.
    """
    if number % 2 == 0:
        return number ** 2  # Square even numbers
    else:
        return number * 3   # Triple odd numbers
```

### 13.0.1 Define Tests Using `pytest`



```python
import pytest

def test_transform_even():
    assert transform_number(2) == 4
    assert transform_number(0) == 0
    assert transform_number(-4) == 16

def test_transform_odd():
    assert transform_number(1) == 3
    assert transform_number(5) == 15
    assert transform_number(-3) == -9
```

### 13.0.2 Mutation Testing Tools

Mutation testing tools like [`mutmut`](https://github.com/boxed/mutmut) or [`cosmic-ray`](https://github.com/sixty-north/cosmic-ray) can automate the mutation process.


### 13.0.3 Option A: Using mutmut (if allowed in your environment)

```bash
pip install mutmut
mutmut run
mutmut results
```


### 13.0.4 Option B: Manual Mutation (if external tools are not allowed)

Manually change the function to simulate a mutation and re-run your tests. For example:



```python
# Mutation: change `** 2` to `* 2`
def transform_number(number):
    if number % 2 == 0:
        return number * 2   # Mutant logic here
    else:
        return number * 3
```

## 13.1 AI-Assisted Mutation Test improvement

Based on the mutation of the function transform_number above, improve the test suite to make sure that it captures the mutation.

In this case the AI can recommend new tests to kill surviving mutants.



```python
# The improved test suite goes here
```

## 13.2 AI-Assisted Mutation

Another use of the AI is to suggest likely mutations based on your code.
Ask the AI to suggest mutations for the function `transform_number` and then run the tests to see if they are killed or survived.



```python
# New mutants of the `transform_number` function goes here
```
