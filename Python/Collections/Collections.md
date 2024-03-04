---
tags:
  - Python
  - "#SoftwareEngineering"
---
# Types of Collections

[Python Collections Documentation](https://docs.python.org/3/tutorial/datastructures.html)
## [[Lists]]

[W3 Lists Docs](https://www.w3schools.com/python/python_lists.asp)

Lists are created using square brackets

````python
a_list = ["apple", "banana", "cherry"]  
````

List items are ordered, changeable, and allow duplicate values.

Items have a defined order, and that order will not change.

If you add new items to a list, the new items will be placed at the end of the list.

List items are indexed, the first item has index `[0]`, the second item has index `[1]` etc.

## [[Tuples]]

[W3 Tuples Docs](https://www.w3schools.com/python/python_tuples.asp)

Tuples are written with round brackets.

````python
a_tuple = ("apple", "banana", "cherry")  
````

A tuple is a collection which is ordered and **unchangeable**/**immutable**

Tuple items are ordered, unchangeable, and allow duplicate values.

Tuple items are indexed, the first item has index `[0]`, the second item has index `[1]` etc.

## [[Sets]]

[W3 Sets Docs](https://www.w3schools.com/python/python_sets.asp)

A set is a collection which is _unordered_, _unchangeable*_, and _unindexed_.

\*Set _items_ are unchangeable, but you can remove items and add new items.

Duplicates are not allowed

```python
a_set = {"apple", "banana", "cherry"}
```

## [[Dictionaries]]

Dictionaries have an O(1) lookup because they store the data in memory using the hash of the key. The mapping

```python
a_dict = {  
  "brand": "Ford",  
  "model": "Mustang",  
  "year": 1964,  
  "year": 2020  
}
```

Dictionaries are used to store data values in key : value pairs.

A dictionary is a collection which is ordered*, changeable and do not allow duplicates.

*\*As of Python version 3.7, dictionaries are **ordered**. In Python 3.6 and earlier, dictionaries are ***unordered***

