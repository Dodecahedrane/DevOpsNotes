---
tags:
  - Ansible
  - DevOps
  - IaC
  - InfrastructureasCode
---
## Ansible Dependencies

Add the Ansible repo to apt-get and install

```bash
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible
```

Make sure you have the correct ssh keys in the .ssh folder for the nodes you want Ansible to connect to and configure.

To ping all machines in the hosts list

```bash
sudo ansible all -m ping
```

To add a machine to the host list

```bash
nano /etc/ansible/hosts
```

```text
[web]
ec2-web ansible_host=3.252.81.226 ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/tech257.pem
```

```text
[group-name]
[name] ansible_host=[ip-address] ansible_user=[ssh username] ansible_ssh_private_key_file=[ssh-file]
```

Run a single *adhoc* command

```bash
sudo ansible [all or group-name] -a "uname -a"
```


Copy a file from local to remote with an adhoc command

```bash
ansible web -m ansible.builtin.copy -a "src=~/.ssh/tech257.pem dest=.ssh/"

ansible [group-name/remote] -m ansible.builtin.copy -a "src=[source-file] dest= [destination-path]"
```