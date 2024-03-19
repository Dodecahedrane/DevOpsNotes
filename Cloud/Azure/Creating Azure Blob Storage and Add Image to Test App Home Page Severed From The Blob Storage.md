---
tags:
  - Azure
  - BlobStorage
  - Cloud
  - DevOps
  - LoadTest
---


- [x] Create Script To Create Blob Storage
	- [x] Create storage account
	- [x] Enable anonymous access to storage account
	- [x] Create a container in the storage account
	- [x] Download a picture of a cat using curl
	- [x] Upload it to the container
	- [x] Make the blob public
	- [x] Modify home page with blob URL
	- [x] pm2 start
- [x] Create Revert Script To Undo Changes
	- [x] Revert home page
	- [x] pm2 restart
	- [x] remove storage account

## Prerequisites

Need the NodeJS VM from [[Deploying Test Application in Azure]], database does not need to work.

Install Azure CLI (on NodeJS VM) and Login

```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
az login
```

## Bash Script - Create

```bash
#!/bin/bash

cd repo/app

# create stoage account
# name *must* be lower case chars and numbers only. No dashes, no upper case, no spaces. Must be between 3 and 24 chars
az storage account create --name tech257olivercatshop --resource-group tech257 --location uksouth --sku Standard_LRS --allow-blob-public-access true

# sleep, because it can sometimes take a bit for the resource to be created
sleep 30s

# create a container with public access (private by default)
# off = private
# blob = just files
# container = file index
az storage container create --account-name tech257olivercatshop  --name catbox --public-access blob --auth-mode login 

# download cat image
curl -O https://media.wbur.org/wp/2022/08/GettyImages-499713000-1000x653.jpg

# sleep, because it can sometimes take a bit for the resource to be created
sleep 30s

# upload local
# -file is the path to the file locally
# -name is the name of the blob once its uploaded
az storage blob upload  --account-name tech257olivercatshop --container-name catbox --name cat.jpg --file GettyImages-499713000-1000x653.jpg --auth-mode login

# remove after upload
rm GettyImages-499713000-1000x653.jpg

# naviage into views to 
cd views

# make copy of index to revert back to later, only if the backup doesnt exist
if [ ! -f /index.ejs.backup ]; then
    cp index.ejs index.ejs.backup
fi



# add line for img file, only if it doesnt already contain it (otherwise you end up with multiple cats if you rerun the script)
# grep -q is the pattern match flag, it will return true/false (hence why it works in the if statement)
if ! grep -q '<img src="https://tech257olivercatshop.blob.core.windows.net/catbox/cat.jpg"/>' index.ejs; then 
	sed -i '/<h2>/a\ <img src="https://tech257olivercatshop.blob.core.windows.net/catbox/cat.jpg"/>' index.ejs 
else 
	echo "Line already exists" 
fi

# restart pm2
cd ..
pm2 stop app.js
pm2 start app.js
```

**Result:**

![[Pasted image 20240314154540.png]]
# CAT!
## Bash Script - Restore

```bash
#!/bin/bash

# swap back to old index page and then restart pm2
cd repo/app/views
rm index.ejs
cp index.ejs.backup index.ejs
cd ..
pm2 stop app.js
pm2 start app.js

# delete storage account
az storage account delete -n tech257olivercatshop -g tech257 -y
```

This should restore the page to its old, cat-less, version.
## Storage Account Commands

### List Storage Accounts
```bash
# all details, lots and lots of json
az storage account list --resource-group tech257

# less details
az storage account list --resource-group tech257 --query "[].{Name:name, Location:location, Kind:kind}" --output table
```

Output (for the second command)
```bash
Name                   Location    Kind
---------------------  ----------  ---------
tech257oliverstorage   uksouth     StorageV2
tech257ramonstorage    uksouth     StorageV2
```

### List All Containers
```bash
# list all containers in storage account
az storage container list --account-name tech257oliverstorage --auth-mode login

# with table like above
az storage container list --account-name tech257oliverstorage --output table --auth-mode login
```

Output
```bash
Name           Lease Status    Last Modified
-------------  --------------  -------------------------
testcontainer                  2024-03-14T10:31:57+00:00
```

### List Blobs in Container
```bash
az storage blob list  --account-name tech257oliverstorage --container-name testcontainer --output table --auth-mode login
```