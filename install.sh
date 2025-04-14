#!/bin/bash

rm -rf .git .gitignore

echo ""
echo "Welcome to the the Fedora-Sway dotfile installer."
echo "This installer was written for the Sway spin of Fedora 42."
echo "You shouldn't use this on Fedora Workstation or any other spins."
echo ""
echo "If this is your first boot into your new Fedora-Sway installation,"
echo "you should update via dnf and reboot first before running this script."
echo ""
echo "Will you be using a Macintosh or IBM PC layout?"
echo "The default is IBM. Valid options are: ibm, mac"
read -p "keyboard> " KBDTYPE

echo ""
echo "Okay, will you be using a high DPI screen?"
echo "The default is no. Valid options are: yes, no"
read -p "screen> " SCRTYPE

echo ""
echo "Would you like to install a rational emacs?"
echo "The default is yes. Valid options are: yes, no"
read -p "emacs> " EMACS

echo ""
echo "Okay, here we go..."

cp .bashrc ~/.bashrc

rm -rf ~/.config/foot
rm -rf ~/.config/mpv
rm -rf ~/.config/procps
rm -rf ~/.config/sway
cp -r .config/* ~/.config/

if [ "$KBDTYPE" == "mac" ]; then
    cp ~/.config/sway/config.macintosh ~/.config/sway/config
elif [ "$KBDTYPE" == "ibm" ]; then
    cp ~/.config/sway/config.ibm ~/.config/sway/config
else
    cp ~/.config/sway/config.ibm ~/.config/sway/config
fi

if [ "$SCRTYPE" == "yes" ]; then
    cp ~/.config/foot/foot.ini.macintosh ~/.config/foot/foot.ini
else
    cp ~/.config/foot/foot.ini.ibm ~/.config/foot/foot.ini
fi

if [ "$EMACS" == "no" ]; then
    echo ""
    echo "Skipping emacs installation..."
else
    sudo dnf install -y sbcl rlwrap emacs-nw

    rm -rf ~/.emacs.d
    cp -r .emacs.d ~/.emacs.d

    rm -f ~/.local/bin/lisp
    cp -r .local/bin ~/.local/
fi

rm -rf ~/.local/share/fonts
rm -rf ~/.local/share/foot
cp -r .local/share ~/.local/

rm -f ~/.tmux.conf
cp .tmux.conf ~/.tmux.conf

echo ""
echo "Fedora-Sway dotfile installation complete. Enjoy!"
echo ""

exit 0
