{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.termEmu;
in {
  options.modules.desktop.termEmu = { default = mkOpt types.str "xterm"; };

  config = {
    services.xserver.desktopManager.xterm.enable =
      mkDefault (cfg.default == "xterm");

    env.TERMINAL = cfg.default;
  };
}