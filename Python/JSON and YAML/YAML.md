---
tags:
  - SoftwareEngineering
  - Python
---
## YAML Load and Parse

Parse YAML into a [[Dictionary]]

```python
import yaml

data = yaml.safe_load(open(path_to_yaml).read())  
  
for key, value in data.items():  
	print(f'{key} : {value}')
```

## Validate YAML

```python
try:  
    data = yaml.safe_load(open(path_to_yaml).read()) 
except Exception as ex:  
    print(f'Invalid YAML, error: {ex}')
```

## YAML to JSON

```python
data = yaml.safe_load(open(path_to_yaml).read()) 

# returns a string in json format
json_data = json.dumps(yaml_data)  

# send output to file
with open(json_path, "w") as json_file:  
	json_file.write(json_data)

# convert json string to dict
json_dict = json.loads(json_string)
```

## Safe Load?

In `yaml.load()` there is a *'bug'* that allows for arbitrary code execution, `.safe_load()` avoids this by treating the YAML file carefully and not running code within in.