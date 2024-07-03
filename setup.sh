#!/bin/bash

# Inspired by https://github.com/vsbuffalo/dotfiles/blob/master/setup.sh

set -e
set -u

RCol='\033[0m'
Green='\033[0;32m'
Red='\033[0;31m'
Yellow='\033[0;33m'

## printing functions ##
function gecho {
  echo "${Green}[message] $1${RCol}"
}

function yecho {
  echo "${Yellow}[warning] $1${RCol}"
}

function wecho {
  # red, but don't exit 1
  echo "${Red}[error] $1${RCol}"
}


function recho {
  echo "${Red}[error] $1${RCol}"
  exit 1
}

# check for pre-req, fail if not found
function check_preq {
  (command -v $1 > /dev/null  && gecho "$1 found...") ||
    recho "$1 not found, install before proceeding."
}

# function for linking dotfiles
function linkdotfile {
  source_file="$1"
  dest_file="$2"

  if [ -z "$dest_file" ]; then
    dest_file="$source_file"
  fi

  if [ ! -e "$HOME/$dest_file" ] && [ ! -L "$HOME/$dest_file" ]; then
      yecho "$dest_file not found, linking..." >&2
      ln -s "$HOME/dotfiles/$source_file" "$HOME/$dest_file"
  else
      gecho "$dest_file found, ignoring.." >&2
      if [ ! -L "$HOME/$dest_file" ]; then
        wecho "$dest_file is a regular file, not a symlink. You may need to manually create the symlink or delete the file in its place before running the script again"
      fi
  fi
}

# Check/install NVM if does not exist
check_and_install_nvm() {
    # Source NVM script to make sure it's available in the current shell session
    if [ -s "$HOME/.nvm/nvm.sh" ]; then
        \. "$HOME/.nvm/nvm.sh"
    fi

    if command -v nvm > /dev/null 2>&1; then
        gecho "NVM already installed"
    else
        yecho "NVM not found, installing..."
        # Download and install NVM
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

        gecho "NVM installation complete"
    fi
}

install_oh_my_zsh() {
  # Check if ~/.oh-my-zsh directory exists
  if [ -d "$HOME/.oh-my-zsh" ]; then
    gecho "Oh My Zsh already installed"
  else
    yecho "Oh My Zsh not found. Installing..."
    # Install Oh My Zsh
    KEEP_ZSHRC=yes RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi
}

# check for pre-req, fail if not found
function check_preq {
  (command -v $1 > /dev/null  && gecho "$1 found...") ||
    recho "$1 not found, install before proceeding."
}

# are we in right directory?
[[ $(basename $(pwd)) == "dotfiles" ]] ||
  recho "doesn't look like you're in dotfiles/"

# check that the key pre-requisites are met:
check_preq brew

# Linking
linkdotfile git/.gitconfig .gitconfig
linkdotfile zsh/rc.zsh .zshrc
linkdotfile nvim .config/nvim
linkdotfile editor/.editorconfig .editorconfig
linkdotfile vscode/settings.json /Library/Application\ Support/Code/User/settings.json
linkdotfile vscode/keybindings.json /Library/Application\ Support/Code/User/keybindings.json

## Install NVM if it doesn't exist. If it does exist, it will NVM will be updated.
check_and_install_nvm

## Install oh my zsh if it doesn't exist
install_oh_my_zsh

# Install Brew things
brew bundle install --file=brew/Brewfile
