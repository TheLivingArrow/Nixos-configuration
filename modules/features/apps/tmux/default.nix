{ inputs, moduleWithSystem, ... }:

{
    flake.nixosModules.tmux = moduleWithSystem ({ pkgs, self', ... }:
    {
        nixpkgs.overlays = [
            (final: prev: {
                tmux = self'.packages.tmux;
            })
        ];       

        environment.systemPackages = with pkgs; [
            tmux
        ];
    });

    perSystem = { upkgs, ... }:
    {
        packages.tmux = inputs.wrappers.wrappers.tmux.wrap 
        {
            pkgs = upkgs;
            package = upkgs.tmux;
            configBefore = ''
                set-option -g status-position top
            '';
            configAfter = ''
                set -g @catppuccin_window_left_separator ""
                set -g @catppuccin_window_right_separator " "
                set -g @catppuccin_window_middle_separator " █"
                set -g @catppuccin_window_number_position "right"
                
                set -g @catppuccin_window_default_fill "number"
                set -g @catppuccin_window_default_text "#W"
                
                set -g @catppuccin_window_current_fill "number"
                set -g @catppuccin_window_current_text "#W"
                
                set -g @catppuccin_status_modules_right "directory user host session"
                set -g @catppuccin_status_left_separator  " "
                set -g @catppuccin_status_right_separator ""
                set -g @catppuccin_status_right_separator_inverse "no"
                set -g @catppuccin_status_fill "icon"
                set -g @catppuccin_status_connect_separator "no"
                
                set -g @catppuccin_directory_text "#{pane_current_path}"
            '';
            modeKeys = "vim";
            plugins = [
                "catppucin/tmux"
                "tmux-plugins/tpm"
            ];
        };   
    };
}

