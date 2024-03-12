## Make an Azure VM Image for faster creation of a standardized VM

Install the [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)

In the VM run these commands to prepare the VM to be imaged

**This will remove the all the users and their home directories!**

Images are most useful if you need to have a standardized base that all VMs build upon - such as having monitoring utilities installed by default or various configurations set in a particular way.

```bash
sudo waagent -deprovision+user
```

Log into Azure on the CLI

```bash
az login
```

View Account

```bash
az account show
```

Output

```bash
{
  "environmentName": "AzureCloud",
  "homeTenantId": "ff15c67c-2870-4e9f-adc1-7d61d855b667",
  "id": "cd36dfff-6e85-4164-b64e-b4078a773259",
  "isDefault": true,
  "managedByTenants": [],
  "name": "Azure Training",
  "state": "Enabled",
  "tenantId": "ff15c67c-2870-4e9f-adc1-7d61d855b667",
  "user": {
    "name": "OGuy@spartaglobal.com",
    "type": "user"
  }
}
```

Stop VM

```bash
az vm deallocate --resource-group <resource-group> --name <vm-name>
```

```bash
az vm deallocate --resource-group tech257 --name tech257-oliver
```

Generalize VM image

```bash
az vm generalize --resource-group <yourResourceGroup> --name <yourVMName>
```

```bash
az vm generalize --resource-group tech257 --name tech257-oliver
```

In Portal click Capture

![[Pasted image 20240311155107.png]]

Fill out details, click create, be aware this will destroy this instance of the VM.

Click create image

To make an image from this VM, this will only work if the VM is set to security type of 'Standard'. Otherwise you wont be able to make an image.

Click 'See All Images'

![[Pasted image 20240311161018.png]]

Click 'My Images'

![[Pasted image 20240311161047.png]]

Select From List

![[Pasted image 20240311161058.png]]

Create the rest of the VM as standard following [[Create a VM on Azure]] guide