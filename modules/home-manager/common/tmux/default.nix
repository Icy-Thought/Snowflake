{ config, ... }: {

  programs.tmux = {
    enable = true;
    baseIndex = 1;

    escapeTime = 0;
    keyMode = "vi";
    shortcut = "a";
    terminal = "screen-256color";

    extraConfig = ''
      # Terminal
      set -as terminal-overrides ",*:Tc"
      set -s focus-events on
      set -q -g status-utf8 on
      setw -q -g utf8 on
      set -g history-limit 5000

      # General Configurations
      set -g mouse on
      setw -g mode-keys vi
      set -g status-keys vi
      set -s escape-time 0

      # Display
      set -g base-index 1
      set -g pane-base-index 1
      setw -g automatic-rename on
      set -g renumber-windows on
      set -g set-titles on

      # Activity
      set -g monitor-activity on
      set -g visual-activity off

      # Buffers
      bind b list-buffers                                 # list paste buffers
      bind p paste-buffer                                 # paste from the top paste buffer
      bind P choose-buffer                                # choose which buffer to paste from

      # Split bindings
      bind / split-window -h -c '#{pane_current_path}'    # - for vertical  spliting
      bind - split-window -v -c '#{pane_current_path}'    # / for horizontal spliting
      bind c new-window -c '#{pane_current_path}'         # New window in current path

      # Movement binding
      bind -n M-Left select-pane -L                       # Alt+Left  = Left pane
      bind -n M-Right select-pane -R                      # Alt+Right = Right pane 
      bind -n M-Up select-pane -U                         # Alt+Up    = top pane
      bind -n M-Down select-pane -D                       # Alt+Down  = bottom pane

      # Resize binding
      bind -r h resize-pane -L 2                          # Prefix+h = left resize
      bind -r k resize-pane -U 2                          # Prefix+k = top resize
      bind -r j resize-pane -D 2                          # Prefix+j = bottom resize
      bind -r l resize-pane -R 2                          # Prefix+l = right resize
      set -s escape-time 1                                # Reduce escape time

      # Copy/Paste bindings
      bind P paste-buffer                                 # Vi Copy/Paste
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-selection
      bind-key -T copy-mode-vi r send-keys -X rectangle-toggle

      # Statusline theming
      set -g status 'on'
      set -g status-fg 'colour7'
      set -g status-bg 'colour0'
      set -g status-position 'bottom'
      set -g status-justify 'left'
      set -g status-left-length 50
      set -g status-right-length 100
      music='#[fg=colour8,bg=colour0] #(music-status) '
      batt='#[fg=colour8,bg=colour0] #(battery-charge) '
      date='#[fg=colour7,bg=colour8] %a %d '
      time='#[fg=colour0,bg=colour2] %H:%M '
      hostname='#[fg=colour0,bg=colour2] #h '
      flash='#{?client_prefix,#[fg=colour2]#[bg=colour0],#[fg=colour0]#[bg=colour2]}'
      set -g status-left "$flash #S "
      set -g status-right "$batt$date$time"

      # Windows-related theming
      setw -g window-status-style fg='colour2',bg='colour0'
      setw -g window-status-activity-style fg='colour2',bg='colour0'
      setw -g window-status-separator ' '
      setw -g window-status-format '#[fg=colour7,bg=colour0] #W '
      setw -g window-status-current-format '#[fg=colour7,bg=colour8] #W '
    '';
  };
}
