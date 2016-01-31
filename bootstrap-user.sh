#!/bin/bash
SRCDIR="$(readlink -m "$( dirname "${BASH_SOURCE[0]}" )" )"
source $SRCDIR/bootstrap-common.sh

mkdir -p /home/$USER/src

if [ ! -n "$(grep "^github.com " ~/.ssh/known_hosts)" ]; then
    ssh-keyscan github.com >> ~/.ssh/known_hosts 2>/dev/null;
fi

if [ ! -d /home/$USER/src/dotfiles ]; then
    git clone git@github.com:lukoko/dotfiles.git /home/$USER/src/dotfiles || die_with "$LASTCMD"
    (cd /home/$USER/src/dotfiles && bash install.sh) || die_with "$LASTCMD"
fi

if [ ! -d /home/$USER/src/vim ]; then
    git clone git@github.com:lukoko/vim.git /home/$USER/src/vim || die_with "$LASTCMD"
    (cd /home/$USER/src/vim && bash install.sh) || die_with "$LASTCMD"
fi

if [ ! -d /home/$USER/src/desktop-conf ]; then
    git clone git@github.com:lukoko/desktop-conf.git /home/$USER/src/desktop-conf || die_with "$LASTCMD"
    (cd /home/$USER/src/desktop-conf && bash install.sh) || die_with "$LASTCMD"
fi

if [ ! -x /home/$USER/src/desktop-conf/vendors/fluxbox/fluxbox ]; then
    (cd /home/$USER/src/desktop-conf/vendors/fluxbox && ./autogen.sh && ./configure && make) || die_with "$LASTCMD"
fi
cp /home/$USER/src/desktop-conf/vendors/fluxbox/fluxbox /home/$USER/bin/fluxbox
cp /home/$USER/src/desktop-conf/vendors/fluxbox/fbrun /home/$USER/bin/fbrun
cp /home/$USER/src/desktop-conf/vendors/fluxbox/fbsetroot /home/$USER/bin/fbsetroot
cp /home/$USER/src/desktop-conf/vendors/fluxbox/fluxbox-update_configs /home/$USER/bin/fluxbox-update_configs

(cd /home/$USER/src/desktop-conf/vendors/powerline-fonts && bash install.sh) || die_with "$LASTCMD"

if [ ! -x /home/$USER/src/desktop-conf/vendors/st/st ]; then
    (cd /home/$USER/src/desktop-conf/vendors/st &&  make) || die_with "$LASTCMD"
fi
cp /home/$USER/src/desktop-conf/vendors/st/st /home/$USER/bin/st

echo "User $USER updated."
