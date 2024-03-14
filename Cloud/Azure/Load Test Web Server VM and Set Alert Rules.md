---
tags:
  - Azure
  - LoadTest
  - WebServer
  - DevOps
---
## Install Apache Load Bench

```bash
sudo apt-get install apache2-utils -y
```

## Benchmark

-n Number of Requests
-c 100 Concurrent Requests 

```bash
ab -n 1000 -c 100 http://<app VM's IP address>/

ab -n 1000 -c 100 http://172.166.171.150/
```

## Set Up Alerts

![[Pasted image 20240314142152.png]]

You can set up alerts to email if a particular metric is exceeded.

Alerts cost money, so use them only when needed (and getting them regularly also defeats their purpose. )

You'll get an email looking like

![[Pasted image 20240314145405.png]]