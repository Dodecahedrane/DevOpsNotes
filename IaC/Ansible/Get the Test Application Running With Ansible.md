---
tags:
  - Ansible
  - DevOps
  - IaC
  - InfrastructureasCode
---
## Ansible Playbook

This playbook

- [x] Clones the Git Repository
- [x] Installs Nginx
- [x] Installs NodeJS
- [x] Installs the relevant NPM packages (including PM2)
- [x] Runs the app in PM2
- [x] Update the Nginx config file
- [x] Reloads Nginx

Run Playbook with

```bash
sudo ansible-playbook <playbook-name>.yaml
```

```yaml
---

- hosts: web
  gather_facts: yes
  become: true
  
  tasks:
  - name: Clone the github repo test-app
    git:
      repo: https://github.com/Dodecahedrane/test-app.git
      dest: /home/ubuntu/repo/
      clone: yes
      update: yes

  - name: Install and Configure Ngnix on the web nodes
    apt:
      pkg=nginx
      state=present

  - name: "Add nodejs apt key"
    apt_key:
      url: https://deb.nodesource.com/gpgkey/nodesource.gpg.key
      state: present

  - name: "Add nodejs 17.x ppa for apt repo"
    apt_repository:
      repo: deb https://deb.nodesource.com/node_17.x bionic main
      update_cache: yes

  - name: Install nodejs
    apt:
      name: nodejs
      state: present

  - name: Install npm packages
    npm:
      path: /home/ubuntu/repo/app/app/
      state: present

  - name: Install express
    npm:
      name: express
      global: yes

  - name: Install mongoose
    npm:
      name: mongoose
      global: yes

  - name: Install ejs
    npm:
      name: ejs
      global: yes

  - name: Install PM2
    npm:
      name: pm2
      global: yes

  - name: Run pm2 stop all
    command: pm2 stop all
    ignore_errors: true
    become: yes

  - name: Run pm2 start
    command: chdir=/home/ubuntu/repo/app/app pm2 start app.js -f
    become_user: ubuntu

  - name: nginx copy new config using lineinfile
    ansible.builtin.lineinfile:
      path: /etc/nginx/sites-available/default
      regexp: '^try_files \$uri \$uri/ =404;'
      line: 'proxy_pass http://127.0.0.1:3000;'
      backrefs: yes

  - name: nginx
    ansible.builtin.service:
      name: nginx
      state: restarted
      enabled: yes
    become: yes
```

## Database

```yaml
---

- hosts: db
  gather_facts: yes
  become: true

  tasks:
  - name:  Add mongo apt key
    apt_key:
      url: https://www.mongodb.org/static/pgp/server-7.0.asc
      state: present
      
  - name: Add mongo to apt repo
    apt_repository:
      repo: deb https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse
      update_cache: yes

  - name: Install MongoDB packages
    apt:
      name: "{{ item }}"
      state: present
      update_cache: yes
    loop:
      - mongodb-org=7.0.6
      - mongodb-org-database=7.0.6
      - mongodb-org-server=7.0.6
      - mongodb-mongosh=2.1.5
      - mongodb-org-mongos=7.0.6
      - mongodb-org-tools=7.0.6

  - name: Hold MongoDB packages
    command: "echo '{{ item }} hold' | sudo dpkg --set-selections"
    loop:
      - mongodb-org
      - mongodb-org-database
      - mongodb-org-server
      - mongodb-mongosh
      - mongodb-org-mongos
      - mongodb-org-tools
      - 
  - name: Reload systemd daemon
    systemd:
      daemon_reload: yes
  - name: Enable mongod service
    systemd:
      name: mongod
      enabled: yes
      state: started

  - name: nginx copy new config using lineinfile
    ansible.builtin.lineinfile:
      path: /etc/mongod.conf
      regexp: '127.0.0.1'
      line: '0.0.0.0'
      backrefs: yes

  - name: Enable mongod service
    systemd:
      name: mongod
      state: restarted

```