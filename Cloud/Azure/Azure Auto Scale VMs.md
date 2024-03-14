---
tags:
  - Azure
  - DevOps
  - Cloud
  - WebServer
  - AutoScale
---
## Prerequisites

Create a image of the NodeJS VM from [[Deploying Test Application]] 

[Link To Image](https://portal.azure.com/#@spartaglobal.com/resource/subscriptions/cd36dfff-6e85-4164-b64e-b4078a773259/resourcegroups/tech257/providers/Microsoft.Compute/images/tech257-oliver-web-vm-image-20240314143508/overview)

When starting the VM, insert this script as user data

```bash
#!/bin/bash

cd repo/app
export DB_HOST=mongodb://<mongo-db-ip>:27017/posts

# this needs to be run to allow db connection
npm install

pm2 start app.js
```