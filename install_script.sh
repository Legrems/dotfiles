# Generic
sudo apt install zsh neovim silversearcher-ag fzf nnn vifm thefuck

# SSH Key
ssh-keygen -t ed25519 -C "flamelegrems@gmail.com"

# DotFiles
git clone git@github.com:Legrems/dotfiles.git ~/Documents/dotfiles
mkdir .config/nvim
~/Documents/dotfiles/create_symlinks.sh
ln -s /home/legrems/Documents/dotfiles/vim/colors /home/legrems/.config/nvim/colors
ln -s /home/legrems/.vimrc /home/legrems/.config/nvim/init.vim

# Zprezto
git clone --recursive git@github.com:Legrems/zpresto.git ~/.zprezto

chsh -s /bin/zsh

# MiniConda
wget -O miniconda-latest-install.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
# wget -O miniconda-latest-install.sh https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-pyp3-Linux-aarch64.sh
bash miniconda-latest-install.sh

# MiniForge for Rpi
wget -O

# AutoEnv
git clone git://github.com/inishchith/autoenv.git ~/.autoenv
