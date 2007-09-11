# Export Xauthority for users not for root.

if [ ! -z "$DISPLAY" -a -z "$SSH_TTY" ];then
	if [ "`id -u`" -gt 14 ];then
		if [ -z $XAUTHORITY ];then
		    export XAUTHORITY=$HOME/.Xauthority
		fi
	fi
fi
