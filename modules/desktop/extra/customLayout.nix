{
  inputs,
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop;
in {
  config = let
    customKeyboardLayout = pkgs.writeText "custom-keyboard-layout" ''
      xkb_keymap {
        xkb_keycodes  { include "evdev+aliases(qwerty)" };
        xkb_types     { include "complete"      };
        xkb_compat    { include "complete"      };

        partial modifier_keys
        xkb_symbols "hyper" {
          include "pc+us+inet(evdev)+terminate(ctrl_alt_bksp)"
          key  <RCTL> { [ Hyper_R, Hyper_R ] };
          modifier_map Mod3 { <HYPR>, Hyper_R };
        };

        xkb_geometry  { include "pc(pc104)"     };
      };
    '';
  in
    mkIf cfg.xmonad.enable {
      homeManager = {
        # Home-Manager (null) -> fixes fuck-up.
        home.keyboard = null;
        xsession.initExtra = ''
          # Set XKB layout = us+hyper on XMonad start:
          ${pkgs.xorg.xkbcomp}/bin/xkbcomp ${customKeyboardLayout} $DISPLAY
        '';
      };
      environment.etc."X11/keymap.xkb".source = customKeyboardLayout;
    };
}
