# /etc/csh.login

# System wide environment and startup programs for csh users


if ( ! $?PATH ) then
	setenv PATH "/bin:/usr/bin:/usr/local/bin"
endif

# (pixel) tcsh doesn't handle directory in the PATH being non-readable
# in security high, /usr/bin is 751, aka non-readable
# using unhash *after modifying PATH* fixes the pb
if (! -r /usr/bin) then
  unhash
endif

limit coredumpsize unlimited

if ( $user == $group && $uid > 14 ) then
	umask 022
else
	umask 002
endif

setenv HOSTNAME `/bin/hostname`
set history=1000

if ( -f $HOME/.inputrc ) then
	setenv INPUTRC /etc/inputrc
endif

if ( $?tcsh ) then
	bindkey "^[[3~" delete-char
endif
