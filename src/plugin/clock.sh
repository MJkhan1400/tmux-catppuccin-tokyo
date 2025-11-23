#!/usr/bin/env bash
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=src/utils.sh
. "$ROOT_DIR/../utils.sh"

# shellcheck disable=SC2005
plugin_clock_icon=$(get_tmux_option "@theme_plugin_clock_icon" "")
plugin_clock_accent_color=$(get_tmux_option "@theme_plugin_clock_accent_color" "bg_dark")
plugin_clock_accent_color_icon=$(get_tmux_option "@theme_plugin_clock_accent_color_icon" "blue")

# Default timezone is Dubai
plugin_clock_timezone=$(get_tmux_option "@theme_plugin_clock_timezone" "Asia/Dubai")
plugin_clock_format=$(get_tmux_option "@theme_plugin_clock_format" "%H:%M:%S")

# Store timezone in a temporary file for persistence across tmux sessions
TIMEZONE_CACHE_FILE="/tmp/tmux_clock_timezone_$(tmux display -p '#{session_id}')"

function load_plugin() {
  local current_timezone="$plugin_clock_timezone"
  
  # Check if there's a cached timezone from interactive selection
  if [[ -f "$TIMEZONE_CACHE_FILE" ]]; then
    current_timezone=$(cat "$TIMEZONE_CACHE_FILE")
  fi
  
  # Validate timezone by attempting to use it
  if ! TZ="$current_timezone" date +"%Y" &>/dev/null; then
    # Fallback to Dubai if invalid timezone
    current_timezone="Asia/Dubai"
    echo "$current_timezone" > "$TIMEZONE_CACHE_FILE"
  fi
  
  # Display time in the specified timezone
  TZ="$current_timezone" date +"$plugin_clock_format"
}

function set_timezone() {
  local new_timezone="$1"
  echo "$new_timezone" > "$TIMEZONE_CACHE_FILE"
  tmux display-message "Clock timezone set to: $new_timezone"
}

function show_timezone_menu() {
  local timezones=(
    "Asia/Dubai"
    "America/New_York"
    "America/Los_Angeles"
    "Europe/London"
    "Europe/Paris"
    "Asia/Tokyo"
    "Asia/Shanghai"
    "Australia/Sydney"
    "America/Chicago"
    "Europe/Berlin"
    "Asia/Kolkata"
    "America/Toronto"
    "Asia/Singapore"
    "Europe/Moscow"
    "America/Sao_Paulo"
  )
  
  tmux display-menu -T "Select Timezone" \
    "Dubai" "" "run-shell '$ROOT_DIR/clock.sh set_timezone Asia/Dubai'" \
    "New York" "" "run-shell '$ROOT_DIR/clock.sh set_timezone America/New_York'" \
    "Los Angeles" "" "run-shell '$ROOT_DIR/clock.sh set_timezone America/Los_Angeles'" \
    "London" "" "run-shell '$ROOT_DIR/clock.sh set_timezone Europe/London'" \
    "Paris" "" "run-shell '$ROOT_DIR/clock.sh set_timezone Europe/Paris'" \
    "Tokyo" "" "run-shell '$ROOT_DIR/clock.sh set_timezone Asia/Tokyo'" \
    "Shanghai" "" "run-shell '$ROOT_DIR/clock.sh set_timezone Asia/Shanghai'" \
    "Sydney" "" "run-shell '$ROOT_DIR/clock.sh set_timezone Australia/Sydney'" \
    "Chicago" "" "run-shell '$ROOT_DIR/clock.sh set_timezone America/Chicago'" \
    "Berlin" "" "run-shell '$ROOT_DIR/clock.sh set_timezone Europe/Berlin'" \
    "Kolkata" "" "run-shell '$ROOT_DIR/clock.sh set_timezone Asia/Kolkata'" \
    "Toronto" "" "run-shell '$ROOT_DIR/clock.sh set_timezone America/Toronto'" \
    "Singapore" "" "run-shell '$ROOT_DIR/clock.sh set_timezone Asia/Singapore'" \
    "Moscow" "" "run-shell '$ROOT_DIR/clock.sh set_timezone Europe/Moscow'" \
    "Sao Paulo" "" "run-shell '$ROOT_DIR/clock.sh set_timezone America/Sao_Paulo'"
}

# Handle command line arguments
case "${1:-}" in
  "set_timezone")
    set_timezone "$2"
    exit 0
    ;;
  "menu")
    show_timezone_menu
    exit 0
    ;;
esac

load_plugin

export plugin_clock_icon plugin_clock_accent_color plugin_clock_accent_color_icon