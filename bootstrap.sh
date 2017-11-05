#!/usr/bin/env bash

pacman -Syu --noconfirm zsh tmux neovim sshfs wget curl git make ghc \
  the_silver_searcher tree python2 python2-pip python python-pip ruby xclip
# Install x11 and xmonad
# Most likely not working in ssh
# sudo pacman -Syu --noconfirm xmonad st xorg xorg-xinit xorg-twm xorg-xclock \
#   xterm xmonad-contrib stalonetray xmobar
# Other packages could be:
# i3 xmonad
# If the --noconfirm flag doesn't work:
#yes | sudo pacman -Syu --noconfirm zsh tmux neovim sshfs

echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
echo "danielb ALL=(ALL) ALL" >> /etc/sudoers

# # Create user for me
useradd -m -G wheel -s /usr/bin/zsh danielb

HOME_PATH="/home/danielb"

# Install Oh My Zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git \
  $HOME_PATH/.oh-my-zsh >/dev/null 2>&1
wget https://raw.githubusercontent.com/rupa/z/master/z.sh -O \
  $HOME_PATH/z.sh >/dev/null 2>&1
cp /mnt/dotfiles/agnoster-min.zsh-theme \
  $HOME_PATH/.oh-my-zsh/themes/agnoster-min.zsh-theme

# install tmux package manager and packages to it
git clone https://github.com/tmux-plugins/tpm \
  $HOME_PATH/.tmux/plugins/tpm >/dev/null 2>&1
git clone https://github.com/tmux-plugins/tmux-resurrect \
  $HOME_PATH/.tmux/plugins/tmux-resurrect >/dev/null 2>&1
git clone https://github.com/tmux-plugins/tmux-logging \
  $HOME_PATH/.tmux/plugins/tmux-logging >/dev/null 2>&1
git clone https://github.com/tmux-plugins/tmux-yank \
  $HOME_PATH/.tmux/plugins/tmux-yank >/dev/null 2>&1
git clone https://github.com/tmux-plugins/tmux-battery \
  $HOME_PATH/.tmux/plugins/tmux-battery >/dev/null 2>&1

# install vimplug
sudo curl -flo $HOME_PATH/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
    >/dev/null 2>&1

sudo mkdir -p $HOME_PATH/.config/nvim/bundle

# GEM_HOME=$(ls -t -U | ruby -e 'puts Gem.user_dir')
# GEM_PATH=$GEM_HOME
# export PATH=$PATH:$GEM_HOME/bin

# Installing python and ruby neovim packages, and silencing the output
sudo pip install neovim >/dev/null 2>&1
gem install neovim >/dev/null 2>&1

# sudo cp -a /vagrant/dotfiles/. /home/danielb

# sudo chown -Rv danielb /home/danielb/.

# mkdir -p /home/danielb/.config/nvim/tmp/{undo,backup,swap}
sudo ln -fs /vagrant/dotfiles/. /home/danielb/

sudo chown -Rv danielb /home/danielb/.

# mkdir -p /home/danielb/.config/nvim/tmp/{undo,backup,swap}
