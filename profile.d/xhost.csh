# Export Xauthority for users not for root.

if ($?DISPLAY) then
    if (! $?SSH_TTY) then
	if ( `id -u` >= 14 ) then
		if (! $?XAUTHORITY) then
			setenv XAUTHORITY $HOME/.Xauthority
		endif
	endif
   endif
endif
