# Dotfiles and utils

## Prerequisites

**Arch Linux**

```
sudo pacman -S stow git zsh tmux fzf jq ripgrep go php nodejs npm composer neovim
```

**Debian/Ubuntu**

```
sudo apt install stow git zsh tmux fzf jq ripgrep golang php nodejs npm composer
```

Latest neovim must be [installed from source](https://github.com/neovim/neovim/blob/master/BUILD.md).

## Install

1. Install [packages](./packages)
2. Clone this repo:

```
git clone https://github.com/mecha/.dotfiles ~/.dotfiles
cd ~/.dotfiles
```

3. Init submodules:

```
git submodule init
git submodule update
```

4. Stow symlinks:

```
make install
```

# Uninstall

```
make uninstall
```
