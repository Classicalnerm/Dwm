#!/bin/dash

interval=1

# load colors
. ~/.config/dwm//scripts/bar_themes/catppuccin

cpu() {
  cpu_val=$(grep -o "^[^ ]*" /proc/loadavg)

  printf "^c$black^ ^b$green^ 󰍛 "
  printf "^c$white^ ^b$grey^ %s ^b$black^" "$cpu_val"
}

brightness() {
  printf "^c$red^   "
  printf "^c$red^%.0f\n" "$(cat /sys/class/backlight/*/brightness)"
}

wlan() {
  case "$(cat /sys/class/net/wl*/operstate 2>/dev/null)" in
  up) printf "^c$black^ ^b$blue^ 󰤨 Connected" ;;
  down) printf "^c$black^ ^b$blue^ 󰤭 Disconnected" ;;
  esac
}

clock() {
  day=$(date +%-d)

  case "$day" in
  1 | 21 | 31) suffix="st" ;;
  2 | 22) suffix="nd" ;;
  3 | 23) suffix="rd" ;;
  *) suffix="th" ;;
  esac

  printf "^c$black^ ^b$darkblue^ 󱑆 "
  printf "^c$black^^b$blue^ %s  " "$(date '+%B ')${day}${suffix} $(date '+%I:%M %p')"
}
while true; do
  status="           $(wlan)   $(clock)"
  xsetroot -name "$status"
  sleep 1
done
