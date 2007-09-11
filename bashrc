# /etc/bashrc

# System wide functions and aliases
# Environment stuff goes in /etc/profile

# by default, we want this to get set.
# Even for non-interactive, non-login shells.
if [ "`id -gn`" = "`id -un`" -a `id -u` -gt 99 ]; then
	umask 002
else
	umask 022
fi

# are we an interactive shell?
if [ "$PS1" ]; then
    case $TERM in
	xterm*)
	    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
	    ;;
	*)
	    ;;
    esac
    [ "$PS1" = "\\s-\\v\\\$ " ] && PS1="[\u@\h \W]\\$ "
    
    if [ -z "$loginsh" ]; then # We're not a login shell
	# Not all scripts in profile.d are compatible with other shells
	# TODO: make the scripts compatible or check the running shell by
	# themselves.
	if [ -n "${BASH_VERSION}${KSH_VERSION}${ZSH_VERSION}" ]; then
            for i in /etc/profile.d/*.sh; do
	        if [ -x $i ]; then
	            . $i
	        fi
	    done
	fi
    fi
fi

unset loginsh
