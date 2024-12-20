# dotfiles
Ensure `git` is installed and simply run
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/jmarndt/dotfiles/master/install.sh)
```

To skip flatpak
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/jmarndt/dotfiles/master/install.sh) --no-flatpak
```

You can also skip flatpak, nvm/angular/typescript and SSH key generation
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/jmarndt/dotfiles/master/install.sh) server
```
