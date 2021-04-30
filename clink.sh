#!/bin/bash

config_path=$HOME/.config
nvim_path=$config_path/nvim/init.vim
cp $nvim_path $nvim_path.bkp
cp ./nvim/init.vim $nvim_path 


alacritty_path=$config_path/alacritty/alacritty.yml
cp $alacritty_path $alacritty_path.bkp
cp ./alacritty/alacritty.yml $alacritty_path

xmobar_path=$config_path/xmobar/xmobarrc
cp $xmobar_path $xmobar_path.bkp
cp ./xmobar/xmobarrc $xmobar_path

xmonad_path=$HOME/.xmonad
cp $xmonad_path/xmonad.hs $xmonad_path/xmonad.hs.bkp
cp $xmonad_path/autostart.sh $xmonad_path/autostart.sh.bkp
cp ./xmonad/xmonad.hs $xmonad_path/xmonad.hs
cp ./xmonad/autostart.sh $xmonad_path/autostart.sh

