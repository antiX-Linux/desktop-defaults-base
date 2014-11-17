#----------------------------------------------------------------------
# .xinitrc 
#
# Created by /usr/share/antiX/lib/make-xinitrc
# on 13 April 2013 @ 16:00:25 EDT
# Please add any modifications to .xinitrc-custom and not this file.
# This file will be re-written by update-default-desktop.  The
# DEFAULT_DESKTOP line will be edited by antiX-init if you select
# a desktop via the bootloader menu or a "desktop=xxx" boot parameter.
#----------------------------------------------------------------------

[ -x ~/.xinitrc-custom ] && ~/.xinitrc-custom

[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

DEFAULT_DESKTOP="rox-icewm"

DESKTOP_CODE="$(echo "${1:-$DEFAULT_DESKTOP}" | tr "[A-Z]" "[a-z]")"

sdir=$HOME/.antix-session
display=${DISPLAY%.[0-9]}
mkdir -p $sdir
echo "$DESKTOP_CODE" > $sdir/desktop-code$DISPLAY
echo $$              > $sdir/xinitrc-pid:$display

case "$DESKTOP_CODE" in
    "dwm")
        exec dwm
        ;;
    "rox-fluxbox")
        rox --pinboard=antiX-fluxbox &&
        exec /usr/bin/startfluxbox
        ;;
    "space-fluxbox")
        spacefm --desktop &
        exec /usr/bin/startfluxbox
        ;;
    "fluxbox")
        exec /usr/bin/startfluxbox
        ;;
    "rox-icewm")
        rox --pinboard=antiX-icewm 
        exec /usr/bin/icewm-session
        ;;
    "space-icewm")
        spacefm --desktop &
        exec /usr/bin/icewm-session
        ;;
    "icewm")
        exec /usr/bin/icewm-session
        ;;
    "rox-jwm")
        rox --pinboard=antiX-jwm &&
        exec /usr/bin/jwm
        ;;
    "space-jwm")
        spacefm --desktop &
        exec /usr/bin/jwm
        ;;
    "jwm")
        exec /usr/bin/jwm
        ;;
    "wmii")
        exec wmii
        ;;
    *)
        echo "Unknown DESKTOP_CODE: $DESKTOP_CODE" >&2
        echo "Setting DESKTOP_CODE to rox-icewm" >&2
        DESKTOP_CODE="rox-icewm"
        echo "$DESKTOP_CODE" > $HOME/.antix-session/desktop-code$DISPLAY
        rox --pinboard=antiX-icewm 
        exec /usr/bin/icewm-session
        ;;
esac
