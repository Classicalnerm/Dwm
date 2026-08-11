#!/bin/sh

# ------------------------
# Runtime directory (safe fallback)
# ------------------------
export XDG_RUNTIME_DIR="/tmp/runtime-$USER"
mkdir -p "$XDG_RUNTIME_DIR"
chmod 700 "$XDG_RUNTIME_DIR"

# ------------------------
# Session environment
# ------------------------
export XDG_SESSION_TYPE=x11
export XDG_CURRENT_DESKTOP=ChadWM
export XDG_SESSION_DESKTOP=ChadWM

# ------------------------
# Audio
# ------------------------
pulseaudio --start &

# ------------------------
# Display setup
# ------------------------
xrandr \
  --output HDMI-0 --mode 1920x1080 --rate 100 --left-of DP-0 \
  --output DP-0 --primary --mode 1920x1080 --rate 239.96

# ------------------------
# Power saving off
# ------------------------
xset s off
xset s noblank
xset -dpms

# ------------------------
# X resources
# ------------------------
xrdb -merge ~/.Xresources

# ------------------------
# Desktop tweaks
# ------------------------
xbacklight -set 10 &
feh --bg-fill ~/norm/Downloads/wallpaper1.png &
xset r rate 200 50 &
picom &

# ------------------------
# Bar
# ------------------------
/home/norm/.config/dwm/scripts/bar.sh &

# ------------------------
# Start WM (IMPORTANT FIX)
# ------------------------

exec dbus-run-session chadwm
