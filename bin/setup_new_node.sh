#!/bin/bash
# This script sets up a new node for ansible. How? 
# 1- Creates an ansible user, with no password.
# 2- Adds an SSH Key for the ansible user, so the ansible server can access it. 
# 3- Sets up sudo for this user so it doesn't need a password.

function check_status() {
if [ $1 -gt 0 ]
then
    echo "FAILED"
    exit 1
else
    echo "DONE"
fi
}

# 1- Creates an ansible user, with no password.
echo -n "1. Adding ansible user..."
useradd -m -s /bin/bash ansible &> /dev/null
check_status $?

# 2- Adds an SSH Key for the ansible user, so the ansible server can access it. 
echo -n "2. Adding SSH Key..."
mkdir -p  ~ansible/.ssh/ && chown 0700 ~ansible/.ssh
cat >> ~ansible/.ssh/authorized_keys << EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDH8nJUHgct5gRBLCJs46TSYQu7IklE1K28JkSVFRZN0LZv7XOX+v7l6Gy+KyGevXRX5V5mq/hyVg9sSJaWl90xTVGHgOt9a4BOrcWLgT+q1Oy22nT8JpszKkKzND+VGct70HGzoZedPOVmuuMXkSW8lVwsN6VXPXOS03ybqRXtpBOx1eoWGJlsM/E86853Cd+NzMrpiewldPXaB5Sw+gze+s4MNk9dP1DoQRUGDxEmJmjhuhR9xrzPTzhO9q/jWSSWTQqBzsZz5eEC4cl+eTTCUmdAnbjD8adBdNJQw7KW1/ZxMl48E0MjMGmf7IxO+CLTdWEnRBRNCj33Nb/jETgT ansible@ansible-master
EOF
chown ansible:ansible -R ~ansible/.ssh
check_status $?


# 3- Sets up sudo for this user so it doesn't need a password.
echo -n "3. Add ansible to sudoers..."
if [ ! -e /etc/sudoers.d/ansible ]
then
    echo "ansible ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/ansible
fi
check_status $? 

