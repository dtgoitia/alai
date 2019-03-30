# Arch Linux Automatic Installation

Steps to install Arch Linux via SSH in another machine (guest) automatically:

## TL;DR

1. Start the live installation.
2. Ensure you have internet connection in your guest (run `wifi-menu` and follow the instructions).
3. Connect via SSH from your host to your guest (details [here](#connect-via-ssh)).
4. In your host, clone the installation scripts and execute them:
    ```bash
    git clone git://github.com/dtgoitia/alai
    cd alai
    ./run.sh
    ```

## Connect via SSH

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

## Setup WiFi

Installing the `base` group of packages installs `netctl` to handle the network connections. I will use the `networkmanager` package, which should be installed by the installation scripts. There is no need to uninstall `netctl` as it's very small (95KB).

The script will also automatically disable `netctl` and enable `NetworkManager` services. From then on, you can communicate with the `NetworkManager` service via the `nmcli` CLI client. This client is enough to manage and connect to WiFi networks.

## Setup X resources

Copy all the dotfiles from the host to the guest:

```bash
./install_xmonad.sh 2222
```

## Setup XMonad

1. Install required packages:
    ```bash
    sudo pacman -Syu --noconfirm xmonad xmonad-contrib xorg-server xorg-xinit rxvt-unicode
    ```
2. Set-up _X_ server-client required files:
    ```bash
    echo 'xmonad' > ~/.xinitrc
    echo 'xmonad' > ~/.xsession
    ```
3. Create _xmonad_ configuration file at `~/.xmonad/xmonad.hs`:
    ```haskell
    import XMonad

    main = xmonad def
        { terminal = "urxvt"
        }
    ```
4. Create `~/.Xresources` file to customize _rxvt-unicode_ terminal:
    ```
    URxvt*termName:          screen-256color
    URxvt*loginShell:        true
    URxvt*scrollWithBuffer:  false
    URxvt*background:        Black
    URxvt*foreground:        White
    URxvt*scrollBar:         false
    ```
    Ensure to run `xrdb ~/.Xresources` when you change the configuration, and then reopen  _rxvt-unicode_.

[Incredibly detailed `Xresources` settings](https://www.askapache.com/linux/rxvt-xresources/)

5. Install _xmobar_ package: `xmobar`.
6. Add _xmobar_ configuration to `~/.xmobarrc` (see [example](https://wiki.archlinux.org/index.php/Xmobar#Configuration)).
7. Configure _xmonad_ to start _xmobar_ on start:
    ```haskell
    mport XMonad
    import XMonad.Hooks.DynamicLog

    main = xmonad =<< xmobar defaultConfig
    {   modMask = mod4Mask
        { terminal = "urxvt"
        }
    }
    ```

## XMonad usage

- Open new terminal: `Alt`+`Shift`+`Enter`
- Exit Xmonad: `Alt`+`Shift`+`Q`
- Go to workspace 1, 2...: `Alt`+`1`, `Alt`+`2`, ...

## Troubleshooting

### Xresources

#### Xresources are not being loaded

When you start _X_ using a custom `.xinitrc`, you need to specify the _X_ config files to be loaded. Otherwise you'll be presented with a plain default settings (white and ugly).

**Solution**: run `xrdb ~/.Xresources`. The new settings should be picked up when you open a new terminal.
In order to load the custom _X_ configurations on start, add the instruction to your `.xinitrc` file:
```text
xrdb ~/.Xresources

xmonad
```

## Development

Bear in mind:

  - Scripts needs to have `777` permissions: `chmod 777 path_to_script`.
  - Configuration files ending in `CRLF` can cause problems in Linux (_XMonad_, etc.).

