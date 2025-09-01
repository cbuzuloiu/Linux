Securing SSH access is one of the most important steps in hardening any Linux server. SSH is the primary method for remote management, and leaving it open to password authentication can make your server vulnerable to brute-force attacks. In this guide, we’ll walk through a simple, step-by-step process to secure SSH using key-based authentication and disabling password login.

## Step 1: Generate an SSH Key Pair

The first step is to create a pair of cryptographic keys — a **private key**, which stays on your client machine, and a **public key**, which is placed on the server.

### On Linux:

Open your terminal and run:

```shell
ssh-keygen -t rsa -b 2048 -C "key generated on Sep 2025"
```

- This will generate a 2048-bit RSA key pair.
- By default, the keys are stored in your `~/.ssh/` directory:
    - Private key: `~/.ssh/id_rsa`
    - Public key: `~/.ssh/id_rsa.pub`
### On Windows:

You can use **PuTTYgen** to generate SSH keys and save the private key on your PC. The public key will be copied to the server.

### Add the Public Key to DigitalOcean

For **new droplets**, you can add the public key directly in the DigitalOcean dashboard:`DigitalOcean → Security → Add SSH Key`

For **existing droplets**, you need to copy the public key manually: `ssh-copy-id root@<server-ip>`

After running this command, verify that your public key has been appended to the server’s `authorized_keys` file: `cat ~/.ssh/authorized_keys`

You should see your newly added public key listed there.

## Step 2: Disable Password Authentication

Once key-based authentication is working, the next step is to disable password login. This prevents attackers from trying to brute-force your root password.

1. Open the SSH configuration file: `sudo nano /etc/ssh/sshd_config`
2. Find the line that says: `#PasswordAuthentication yes`
3. Change it to: `PasswordAuthentication no`
4. Save the file and exit the editor
5. Restart the SSH service to apply the changes: `sudo systemctl restart sshd`

## Summary

By following these two steps:

1. **Generating an SSH key pair** and adding it to your server.
2. **Disabling password authentication**

…you significantly increase the security of your server. Only clients with the correct private key can log in, making it nearly impossible for attackers to gain access via brute-force attacks.
