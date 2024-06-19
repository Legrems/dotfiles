# Trizen
cd ~

git clone https://aur.archlinux.org/trizen.git
cd trizen
makepkg -si

# Generic
trizen -S neovim zsh fzf nnn vifm thefuck ripgrep zoxide cargo locate

# SSH Key
ssh-keygen -t ed25519 -C "flamelegrems@gmail.com"

# Zprezto
git clone --recursive git@github.com:Legrems/zpresto.git ~/.zprezto
chsh -s /bin/zsh

# DotFiles
git clone git@github.com:Legrems/dotfiles.git ~/Documents/dotfiles --recurse-submodules
mkdir .config/nvim
~/Documents/dotfiles/create_symlinks.sh

ln -s /home/legrems/Documents/dotfiles/neovim /home/legrems/.config/nvim

# Cdwe
cargo install cdwe
cdwe init zsh

source <(fzf --zsh)

# MiniConda
wget -O miniconda-latest-install.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
# wget -O miniconda-latest-install.sh https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-pyp3-Linux-aarch64.sh
bash miniconda-latest-install.sh
