{ self, inputs,  ... }:

{
    flake.nixosModules.hyprland = { pkgs, upkgs, ... }:
    {
        imports = with self.nixosModules; [ 
            otter-launcher 
            cursors
        ];

        xdg.portal = {
            enable = true;
            extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
        };

        environment.systemPackages = 
        (with upkgs; [
            kitty
        ]) 
        ++
        (with pkgs; [
            brightnessctl
            dunst
            hyprland
            hyprcursor
            awww
            hyprshot 
            hyprshutdown
            quickshell
            rofi
            wf-recorder
        ]); 
      
        programs.hyprland = {
            enable = true;
            xwayland.enable = true;
        };
    };
}
