# Dotfiles
Just my configuration files.

# Install

## Debian
```sh
# Install git
sudo apt-get update
sudo apt-get install git subversion

# Install Linuxbrew (if ~/.local not exist then just clone)
cd ~/.local
git init
git remote add origin https://github.com/Linuxbrew/brew.git
git fetch origin
git checkout -b master --track origin/master

# Install configs
cd ~/.config
git init
git remote add origin https://github.com/russtone/dotfiles
git fetch origin
git checkout -b master --track origin/master

# Install brew packages
brew tap Homebrew/bundle
cd ~/.config
brew bundle

# zsh
sudo apt-get install gawk
echo 'export ZDOTDIR="$HOME/.config/zsh"' | sudo tee -a /etc/zshenv > /dev/null
echo "$HOME/.local/bin/zsh" | sudo tee -a /etc/shells > /dev/null
chsh -s /usr/bin/zsh <user>
zplug install

# tmux
tmx
<prefix>I

# neovim
sudo apt-get install libclang-3.6-dev
sudo apt-get install python-dev python-pip python3-dev python3-pip
pip3 install neovim
nvim -c ':PlugInstall | :UpdateRemotePlugins'

# Fira font
svn checkout https://github.com/mozilla/Fira/trunk/ttf /tmp/fira
sudo mv /tmp/fira /usr/share/fonts/truetype/
gsettings set org.gnome.desktop.interface monospace-font-name 'Fira Mono 14'

# Gruvbox gnome colors
sudo apt-get install dconf-cli
git clone https://github.com/metalelf0/gnome-terminal-colors /tmp/gnome-terminal-colors
cd /tmp/gnome-terminal-colors && ./install.sh
```

## macOS
```sh
# Clone
git clone git@github.com:russtone/dotfiles.git ~/.config

# Set $ZDOTDIR
echo 'export ZDOTDIR="$HOME/.config/zsh"' | sudo tee /etc/zshenv > /dev/null

# Set OS X environment variables
mkdir ~/Library/LaunchAgents
ln -s ~/.config/osx/environment.plist ~/Library/LaunchAgents/environment.plist
```
