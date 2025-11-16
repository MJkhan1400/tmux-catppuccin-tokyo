#!/usr/bin/env bash
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=src/utils.sh
. "$ROOT_DIR/../utils.sh"

# shellcheck disable=SC2005
plugin_host_icon=$(get_tmux_option "@theme_plugin_host_icon" " ")
plugin_host_accent_color=$(get_tmux_option "@theme_plugin_host_accent_color" "bg_dark")
plugin_host_accent_color_icon=$(get_tmux_option "@theme_plugin_host_accent_color_icon" "green")

function load_plugin() {
  echo "#{host}"
}

load_plugin

export plugin_host_icon plugin_host_accent_color plugin_host_accent_color_icon