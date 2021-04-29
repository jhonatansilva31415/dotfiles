#!/bin/bash

config_path=$HOME/.config
nvim_path=$config_path/nvim/init.vim
cp ./nvim/init.vim $nvim_path 

alacritty_path=$config_path/alacritty/alacritty.yml
cp ./alacritty/alacritty.yml $alacritty_path

xmobar_path=$config_path/xmobar/xmobarrc
cp ./xmobar/xmobarrc $xmobar_path

xmonad_path=$HOME/.xmonad
cp ./xmonad/xmonad.hs $xmonad_path/xmonad.hs
cp ./xmonad/autostart.sh $xmonad_path/autostart.sh

