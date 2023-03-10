# server
Server monorepo and documentation

## Getting Started

```sh
docker network create -d bridge elemental_net
```

## Server Setup

### Debian


**Connect to the server**

```sh
ssh root@192.0.2.1
```

**Change root password**

```sh
passwd
```

> input new password at least 80 characters long, and make sure to disable SSH password auth after

**Upgrade system**

```sh
apt update && apt upgrade
```

**Configure timezone**

```sh
dpkg-reconfigure tzdata
```

> input `Etc/UTC`

**Add a limited user account**

```sh
adduser example_user
adduser example_user sudo
```

**SSH into limited user**

```sh
ssh example_user@192.0.2.1
```

**On your local machine, generate SSH keys**

```sh
ssh-keygen -b 4096
cat ~/.ssh/id_rsa.pub # or custom_name.pub
```

**Copy paste this into the remote server with `vim`/`nano`:**


```sh
mkdir -p ~/.ssh && sudo chmod -R 700 ~/.ssh/
```

```sh
vim ~/.ssh/authorized_keys
```

> paste public key

```sh
sudo chmod -R 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys
```

**Disable password and root SSH login**

```sh
sudo vim /etc/ssh/sshd_config
```

**`/etc/ssh/sshd_config`**
```
PermitRootLogin no
PasswordAuthentication no
AddressFamily inet # IPv4 only - reduce attack surface area
```

**Restart SSH service**

```sh
sudo systemctl restart sshd
```

**Install fail2ban**

```sh
sudo apt update
sudo apt install fail2ban
```

**Configure fail2ban**

```sh
cd /etc/fail2ban
sudo cp jail.conf jail.local
sudo vim jail.local
```

**`/etc/fail2ban/jail.local`**
```
bantime = 10m
findtime = 10m
maxretry = 5
```

```
[sshd]
. . .
enabled = true
. . .
```

**Enable fail2ban**

```sh
sudo systemctl enable fail2ban
sudo systemctl start fail2ban
sudo systemctl status fail2ban
```

**Setup Firewall**

```sh
sudo apt install ufw
```

**Default Firewall Rules**

```sh
sudo ufw default allow outgoing
sudo ufw default deny incoming
```

