#!/bin/bash
ICON=$HOME/.config/lock.png
TMPBG=/tmp/screen.png
TMPICON=/tmp/icon.png
scrot -o /tmp/screen.png
convert $TMPBG -scale 10% -scale 1000% $TMPBG
convert $ICON  \( +clone   -background navy   -shadow 80x3+3+3 \) +swap \
          -background none   -layers merge +repage $TMPICON
convert $TMPBG $TMPICON -gravity center -composite -matte $TMPBG
i3lock -i $TMPBG --indpos="x+w/2:h-h/6" --line-uses-inside
