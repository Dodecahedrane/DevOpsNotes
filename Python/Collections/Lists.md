## Append

Appends object to end of list

```python
list.append('item')
```

## Extend

Extends adds a collection onto the end of a list

```python
fruits = ['apple', 'banana', 'cherry']  
cars = ['Ford', 'BMW', 'Volvo']  
fruits.extend(cars)
```

``fruits`` becomes

```python
['apple', 'banana', 'cherry', 'Ford', 'BMW', 'Volvo']
```
## Pop

Removes item from end of list

```python
item = a_list.pop()
```

To pop from elsewhere in the list

```python
item = a_list.pop(0)     # this removes from index 0
item = a_list.pop(-1)    # this removes from the last index
```
## Length

Gets length of list

```python
length = len(a_list)
```

## Clear

Empty a list

```python
list.clear()
```
## Get item from index

````python
item = a_list[0]
````
## Modify

```python
a_list[0] = 'this will be at index 0'
a_list[100] = 'this will be at index 100'
```