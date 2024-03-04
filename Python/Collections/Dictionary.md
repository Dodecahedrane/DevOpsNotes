## Update

Updates the dictionary with the key-value pairs from another dictionary or from an iterable of key-value pairs.

```python
dict1 = {'a': 1, 'b': 2}
dict2 = {'b': 3, 'c': 4}
dict1.update(dict2)
```

`dict1` becomes

```python
{'a': 1, 'b': 3, 'c': 4}
```

## Accessing a Value

Retrieve the value associated with a given key.

```python
value = my_dict['key']
```

## Adding or Modifying a Key-Value Pair

```python
my_dict['new_key'] = 'new_value'
```

If the key already exists, its value will be updated; otherwise, a new key-value pair will be added.

## Removing a Key-Value Pair

```python
del my_dict['key']
```

## Pop

Remove the specified key and return the corresponding value. If the key is not found, the default value is returned if given, otherwise a `KeyError` is raised.

```python
value = my_dict.pop('key')
```

## Get

Retrieve the value associated with a given key, with an optional default value if the key is not found.

```python
value = my_dict.get('key', default_value)
```

## Keys

Retrieve a list of all keys in the dictionary.

```python
keys = my_dict.keys()
```

## Values

Retrieve a list of all values in the dictionary.

```python
values = my_dict.values()
```

## Items

Retrieve a list of key-value pairs as tuples.

```python
items = my_dict.items()
```
