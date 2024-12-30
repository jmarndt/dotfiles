# dotfiles
The only prerequisuite for this repository is `git`. For Linux this should be installed by default with most distrobutions. For macOS there are a couple of extra steps before running the install. See notes below.

## Install
Ensure `git` is installed and simply run
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/jmarndt/dotfiles/master/install.sh)
```

## Context
Context can be controlled by passing flags to the `install.sh` script. Setting context allows different configurations for different systems, such as a server. The `default` context is used if no flags are provided
```text
PACKAGE_MANAGER=<apt | dnf | brew> # Configured during execution
IS_SERVER=false
IS_WORK=false
INSTALL_FLATPAK=true
INSTALL_SSH_KEYS=true
INSTALL_NODE=true
```

If any flag is passed, all present flags will be true and all absent flags will be false
```bash
install.sh [-s | --server] [-f | --flatpak] [-w | --work] [-S | --ssh] [-n | --node]
    -s | --server   Directs install scripts to use server specific configs.
    -w | --work     Adds work specific system config.
    -f | --flatpak  Will cause provided Flatpaks to be installed.
    -n | --node     Installs NVM/latest Node LTS, along with a few packages via npm.
    -S | --ssh      Generates SSH keys (~/.ssh/id_ed25519) if they don't exist.
    -r | --reset    Ignores existing context and generates a default context.
```

# macOS
In order to use `git` in macOS you must first install `Command Line Tools`. Additionally, if you want the terminal to be able to make changes to system settings the `Terminal.app` will need to be given `Full Disk Access`. Running this script will check the permissions, and prompt if needed, and will also install the `Command Line Tools`.
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/jmarndt/dotfiles/master/scripts/macos.sh)

```
