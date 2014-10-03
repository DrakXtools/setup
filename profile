# /etc/profile -*- Mode: shell-script -*- 
# (c) MandrakeSoft, Chmouel Boudjnah <chmouel@mandrakesoft.com>

loginsh=1

if [ "$UID" -ge 500 ] ; then
    if ! echo ${PATH} |grep -q /usr/local/games ; then
        PATH=$PATH:/usr/local/games
    fi
    if ! echo ${PATH} |grep -q /usr/games ; then
        PATH=$PATH:/usr/games
    fi
fi

umask 022

USER=`id -un`
LOGNAME=$USER
MAIL="/var/spool/mail/$USER"
HISTCONTROL=ignoredups
HOSTNAME=`/bin/hostname`
HISTSIZE=1000

if [ -z "$INPUTRC" -a ! -f "$HOME/.inputrc" ]; then
    INPUTRC=/etc/inputrc
fi

# some old programs still use it (eg: "man"), and it is also
# required for level1 compliance for LI18NUX2000
NLSPATH=/usr/share/locale/%l/%N

export PATH PS1 USER LOGNAME MAIL HOSTNAME INPUTRC NLSPATH
export HISTCONTROL HISTSIZE 

for i in /etc/profile.d/*.sh ; do
	if [ -r $i ]; then
		. $i
	fi
done

unset i
