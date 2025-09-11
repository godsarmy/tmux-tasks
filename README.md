# Tmux Tasks

This `tmux` plugin shows a simple count of your overdue, urgent and non-urgent
tasks.

![docker status](example.png)


## Requirements

Your terminal emulator must be configured to use that font, usually "Hack Nerd Font"

## Usage

Add `#{tasks_status}` to your `status-left` or `status-right`:

```
set -g status-right '#{tasks_status} %a %Y-%m-%d %H:%M'
```


## Installation

1. Install [Tmux Plugin Manager][tpm].

2. Add this plugin to your `~/.tmux.conf`:

```
set -g @plugin 'godsarmy/tmux-tasks'
```

3. Press [prefix] + `I` to install.


## Configuration

1. General

The following configuration variables can be set in your `~/.tmux.conf` (shown
here with their default values):

```
# Task manager
set -g @tasks_manager 'taskwarrior'

# Colors
set -g @tasks_format_begin '#[fg=white,bg=colour236]'
set -g @tasks_format_end '#[fg=white,bg=black]'

# Font Colors
set -g @tasks_format_overdue '#[fg=brightred]'
set -g @tasks_format_urgent '#[fg=orange]'
set -g @tasks_format_outstanding '#[fg=brightblue]'

# Icons
set -g tasks_icon_overdue ' '
set -g tasks_icon_urgent '󰄉 '
set -g tasks_icon_outstanding ' '
set -g tasks_icon_project '⚙ '
```

2. Project (Optional)

Use `@tasks_projects` to display the tasks count in particular projects.

```
# List tasks in each projects available
set -g @tasks_projects '*'
```

```
# List task only in project ProjA and ProjB
set -g @tasks_projects 'ProjA ProjB'
```

## Supported task managers

Currently, [TaskWarrior][task] is the only supported task manager. Suggestions
for additional task managers to support is welcome.


[tpm]: https://github.com/tmux-plugins/tpm
[task]: https://taskwarrior.org
