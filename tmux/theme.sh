#### COLOUR

tm_icon="♟"
tm_color_active=colour213
tm_color_inactive=colour241
tm_color_feature=colour4
tm_color_music=colour203

# separators
tm_separator_left_bold="◀"
tm_separator_left_thin="❮"
tm_separator_right_bold="▶"
tm_separator_right_thin="❯"

set -g status-left-length 32
set -g status-right-length 150
set -g status-interval 5


# default statusbar colors
# set-option -g status-bg colour0
set-option -g status-fg white
set-option -g status-bg colour235 # default
set-option -g status-attr default

# default window title colors
set-window-option -g window-status-fg white # $tm_color_inactive
set-window-option -g window-status-bg colour235 # default
set -g window-status-format "#I #W"

# active window title colors
set-window-option -g window-status-current-fg black # $tm_color_active
set-window-option -g window-status-current-bg green # default
set-window-option -g  window-status-current-format " #[bold]#I #W "

# pane border
set-option -g pane-border-fg $tm_color_inactive
set-option -g pane-active-border-fg green
set-option -g pane-border-fg colour235
set-option -g pane-border-bg black
set-option -g pane-active-border-bg black

# message text
set-option -g message-bg default
set-option -g message-fg $tm_color_active

# pane number display
# set-option -g display-panes-active-colour $tm_color_active
# set-option -g display-panes-colour $tm_color_inactive

# clock
set-window-option -g clock-mode-colour $tm_color_active

tm_spotify="#[fg=$tm_color_music]#(osascript ~/.dotfiles/applescripts/spotify.scpt)"
tm_itunes="#[fg=$tm_color_music]#(osascript ~/.dotfiles/applescripts/itunes.scpt)"
tm_rdio="#[fg=$tm_color_music]#(osascript ~/.dotfiles/applescripts/rdio.scpt)"
tm_battery="#(~/.dotfiles/bin/battery_indicator.sh)"

tm_date="#[fg=white] %m/%d/%y %I:%M"
tm_host="#[fg=green]#h"
tm_session_name="#[fg=green]$tm_icon #S "

set -g status-left $tm_session_name
set -g status-right $tm_itunes' '$tm_rdio' '$tm_spotify' '$tm_host' '$tm_date
# set -g status-right $tm_itunes' '$tm_rdio' '$tm_spotify' '$tm_date' '$tm_host
