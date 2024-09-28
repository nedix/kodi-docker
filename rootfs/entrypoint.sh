#!/usr/bin/env sh

: ${GALLIUM_DRIVER:="llvmpipe"}

adduser -H -D -s /sbin/nologin pulse
addgroup pulse
addgroup pulse-access
addgroup pulse audio
addgroup pulse pulse
addgroup pulse pulse-access
addgroup root pulse-access

echo "secret" | passwd -s root

exec env -i \
    GALLIUM_DRIVER="$GALLIUM_DRIVER" \
    HOME="/root" \
    LIBGL_DEBUG="verbose" \
    LIBSEAT_BACKEND="builtin" \
    S6_CMD_WAIT_FOR_SERVICES_MAXTIME="$(( 60 * 1000 ))" \
    SEATD_VTBOUND="0" \
    XDG_RUNTIME_DIR="$(/usr/bin/mkrundir)" \
    XDG_SESSION_TYPE="x11" \
    /init
