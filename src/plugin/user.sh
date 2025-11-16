#!/usr/bin/env bash
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=src/utils.sh
. "$ROOT_DIR/../utils.sh"

# shellcheck disable=SC2005
plugin_user_icon=$(get_tmux_option "@theme_plugin_user_icon" " ")
plugin_user_accent_color=$(get_tmux_option "@theme_plugin_user_accent_color" "bg_dark")
plugin_user_accent_color_icon=$(get_tmux_option "@theme_plugin_user_accent_color_icon" "yellow")

function load_plugin() {
  echo "#{user}"
}

load_plugin

export plugin_user_icon plugin_user_accent_color plugin_user_accent_color_icon