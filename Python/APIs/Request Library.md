You can use the request library to make get only requests from an [[API]]. The `.text()` method on the response will be the [[JSON]] body.

```python
import requests  
  
resp = requests.get('https://postcode.azurewebsites.net/postcode?postcode=PL48AA')  
  
print(resp.text)
```