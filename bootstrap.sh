#!/bin/bash
echo PROVISION STARTING

SRCDIR="$(readlink -m "$( dirname "${BASH_SOURCE[0]}" )" )"
USER=vagrant
GROUP=vagrant

echo " srcdir=$SRCDIR ; user=$USER ; group=$GROUP"

trap 'LASTCMD=$this_command; this_command=$BASH_COMMAND' DEBUG

function die_with {
    echo "PROVISION FAILED RUNNING: $1" >&2
    exit 1
};

apt-get install -y -f
apt-get install -y tree git-core vim irssi screen python-pip tmux

cp -nr $SRCDIR/home/user/.ssh/id_rsa /home/$USER/.ssh || die_with "$LASTCMD"
cp -nr $SRCDIR/home/user/.ssh/id_rsa.pub /home/$USER/.ssh || die_with "$LASTCMD"
chown -R $USER:$GROUP /home/$USER/.ssh/
chmod 600 /home/$USER/.ssh/id_rsa
chmod 644 /home/$USER/.ssh/id_rsa.pub
rm -f /home/$USER/.ssh/config
sudo -u $USER ln -s $SRCDIR/home/user/.ssh/config /home/$USER/.ssh 2>&1
echo "Auth keys updated succesfully"


echo PROVISION FINISHED
