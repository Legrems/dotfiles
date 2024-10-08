#!/bin/bash

############################
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
# Src: https://github.com/michaeljsmalley/dotfiles/blob/master/makesymlinks.sh
############################

########## Variables

dir=/home/legrems/Documents/dotfiles # dotfiles directory
olddir=~/dotfiles_old # old dotfiles backup directory

files="vim zsh zshrc tmux.conf zpreztorc gitconfig gitignore_global Xresources xprofile zprofile xinitrc" # list of files/folders to symlink in homedir

configdirs="i3 keepassxc nvim rofi trizen polybar"


##########
# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
  mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
  cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do

  echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/

  echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

# move any existing dotdirs in ~/.config to dotfiles_old directory, then create symlinks from the homedir to any files in the config directory specified in $configdirs
for configdir in $configdirs; do

    echo "Moving any existing config dir from ~/.config to $olddir"
      mv ~/.config/$configdir ~/dotfiles_old/ -f

    echo "Creating symlink to $configdir in ~/.config directory."
      ln -s $dir/config/$configdir ~/.config/$configdir
done

# Copy particular stuff

## Prezto
echo -n "Creating folder for prezto "
  mkdir -p "~/.zprezto/modules/prompt/functions/"
echo "done"

echo "Moving existing prompt_sorin_setup into $oldir"
  mv "~/.zprezto/modules/prompt/functions/prompt_sorin_setup" "$olddir/prompt_sorin_setup"

echo -n "Creating symlink to prompt_sorin_setup file"
  ln -s $dir/prompt_sorin_setup ~/.zprezto/modules/prompt/functions/prompt_sorin_setup
echo "done"

## Vifm
echo "Creating folder for vifm"
  mkdir -p "~/.config/vifm/"

echo "Moving existing vifmrc file into $olddir"
  mv "~/.config/vifm/vifmrc" "$olddir/vifmrc"

echo -n "Creating symlink to vifmrc file"
  ln -s $dir/vifmrc ~/.config/vifm/vifmrc
echo "done"
