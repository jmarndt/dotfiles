# dotfiles
These are my dotfiles that contain customized configurations for a handful of applications for a unified expereince across machines.

## bootstrapping
To setup a fresh (Debian or macOS) install with basic tools and these dotfiles simply run the following from the terminal.
```
curl https://raw.githubusercontent.com/jmarndt/dotfiles/master/bootstrap | bash
```

# bootstrapping
First install make sure your system is up to date then install packages accordingly.

## apt / dnf
```bash
sudo apt install -y $(curl -fsSL https://raw.githubusercontent.com/jmarndt/dotfiles/master/packages/apt)
```
```bash
sudo dnf install --skip-unavailable -y $(curl -fsSL https://raw.githubusercontent.com/jmarndt/dotfiles/master/packages/apt)
```

## flatpak
```bash
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```
```bash
cat $(curl -fsSL https://raw.githubusercontent.com/jmarndt/dotfiles/master/packages/flatpak) | xargs -I{} flatpak install -y {}
```
