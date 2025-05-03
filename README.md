# Dotfiles and utils

## Prerequisites

**Arch Linux**

```
sudo pacman -S stow git zsh tmux fzf jq ripgrep go php node npm composer neovim
```

**Debian/Ubuntu**

```
sudo apt install stow git zsh tmux fzf jq ripgrep golang php node npm composer
```

Latest neovim must be [installed from source](https://github.com/neovim/neovim/blob/master/BUILD.md).

## Install

Clone this repo:

```
git clone https://github.com/mecha/.dotfiles ~/.dotfiles
cd ~/.dotfiles
```

Init submodules:

```
git submodule init
git submodule update
```

Stow symlinks:

```
make install
```

# Uninstall

```
make uninstall
```
