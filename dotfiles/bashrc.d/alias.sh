alias tf="terraform"
alias mouse-left='xinput set-prop $(xinput list --id-only pointer:"Dell Dell KM632 Wireless Keyboard and Mouse") "libinput Left Handed Enabled" 1'
alias ffplay-timestamp='ffplay -vf "drawtext=text='%{pts\:hms}':box=1:x=(w-tw)/2:y=h-(2*lh)"'
alias dual-screen='xrandr --output eDP-1 --mode 1920x1200 --output DP-1 --mode 1920x1080 --right-of eDP-1'
# Use ncal in terminal for better formatting, fall back to standard cal when piped/redirected
if [ -t 1 ] ; then alias cal="ncal -b" ; else alias cal="/usr/bin/cal" ; fi
