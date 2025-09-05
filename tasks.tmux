#!/usr/bin/env bash

# Provide a count of outstanding and urgent tasks using .

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

get_tmux_option() {
  local option_value
  option_value=$(tmux show-option -gqv "$1")

  if [ -z "$option_value" ]; then
    echo "$2"
  else
    echo "$option_value"
  fi
}

update_status() {
  tmux set-option -ga "$1" "${tasks_placeholder_status}"
  tmux set-option -ga "$1"-length 100
}

# Commands
command_taskwarrior_urgent="#($CURRENT_DIR/scripts/taskwarrior_urgent.sh)"
command_taskwarrior_outstanding="#($CURRENT_DIR/scripts/taskwarrior_outstanding.sh)"
command_taskwarrior_overdue="#($CURRENT_DIR/scripts/taskwarrior_overdue.sh)"

# Colors
tasks_format_begin=$(get_tmux_option "@tasks_format_begin" "#[fg=white,bg=colour236]")
tasks_format_end=$(get_tmux_option "@tasks_format_end" "#[fg=default,bg=default]")
tasks_format_overdue=$(get_tmux_option "@tasks_format_overdue" "#[fg=brightred]")
tasks_format_urgent=$(get_tmux_option "@tasks_format_urgent" "#[fg=orange]")
tasks_format_outstanding=$(get_tmux_option "@tasks_format_outstanding" "#[fg=brightblue]")

# Icons
tasks_icon_overdue=$(get_tmux_option "@tasks_icon_outstanding" "!")
tasks_icon_urgent=$(get_tmux_option "@tasks_icon_urgent" "⧗")
tasks_icon_outstanding=$(get_tmux_option "@tasks_icon_outstanding" "+")

tasks_display=$(get_tmux_option "@tasks_display" "status-left")
# Substitution
tasks_data_overdue="$tasks_format_overdue$tasks_icon_overdue$command_taskwarrior_overdue"
tasks_data_urgent="$tasks_format_urgent$tasks_icon_urgent$command_taskwarrior_urgent"
tasks_data_outstanding="$tasks_format_outstanding$tasks_icon_outstanding$command_taskwarrior_outstanding"
tasks_status="$tasks_data_overdue $tasks_data_urgent $tasks_data_outstanding"
tasks_placeholder_status="$tasks_format_begin $tasks_status $tasks_format_end"

update_status "$tasks_display"
