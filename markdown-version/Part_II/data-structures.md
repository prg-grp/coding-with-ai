# 9 Data Structures

Understanding and designing data structures is a core skill in programming. Well-designed structures make code more robust, readable, and maintainable—not just for humans, but also for AI systems that rely on structure and documentation to assist you effectively.

In this section, we’ll explore the importance of clarity and immutability in data structure design. To guide your thinking, we'll start with a worked example: the **Immutable Ordered Binary Tree** (`ITree`). Then, you'll get a chance to apply those ideas by designing your own data structure: the **Immutable List** (`IList`).


## 9.1 Data Structure Design

The key is to provide enough information for the AI to understand the problem.
One useful tool at our disposal is **documentation** (e.g. declarative names,
type hints, comments, docstrings...). Note that documentation is not only useful
for AI models, but also for developers who will implement, use, or modify your
code!

Let's design a new data structure, the **Immutable Ordered Binary Tree**
(`ITree`) with the following properties:

- `Immutable`: any modification to a tree generates a new modified tree without
  changing the original one;
- `Binary`: every node in the tree has at most two children, the left child and
  the right child;
- `Ordered`: the left child is always less than its parent; the right child is
  always greater or equal to its parent. As a consequence, the minimum of the
  tree is the longest path all to the left, while the maximum is the longest
  path all to the right.

Here is how it looks like:


![IOBTree Example](./images/iobtree.drawio.png)


Our design will be defined in a class whose methods are all not implemented,
like follows.



```python
from typing import Optional

# Manual Design
class ITree:
    """An `ITree` is an Immutable Ordered Binary Tree.
    
    A `binary` tree is a data structure in which each node has at most two
    children. The children are referred to as the `left` child and the `right`
    child. The topmost node in the tree is called the `root`. The root is the 
    only node in the tree that has no parent. Instead, nodes with no children
    are called `leaves`.
     
    In an `ordered` binary tree, the left child is always less than the parent,
    and the right child always greater or equal to the parent.

    An `immutable` tree is a tree that cannot be modified after it is created.
    Instead, methods that modify the tree return a new tree.
    """

    def __init__(self, value, left=None, right=None) -> "ITree":
        """Create a new tree with the given value and children."""
        pass

    def __str__(self) -> str:
        """Return a string representation of the tree. The string is `pretty`,
        meaning that it is intended to be human-readable. As such, it should
        include newlines, indentation, and branches that represents the tree 
        structure. Left children are marked with `L`, right children with `R`."""
        pass

    def size(self) -> int:
        """Return the number of elements in the tree."""
        pass

    def height(self) -> int:
        """Return the height of the tree."""
        pass

    def root(self):
        """Return the value of the root in this tree."""
        pass

    def leaves(self) -> list["ITree"]:
        """Return the leaves in the tree."""
        pass

    def search(self, value) -> Optional["ITree"]:
        """Return the tree containing the value, or None if not found."""
        pass
        
    def add(self, value) -> "ITree":
        """Return a new tree with the value added."""
        pass

    def remove(self, value) -> Optional["ITree"]:
        """Return a new tree with the value removed, or None if the new tree is
        empty."""
        pass
```

Now, let's ask the AI to provide an implementation for our design. Here is the
prompt:

*"Create a new class ITreeImpl that implements ITree"*



```python
# AI-Generated Implementation
class ITreeImpl(ITree):
    def __init__(self, value, left=None, right=None):
        self.value = value
        self.left = left
        self.right = right

    def __str__(self):
        def _str(tree, indent=""):
            if tree is None:
                return ""
            result = f"{indent}{tree.value}\n"
            if tree.left or tree.right:
                if tree.left:
                    result += _str(tree.left, indent + "L-")
                else:
                    result += f"{indent}L-None\n"
                if tree.right:
                    result += _str(tree.right, indent + "R-")
                else:
                    result += f"{indent}R-None\n"
            return result

        return _str(self)

    def size(self):
        if self is None:
            return 0
        left_size = self.left.size() if self.left else 0
        right_size = self.right.size() if self.right else 0
        return 1 + left_size + right_size

    def height(self):
        if self is None:
            return 0
        left_height = self.left.height() if self.left else 0
        right_height = self.right.height() if self.right else 0
        return 1 + max(left_height, right_height)

    def root(self):
        return self.value

    def leaves(self):
        if self.left is None and self.right is None:
            return [self]
        leaves = []
        if self.left:
            leaves.extend(self.left.leaves())
        if self.right:
            leaves.extend(self.right.leaves())
        return leaves

    def search(self, value):
        if self.value == value:
            return self
        elif value < self.value and self.left:
            return self.left.search(value)
        elif value >= self.value and self.right:
            return self.right.search(value)
        return None

    def add(self, value):
        if value < self.value:
            if self.left:
                new_left = self.left.add(value)
            else:
                new_left = ITreeImpl(value)
            return ITreeImpl(self.value, new_left, self.right)
        else:
            if self.right:
                new_right = self.right.add(value)
            else:
                new_right = ITreeImpl(value)
            return ITreeImpl(self.value, self.left, new_right)

    def remove(self, value):
        if value < self.value:
            if self.left:
                new_left = self.left.remove(value)
                return ITreeImpl(self.value, new_left, self.right)
            return self
        elif value > self.value:
            if self.right:
                new_right = self.right.remove(value)
                return ITreeImpl(self.value, self.left, new_right)
            return self
        else:
            if self.left is None and self.right is None:
                return None
            if self.left is None:
                return self.right
            if self.right is None:
                return self.left
            min_larger_node = self.right
            while min_larger_node.left:
                min_larger_node = min_larger_node.left
            return ITreeImpl(min_larger_node.value, self.left, self.right.remove(min_larger_node.value))
```

Note how a lot of the times the documentation you should write for your code is
enough for the AI to generate the implementation.

Now, let's not trust the implementation and play a bit with it.



```python
# Here is the same tree as in the figure above
tree = ITreeImpl(4).add(2).add(3).add(8).add(7).add(9) 

print("Size:", tree.size())
print("Height:", tree.height())
print("Root:", tree.root())
print("Leaves:", [leaf.value for leaf in tree.leaves()])
print("Tree:")
print(tree)
print("Add 0:")
print(tree.add(0))
print("Remove 2:")
print(tree.remove(2))
print("Search 8:")
print(tree.search(8))
```

## 9.2 From Design to Implementation


Now, it's your turn!

Try designing an **Immutable List** (`IList`). Here is the specification:

1. An `IList` is an element followed by another (possibly empty) `IList`. In
   detail, it has two fields:
   - `head`: the first element of the `IList`
   - `tail`: the following `IList`. The tail can be `None`, meaning that it is
     an empty list.
2. An `IList` has the following methods:
   - `__init__`: creates a new `IList` from its head and tail
   - `__str__`: produces a pretty representation for an `IList`
   - `size`: return the number of elements in the `IList`
   - `push`: adds an element at the beginning of the `IList`
   - `pop`: returns a new `IList` with the first element removed, or `None` if
     the new `IList` is empty
   - `index_of`: returns the position of the first occurence of an element in
     the `IList`, or `None` if the `IList` does not contain the element

Here is how it looks like:


![IList Example](./images/ilist.drawio.png)


Write your design below. Remember that the `IList` is **immutable** just like the
`ITree`.



```python
from typing import Optional

class IList: 
    pass # Replace with your design...
```

Ask the AI to provide an implementation of your design in a new class
`IListImpl`.



```python
# AI-Generated Implementation
```

Play with the implementation and check if it works.



```python
# Here is the same list as in the figure before
ilist = IListImpl(1, IListImpl(2, IListImpl(3, IListImpl(4))))
print("List:", ilist)
print("Size:", ilist.size())
print("Push 10:", ilist.push(10))
print("Pop:", ilist.pop())
print("Index of 3:", ilist.index_of(3))
```
