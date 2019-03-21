# Arch Linux Automatic Installation

1. Increase your `cow_space`: `mount -o remount,size=2G /run/archiso/cowspace` (TODO: can this 2GB be reduced?)
2. Get list of packages and install Git: `pacman -Sy git`
3. Get your installation script:
    ```bash
    git clone git://github.com/dtgoitia/alai
    cd alai
    ./run
    ```

## Development

Ensure to give permissions to your BASH script before committing the file:

```bash
chmod 777 path_to_script
```

### Connect via SSH

If you are in VirtualBox, configure it to expose the guest port 22 at host's port 2222:
1. Open Settings > Network > Adapter 1 > Advanced > Port Forwarding
2. Create a new rule:
    ```text
    Name        | Protocol | Host IP | Host Port | Guest IP | Guest Port
    My SSH rule | TCP      |         | 2222      |          | 22
    ``` 
    More info [here](https://blog.johannesmp.com/2017/01/25/port-forwarding-ssh-from-virtualbox#port-forwarding-ssh)
3. On the host, if you have rebooted the VM:
    ```bash
    ssh-keygen -R [127.0.0.1]:2222
    ```
    This command will remove the old fingerprint
4. On the guest:
    ```bash
    passwd
    systemctl start sshd
    ```
5. From the host:
    ```bash
    $ ssh -p 2222 root@127.0.0.1
    The authenticity of host '[127.0.0.1]:2222 ([127.0.0.1]:2222)' can't be established.
    ECDSA key fingerprint is SHA256:/9MTMlkNq684abDnAIuhJcrT7VYrc2criEAN6GHiDgG.
    Are you sure you want to continue connecting (yes/no)? yes
    Warning: Permanently added '[127.0.0.1]:2222' (ECDSA) to the list of known hosts.
    root@127.0.0.1's password: 
    ```
6. Type the password set in step 1.
7. If everything went OK, you should be now inside the VM shell. Press `Ctrl+D` to exit.
8. From the host:
    ```bash
    ./run.sh 2222
    ```

9. After rebooting, in the guest, login as root and set the password of the just created user:
    ```bash
    root
    passwd dtg
    ```
10. Log out (`Ctrl` + `D`) and log in as the user.

## Troubleshooting

### SSH

#### Middle man attack error

When the SSH signature changes, you might get an eror as such:
```bash
$ ssh -p 2222 root@127.0.0.1
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that a host key has just been changed.
The fingerprint for the ECDSA key sent by the remote host is
SHA256:J84wZShoQS/w1fdMy1xP2cw2KW1W+keKuU/TAgwEucd.
Please contact your system administrator.
Add correct host key in /c/Users/your-host-hostname/.ssh/known_hosts to get rid of this message.
Offending ECDSA key in /c/Users/your-host-hostname/.ssh/known_hosts:6
ECDSA host key for [127.0.0.1]:2222 has changed and you have requested strict checking.
Host key verification failed.
```

**Solution**: remove the fingerprint associated with the guest address you are trying to connect to, which is shown in the error message: `[127.0.0.1]:222`.

To do so:
1. Edit `~/.ssh/known_hosts`.
2. Find and remove the line starting with `[127.0.0.1]:2222`. 
3. Try to connect again.
4. The SSH client should prompt you to save the new fingerprint.

#### Log in as user

```bash
ssh -p 2222 myusername@127.0.0.1
```
And type `myusername`'s password.
