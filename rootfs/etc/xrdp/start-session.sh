#!/usr/bin/env sh

set -x

while IFS= read -r ENV_VAR; do
    ENV_KEY="${ENV_VAR%%=*}"
    test -z "${!ENV_KEY}" && export "$ENV_VAR"
done < <(/command/s6-envdir /run/s6/container_environment /usr/bin/env)

export XDG_RUNTIME_DIR="$(/usr/local/bin/mkrundir)"

/usr/bin/env

touch ~/.Xauthority

/usr/bin/xauth add "$DISPLAY" . $(xxd -l 16 -p /dev/urandom)

/usr/libexec/pulseaudio-module-xrdp/load_pa_modules.sh

#/usr/bin/vglrun +glx /usr/bin/glxinfo -B
#
#/usr/bin/vglrun +glx /usr/bin/eglinfo -B
#
#/usr/bin/vglrun +glx /usr/bin/vulkaninfo --summary

/usr/bin/kodi --standalone --windowing=x11 --gl-interface=glx

cat /home/kodi/.kodi/temp/kodi.log
cat /home/kodi/.xorgxrdp.1.log
