{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop.extra.rofi;
in {
  options.modules.desktop.extra.rofi = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      rofi-systemd

      # TODO: powermenu + screenshot
      # (makeDesktopItem {
      #   name = "lock-display";
      #   desktopName = "Lock screen";
      #   icon = "system-lock-screen";
      #   exec = "${config.dotfiles.binDir}/zzz";
      # })
    ];

    hm.programs.rofi = {
      enable = true;
      plugins = with pkgs; [rofi-emoji];

      extraConfig = {
        terminal = "${getExe pkgs.kitty}";
        disable-history = false;
        show-icons = true;
        sidebar-mode = false;
        sort = true;

        display-drun = "   Run ";
        display-emoji = "  Emoji ";
        display-window = " 﩯  Window ";

        drun-display-format = "{icon} {name}";
        modi = "run,drun,filebrowser,emoji";

        xoffset = 0;
        yoffset = 0;
      };
    };
  };
}
