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
1. Open Settings > Network > Adapter 1 > Advanced > Port Fowarding
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
    ./run.sh
    ```

9. After rebooting, in the guest, login as root and set the password of the just created user:
    ```bash
    root
    passwd dtg
    ```
10. Log out (`Ctrl` + `D`) and log in as the user.
