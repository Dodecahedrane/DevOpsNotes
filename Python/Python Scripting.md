---
tags:
  - DevOps
  - SoftwareEngineering
  - Python
  - Scripts
---
## Argv

```python
import sys

# argv[0] is the name of the python script

if len(sys.argv) > 1:  
    print(sys.argv[1])    # first argument
    print(sys.argv[2])    # second argument
    print(sys.argv[3])    # third argument
```

```bash
python3 script.py arg1 arg2 arg3
```

## Subprocess

```python
import subsprocess
# shell command, seperate args in list
subprocess.run(['python3', 'hello_world.py'])
subprocess.run(['sh', 'script.sh'])
```

## [[JSON]] and [[YAML]]


