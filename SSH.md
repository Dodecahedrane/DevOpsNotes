SSH Stands for Secure Shell 

It is a secure protocol that allows two computers to communicate, even over unsecure or open networks.

Its main use is for remote login and CLI access to remote computers.

It works on port 22 by default.

SFTP (SSH Fire Transfer Protocol) is a secure file transfer method based on SSH

You can use a SSH client to connect to a remote computer, you need to generate a public/private key pair to do this. Common tools for this are PuTTY and OpenSSH.

On the users computer, you need to generate a key pair and add the private key to your SSH key list. You can then transfer the public key to the remote computer.

The exchange of keys allows for the setup for a secure connection.

![SSH Key Exchange Diag.](https://download-hk.huawei.com/mdl/image/download?uuid=5bb1ed892cda426f8162ddcd06d8b466)
## How to set up a SSH connection to a remote computer
### Generate a public/private key pair

[Guide for Ubuntu 22.04](https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys-on-ubuntu-22-04)

Generate a key pair, normally in the ``.ssh`` folder

```bash
ssh-keygen
```

This is the output for that command

```bash
Generating public/private rsa key pair.
Enter file in which to save the key (/your_home/.ssh/id_rsa):
```

You can set a optional passphrase

```bash
Enter passphrase (empty for no passphrase):
```

The final output should be

```bash
Your identification has been saved in /your_home/.ssh/id_rsa
Your public key has been saved in /your_home/.ssh/id_rsa.pub
The key fingerprint is:
SHA256:/hk7MJ5n5aiqdfTVUZr+2Qt+qCiS7BIm5Iv0dxrc3ks user@host
The key's randomart image is:
+---[RSA 3072]----+
|                .|
|               + |
|              +  |
| .           o . |
|o       S   . o  |
| + o. .oo. ..  .o|
|o = oooooEo+ ...o|
|.. o *o+=.*+o....|
|    =+=ooB=o.... |
+----[SHA256]-----+
```

The randomart is meant to be an easier way for humans to validate keys.

### Add the public key to the server

For this method to work, you must already have password-based SSH access to your server.

```bash
ssh-copy-id username@remote_host
```
 
 You may get the following, type `yes`, and press enter
 
```bash
The authenticity of host '203.0.113.1 (203.0.113.1)' can't be established.
ECDSA key fingerprint is fd:fd:d4:f9:77:fe:73:84:e1:55:00:ad:d6:6d:22:fe.
Are you sure you want to continue connecting (yes/no)? yes
```

```bash
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
username@203.0.113.1's password:
```

**There are other ways to add the public key, a lot of cloud services let you do this automatically in their GUI/CLI when you create a new compute instance

### Get the Public Key

```bash
cat ~/.ssh/id_rsa.pub
```

Output

```bash
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCqql6MzstZYh1TmWWv11q5O3pISj2ZFl9HgH1JLknLLx44+tXfJ7mIrKNxOOwxIxvcBF8PXSYvobFYEZjGIVCEAjrUzLiIxbyCoxVyle7Q+bqgZ8SeeM8wzytsY+dVGcBxF6N4JS+zVk5eMcV385gG3Y6ON3EG112n6d+SMXY0OEBIcO6x+PnUSGHrSgpBgX7Ks1r7xqFa7heJLLt2wWwkARptX7udSq05paBhcpB0pHtA1Rfz3K2B+ZVIpSDfki9UVKzT8JUmwW6NNzSgxUfQHGwnW7kj4jp4AT0VZk3ADw497M2G/12N0PPB5CnhHf7ovgy6nL1ikrygTKRFmNZISvAcywB9GVqNAVE+ZHDSCuURNsAInVzgYo9xgJDW8wUw2o8U77+xiFxgI5QSZX3Iq7YLMgeksaO4rBJEa54k8m5wEiEE1nUhLuJ0X/vh2xPff6SQ1BL/zkOhvJCACK6Vb15mDOeCSq54Cr7kvS46itMosi/uS66+PujOO+xt/2FWYepz6ZlN70bRly57Q06J+ZJoc9FfBCbCyYH7U/ASsmY095ywPsBo1XQ9PqhnN1/YOorJ068foQDNVpm146mUpILVxmq41Cj55YKHEazXGsdBIbXWhcrRf4G2fJLRcGUr9q8/lERo9oxRm5JFX6TCmj6kmiFqv+Ow9gI0x8GvaQ== demo@test
```

### Authenticate with SSH

Once the keys are set up you can connect with SSH

```bash
ssh user@remote_host
```

You may get

```bash
The authenticity of host '203.0.113.1 (203.0.113.1)' can't be established.
ECDSA key fingerprint is fd:fd:d4:f9:77:fe:73:84:e1:55:00:ad:d6:6d:22:fe.
Are you sure you want to continue connecting (yes/no)?
```

Again, type yes, press enter

This will then open a secure shell in your terminal

You may want to disable Password based authentication (as this is susceptible to brute force attacks) on your server after this is configured. Just make sure you have the SSH configured correctly, and for the **root** user!

```bash
sudo nano /etc/ssh/sshd_config
```

Modify this line:

```bash
PasswordAuthentication no
```

Run this to restart the SSH process

```bash
sudo systemctl restart ssh
```

Password based authentication is now disabled.

