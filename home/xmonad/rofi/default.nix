{ config, pkgs, ... }: {

  services.picom.enable = true;

  programs.rofi = {
    enable = true;
    plugins = with pkgs; [ rofi-emoji rofi-calc ];

    extraConfig = {
      font = "Noto Sans Bold 10";
      show-icons = true;
      icon-theme = "Whitesur-dark";
      display-drun = "";
      drun-display-format = "{name}";
      disable-history = false;
      fullscreen = false;
      hide-scrollbar = true;
      sidebar-mode = false;
    };

    theme = {
      "*" = {
        background = "#00000000";
        background-alt = "#00000000";
        background-bar = "#f2f2f215";
        foreground = "#f2f2f2EE";
        accent = "#3DAEE966";
      };

      "window" = {
        transparency = "real";
        background-color = "@background";
        text-color = "@foreground";
        border = "0px";
        border-color = "@border";
        border-radius = "0px";
        width = "40%";
        location = "center";
        x-offset = 0;
        y-offset = 0;
      };

      "prompt" = {
        enabled = true;
        padding = "0.30% 1% 0% -0.5%";
        background-color = "@background-alt";
        text-color = "@foreground";
        font = "FantasqueSansMono Nerd Font 12";
      };

      "entry" = {
        background-color = "@background-alt";
        text-color = "@foreground";
        placeholder-color = "@foreground";
        expand = true;
        horizontal-align = 0;
        placeholder = "Search";
        padding = "0.10% 0% 0% 0%";
        blink = true;
      };

      "inputbar" = {
        children = [ "prompt" "entry" ];
        background-color = "@background-bar";
        text-color = "@foreground";
        expand = false;
        border = "0% 0% 0% 0%";
        border-radius = "12px";
        border-color = "@accent";
        margin = "0% 0% 0% 0%";
        padding = "1.5%";
      };

      "listview" = {
        background-color = "@background-alt";
        columns = 5;
        lines = 3;
        spacing = "0%";
        cycle = false;
        dynamic = true;
        layout = "vertical";
      };

      "mainbox" = {
        background-color = "@background-alt";
        border = "0% 0% 0% 0%";
        border-radius = "0% 0% 0% 0%";
        border-color = "@accent";
        children = [ "inputbar" "listview" ];
        spacing = "2%";
        padding = "2% 1% 2% 1%";
      };

      "element" = {
        background-color = "@background-alt";
        text-color = "@foreground";
        orientation = "ertical";
        border-radius = "%";
        padding = "% 0% 2% 0%";
      };

      "element-icon" = {
        size = "64px";
        border = "0px";
      };

      "element-text" = {
        expand = true;
        horizontal-align = "0.5";
        vertical-align = "0.5";
        margin = "0.5% 0.5% -0.5% 0.5%";
      };

      "element selected" = {
        background-color = "@background-bar";
        text-color = "@foreground";
        border = "0% 0% 0% 0%";
        border-radius = "12px";
        border-color = "@accent";
      };
    };
  };

}
