---
tags:
  - Ansible
  - DevOps
  - IaC
  - InfrastructureasCode
---
Run Playbook with

```bash
sudo ansible-playbook <playbook-name>.yaml
```
## Ansible Playbook

This playbook

- [x] Clones the Git Repository
- [x] Installs Nginx
- [x] Installs NodeJS
- [x] Installs the relevant NPM packages (including PM2)
- [x] Runs the app in PM2
- [x] Update the Nginx config file
- [x] Reloads Nginx

```yaml
# starts with ---
---

# where do you want to install or run this playbook
# group name, all, single hostname
- hosts: web


# see logs
  gather_facts: yes


# provide admin access to this playbook
  become: true

# clone git repo
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
      state: latest
      
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

  - name: Run pm2 delete all
    command: pm2 delete all
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

  - name: Add env variable
    lineinfile:
      path: /home/ubuntu/.bashrc
      line: export DB_HOST=mongodb://63.33.209.72:27017/posts
      create: yes

  - name: source bashrc
    shell: source ~/.bashrc && echo $DB_HOST
    args:
      executable: /bin/bash
    register: result

  - name: seed db
    shell: node /home/ubuntu/repo/app/app/seeds/seed.js

  - name: Run pm2 restart
    command: chdir=/home/ubuntu/repo/app/app pm2 restart app.js --update-env
    become_user: ubuntu
```

## Database

- [x] Install MongoDB
- [x] Reload systemd
- [x] Enable mongodb
- [x] Mongo Config
- [x] Restart mongodb

Add apt repo and key
https://gist.github.com/roib20/27fde10af195cee1c1f8ac5f68be7e9b

```yaml
---

- hosts: db
  gather_facts: yes
  become: true

  tasks:
  - name: Add MongoDB apt repository key
    ansible.builtin.get_url:
      url: "https://www.mongodb.org/static/pgp/server-7.0.asc"
      dest: "/usr/share/keyrings/mongodb-server-7.0.gpg"
      mode: '0644'
      force: yes

  - name: Add MongoDB repository
    apt_repository:
      repo: "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse"
      state: present
      filename: mongodb-org-7.0.list

  - name: Install mongodb
    apt:
      name: mongodb-org
      state: present

  - name: Reload systemd daemon
    systemd:
      daemon_reload: yes

  - name: Enable mongodb service
    systemd:
      name: mongod
      enabled: yes
      state: started

  - name: Modify MongoDB configuration
    ansible.builtin.lineinfile:
      path: /etc/mongod.conf
      regexp: "{{ item.regexp }}"
      line: "{{ item.line }}"
      backrefs: yes
    loop:
      - { regexp: '127.0.0.1', line: 'bind_ip: 0.0.0.0' }
      - { regexp: '#port: 27017', line: 'port: 27017' }

  - name: Restart mongod service
    systemd:
      name: mongod
      state: restarted
```