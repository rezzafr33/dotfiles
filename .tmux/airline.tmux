# This tmux statusbar config was created by tmuxline.vim
# on Rab, 02 Mei 2018

set -g @batt_charged_icon "🔋"
set -g status-justify "left"
set -g status "on"
set -g status-attr "none"
set -g message-command-bg "colour61"
set -g status-left-length "100"
set -g pane-active-border-fg "colour141"
set -g status-bg "colour239"
set -g message-command-fg "colour255"
set -g pane-border-fg "colour61"
set -g message-bg "colour61"
set -g status-left-attr "none"
set -g status-right-attr "none"
set -g status-right-length "100"
set -g message-fg "colour255"
setw -g window-status-fg "colour255"
setw -g window-status-attr "none"
setw -g window-status-activity-bg "colour239"
setw -g window-status-activity-attr "none"
setw -g window-status-activity-fg "colour141"
setw -g window-status-separator ""
setw -g window-status-bg "colour239"
set -g status-left "#[fg=colour236,bg=colour141] 💻 #S #[fg=colour141,bg=colour239,nobold,nounderscore,noitalics]"
set -g status-right "#[fg=colour61,bg=colour239,nobold,nounderscore,noitalics]#[fg=colour255,bg=colour61] 🌐 #{download_speed}  #{battery_icon} #{battery_percentage} #{battery_remain}  %Y-%m-%d  %H:%M #[fg=colour141,bg=colour61,nobold,nounderscore,noitalics]#[fg=colour236,bg=colour141] #h "
setw -g window-status-format "#[fg=colour255,bg=colour239] #I #[fg=colour255,bg=colour239] #W "
setw -g window-status-current-format "#[fg=colour239,bg=colour61,nobold,nounderscore,noitalics]#[fg=colour255,bg=colour61] #I #[fg=colour255,bg=colour61] #W #[fg=colour61,bg=colour239,nobold,nounderscore,noitalics]"
