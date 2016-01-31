#!/bin/bash
export SRCDIR="$(readlink -m "$( dirname "${BASH_SOURCE[0]}" )" )"
source $SRCDIR/bootstrap-common.sh

USER=vagrant
GROUP=vagrant

if grep 'jessie main contrib' /etc/apt/sources.list > /dev/null ; then
    echo "apt updates are skipped" 1>&2
else
    echo deb http://ftp.debian.org/debian/ jessie main contrib non-free >> /etc/apt/sources.list
    echo deb http://security.debian.org/ jessie/updates main contrib non-free >> /etc/apt/sources.list
    apt-get update -y && apt-get upgrade -y
    apt-get install -y -f
fi

apt-get install -y tree
apt-get install -y git-core
apt-get install -y vim
apt-get install -y irssi
apt-get install -y screen
apt-get install -y python-pip
apt-get install -y tmux
apt-get install -y xorg iceweasel xcompmgr feh
apt-get install -y xorg-dev
apt-get install -y libfribidi0 menu xfonts-terminus
apt-get install -y build-essential automake libtool autoconf pkg-config gettext
apt-get install -y module-assistant linux-headers-$(uname -r) dkms
apt-get install -y virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11
m-a prepare

cp -nr $SRCDIR/home/user/.ssh/id_rsa /home/$USER/.ssh || die_with "$LASTCMD"
cp -nr $SRCDIR/home/user/.ssh/id_rsa.pub /home/$USER/.ssh || die_with "$LASTCMD"
chown -R $USER:$GROUP /home/$USER/.ssh/
chmod 600 /home/$USER/.ssh/id_rsa
chmod 644 /home/$USER/.ssh/id_rsa.pub
rm -f /home/$USER/.ssh/config
sudo -u $USER ln -s $SRCDIR/home/user/.ssh/config /home/$USER/.ssh 2>&1
echo "Auth keys updated succesfully"

sudo -u $USER bash $SRCDIR/bootstrap-user.sh
