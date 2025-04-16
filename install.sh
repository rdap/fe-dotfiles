#!/bin/bash

# rm -rf .git .gitignore

echo ""
echo "Welcome to the the Fedora-Sway postinstall script."
echo "This installer was written for the Sway spin of Fedora 42."
echo "You shouldn't use this on Fedora Workstation or any other spins."
echo ""
echo "If this is your first boot into your new Fedora-Sway installation,"
echo "you should update via dnf and reboot first before running this script."
echo ""
echo "Will you be using a Macintosh or PC keyboard?"
echo "The default is PC. Valid options are: mac, pc"
read -p "keyboard> " KBDTYPE

echo ""
echo "Okay, will you be using a high DPI screen?"
echo "The default is no. Valid options are: yes, no"
read -p "screen> " SCRTYPE

echo ""
echo "Would you like to install common development tools?"
echo "The default is yes. Valid options are: yes, no"
read -p "editor> " DEVTOOLS

echo ""
echo "Would you like to install a more advanced editor?"
echo "The default is yes. Valid options are: yes, no"
read -p "editor> " ADVEDITOR

# The question of fixing the known media playback issues
# has too obvious of an answer to even need to ask,
# so we will just go ahead and do that automatically:
MEDIAFIX=yes

echo ""
echo "Okay, here we go..."

cp .bashrc ~/.bashrc

rm -rf ~/.config/foot
rm -rf ~/.config/mpv
rm -rf ~/.config/procps
rm -rf ~/.config/sway

cp -r .config/procps ~/.config/
cp -r .config/mpv ~/.config/

mkdir -p ~/.config/foot

mkdir -p ~/.config/sway/config.d
cp -r .config/sway/swaymonad ~/.config/sway/
cp .config/sway/config.d/swaymonad.conf ~/.config/sway/config.d/

if [ "$KBDTYPE" == "mac" ]; then
    cp .config/sway/config.mac ~/.config/sway/config
else
    cp .config/sway/config ~/.config/sway/config
fi

if [ "$SCRTYPE" == "yes" ]; then
    cp .config/foot/foot.ini.hidpi ~/.config/foot/foot.ini
else
    cp .config/foot/foot.ini ~/.config/foot/foot.ini
fi

if [ "$DEVTOOLS" == "no" ]; then
    echo ""
    echo "Skipping development tools installation..."
else
    sudo dnf group install -y c-development development-tools
    sudo dnf install -y autoconf automake cmake git
fi

if [ "$ADVEDITOR" == "no" ]; then
    echo ""
    echo "Skipping advanced editor installation..."
else
    sudo dnf remove -y nano nano-default-editor
    sudo dnf install -y vim-default-editor emacs-nw sbcl rlwrap

    rm -rf ~/.emacs.d
    cp -r .emacs.d ~/.emacs.d

    rm -f ~/.local/bin/lisp
    cp -r .local/bin ~/.local/
fi

if [ "$MEDIAFIX" == "yes" ]; then
    echo ""
    echo "Installing a complete ffmpeg to correct some known issues with Fedora's..."
    sudo dnf swap ffmpeg-free ffmpeg --allowerasing
    sudo dnf install libva-intel-driver
else
    echo ""
    echo "Leaving ffmpeg alone..."
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
