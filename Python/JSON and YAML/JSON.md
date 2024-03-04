---
tags:
  - "#SoftwareEngineering"
  - Python
---
## Parse JSON

```python
import json  
  
path_to_json = 'example.json'
json = json.loads(open(path_to_json).read())  
  
print(type(json))  
print(json)  
print('\n')  
  
for key in json:  
    print(f'{key} : {json[key]}')
```

## Parse remote JSON

```python
import urllib.request  
import json  
  
with urllib.request.urlopen('https://postcode.azurewebsites.net/postcode?postcode=PL48AA') as url:  
    data = json.load(url)  
    print(data)
```

## Check JSON Validity

```python
try:  
    json = json.loads(open(path_to_json).read())  
  
    print('valid json')  
  
    print(type(json))  
    print(json)  
    print('\n')  
  
    for key in json:  
        print(f'{key} : {json[key]}')  
except Exception as ex:  
    print(f'Invalid Json, error: {ex}')
```

## JSON to YAML

```python
json = json.loads(open(path_to_json).read())  

#returns a string in YAML format
yaml_data = yaml.dump(json)  

# send output to file
with open(yaml_path, "w") as yaml_file:  
	yaml_file.write(yaml_data)

# convert json string to dict
yaml_dict = yaml.safe_load(yaml_data)
```
