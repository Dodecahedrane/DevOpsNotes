---
tags:
  - Cloud
  - DevOps
  - Azure
  - SSH
---
## Connect With [[SSH]]

[Azure Docs](https://learn.microsoft.com/en-us/azure/virtual-machines/ssh-keys-portal)

When you create a new VM on Azure you get the choice to generate a public/private key pair. It will then download the private key when the VM is created.

It will be in a .pem file.

You can connect with the following command (assuming openSSH is installed)

```bash
ssh -i <path to the .pem file> username@<ipaddress of the VM>
```

```bash
ssh -i .\tech257-oliver-learn-linux-vm-key.pem oliver@172.187.157.145
```

Type Yes and press Enter if it does not recognize the host 

## Disconnect from VM

type `exit` when SSH'd into the VM to exit and return to your local terminal