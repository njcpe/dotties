#!/bin/sh


if [[ -f ~/.cache/wal/colors.Xresources ]]; then 
  xrdb -merge ~/.cache/wal/colors.Xresources
elif [[ -f ~/.Xresources ]]; then
  xrdb -merge ~/.Xresources
fi

source ~/.cache/wal/colors.sh
#source ~/.local/bin/dunstWal

[ -f "$HOME/.xprofile" ] && . ~/.xprofile
#dunstWal
export color0_alpha="#22${color0/'#'}"
export color1_alpha="#22${color1/'#'}"
export color2_alpha="#22${color2/'#'}"
export color3_alpha="#22${color3/'#'}"
export color4_alpha="#22${color4/'#'}"
export color5_alpha="#22${color5/'#'}"

exec i3
