#!/bin/bash

mkdir -p /home/$USER/src

if [ ! -d /home/$USER/src/dotfiles ]; then
    git clone git@github.com:lukoko/dotfiles.git /home/$USER/src/dotfiles || die_with "$LASTCMD"
    (cd /home/$USER/src/dotfiles && sh install.sh) || die_with "$LASTCMD"
fi

if [ ! -d /home/$USER/src/vim ]; then
    git clone git@github.com:lukoko/vim.git /home/$USER/src/vim || die_with "$LASTCMD"
    (cd /home/$USER/src/vim && sh install.sh) || die_with "$LASTCMD"
fi

if [ ! -d /home/$USER/src/desktop-conf ]; then
    git clone git@github.com:lukoko/desktop-conf.git /home/$USER/src/desktop-conf || die_with "$LASTCMD"
    (cd /home/$USER/src/desktop-conf && sh install.sh) || die_with "$LASTCMD"
fi

if [ ! -x /home/$USER/src/desktop-conf/vendors/fluxbox/fluxbox ]; then
    (cd /home/$USER/src/desktop-conf/vendors/fluxbox && ./autogen.sh && ./configure && make) || die_with "$LASTCMD"
fi
cp /home/$USER/src/desktop-conf/vendors/fluxbox/fluxbox /home/$USER/bin/fluxbox

(cd /home/$USER/src/desktop-conf/vendors/powerline-fonts && sh install.sh) || die_with "$LASTCMD"
if [ ! -x /home/$USER/src/desktop-conf/vendors/st/st ]; then
    (cd /home/$USER/src/desktop-conf/vendors/st &&  make) || die_with "$LASTCMD"
fi
cp /home/$USER/src/desktop-conf/vendors/st/st /home/$USER/bin/st

