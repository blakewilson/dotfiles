# Blake's Dotfiles

## Pre Reqs

- [brew](https://brew.sh) must be installed.

## install

There are a few scripts in here that do different things. At some point, it may make sense to combine them into one bootstrap script, but for now they are broken up.

For a new system, install should occur in the following order:

0. Clone the repo into `~/dotfiles`:

```
git clone git@github.com:blakewilson/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

1. Install brew dependencies and casks:

```
cd brew
sh install.sh
```

This will install all of the brew dependencies and MacOS apps I use, like 1Password, Spotify, Postman, etc.

2. Download Fonts

Download the [MonoLisa Font](https://www.monolisa.dev) and place the `.otf` files in `~/dotfiles/fonts/MonoLisa`. Once that is done, run `sh fonts/install-fonts.sh`

3. Run the `setup.sh` script:

```
sh setup.sh
```

This will symlink important files (ex. `.zshrc`, `.gitconfig`, `.config/nvim`) and install NVM/Oh My Zsh if they don't already exist.

4. Set MacOS defaults

```
cd macos
sh set-defaults.sh
```

NOTE: In order for all preferences to take place, iTerm, or the terminal running the command, must have full disk access and accessibility permissions.

This will set all the MacOS defaults I use (Dock position, key repeating, etc).
