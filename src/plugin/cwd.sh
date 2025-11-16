#!/usr/bin/env bash
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=src/utils.sh
. "$ROOT_DIR/../utils.sh"

# shellcheck disable=SC2005
plugin_cwd_icon=$(get_tmux_option "@theme_plugin_cwd_icon" " ")
plugin_cwd_accent_color=$(get_tmux_option "@theme_plugin_cwd_accent_color" "bg_dark")
plugin_cwd_accent_color_icon=$(get_tmux_option "@theme_plugin_cwd_accent_color_icon" "blue")
plugin_cwd_show_full_path=$(get_tmux_option "@theme_plugin_cwd_show_full_path" "false")

function load_plugin() {
  if [ "$plugin_cwd_show_full_path" = "true" ]; then
    echo "#{pane_current_path}"
  else
    echo "#{b:pane_current_path}"
  fi
}

load_plugin

export plugin_cwd_icon plugin_cwd_accent_color plugin_cwd_accent_color_icon plugin_cwd_show_full_path