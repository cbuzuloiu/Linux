
OpenSSH is the most widely used tool for securely connecting to remote servers. Whether you’re managing an Ubuntu or CentOS system, OpenSSH provides encrypted communication over insecure networks. In this post, we’ll go through:

1. Installing OpenSSH (client & server)
2. Controlling the SSH daemon
3. Securing SSH with best practices

## 1. Installing OpenSSH

Depending on your Linux distribution, you’ll need slightly different commands.

On Ubuntu:

```bash
sudo apt update && sudo apt install openssh-server openssh-client
```

On CentOS:

```
sudo dnf install openssh-server openssh-clients
```

Once installed, you can connect to a server using the `ssh` command:

``` bash
ssh -p 22 username@server_ip
# or 
ssh -p 2267 john@192.168.0.100
# or
ssh -p 22 -l username server_ip
```

## 2. Controlling the SSH Daemon

The SSH server runs as a background service (`sshd`). You’ll often need to check its status or restart it after changes.

Checking status:

```bash
# Ubuntu
sudo systemctl status ssh

# CentOS
sudo systemctl status sshd
```

Stopping the daemon:

```bash
# Ubuntu
sudo systemctl stop ssh

# CentOS
sudo systemctl stop sshd
```

Restarting the daemon:

```bash
# Ubuntu
sudo systemctl restart ssh

# CentOS
sudo systemctl restart sshd
```

Enabling SSH at boot:

```bash
# Ubuntu
sudo systemctl enable ssh
sudo systemctl is-enabled ssh

# CentOS
sudo systemctl enable sshd
sudo systemctl is-enabled sshd
```

## 3. Securing the SSH Daemon

By default, SSH is relatively secure, but it’s always a good practice to harden your configuration. The main configuration file is:

```bash
/etc/ssh/sshd_config
```

After making changes, restart the SSH service.

```
sudo systemctl restart ssh     # Ubuntu
sudo systemctl restart sshd    # CentOS
```

Recommended Security Tweaks

1. **Change the default port** (to reduce automated attacks): `Port 2278`
2. **Disable root login**: `PermitRootLogin no`
3. **Restrict access to specific users**: `AllowUsers stud u1 u2 john`
4. **Filter access at the firewall level** (e.g., with iptables or firewalld)
5. **Enable key-based authentication & disable password authentication**: `PasswordAuthentication no`
6. **Force SSH protocol version 2**: `Protocol 2`
7. **Additional hardening options**:
```bash
ClientAliveInterval 300
ClientAliveCountMax 0
MaxAuthTries 2
MaxStartUps 3
LoginGraceTime 20
```

OpenSSH is a must-have tool for any system administrator. With just a few commands, you can set it up, manage it, and secure it against common threats. By changing the default port, disabling root login, enforcing key-based authentication, and applying strict timeouts, you’ll significantly reduce the attack surface of your server.