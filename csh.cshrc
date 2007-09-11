# /etc/cshrc
#
# csh configuration for all shell invocations. Currently, a prompt.

# (pixel) tcsh doesn't handle directory in the PATH being non-readable
# in security high, /usr/bin is 751, aka non-readable
# using unhash fixes the pb
if (! -r /usr/bin) then
  unhash
endif

if ( $uid == 0 ) limit coredumpsize 1000000

if ($?prompt) then
  if ($?tcsh) then
    set prompt='[%n@%m %c]$ ' 
  else
    set prompt=\[`id -nu`@`hostname -s`\]\$\ 
  endif
endif

test -d /etc/profile.d
if ($status == 0) then
        set nonomatch
        foreach i ( /etc/profile.d/*.csh )
                test -r $i
                if ($status == 0) then
			if ( $shlvl == 1 ) then
				$shell -f $i && source $i || echo "/etc/csh.cshrc: error in $i"
			else
				source $i
			endif
                endif
        end
        unset i nonomatch
endif
