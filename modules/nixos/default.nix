{ inputs, config, lib, pkgs, ... }:
{
  # Build NixOS from latest stable release.
  system.stateVersion = "21.05"; # Did you read the comment?

  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod;
 
    kernelParams = [
      "pcie_aspm.policy=performance"
    ];

    kernel.sysctl = {
      "abi.vsyscall" = 0;
    };
    
    # Set GRUB2 to default boot.
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };

      grub = {
        enable = true;
        version = 2;
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
      };
    };

    cleanTmpDir = true;

  };

  networking = {
    # Global useDHCP => deprecated.
    useDHCP = false;

    # Per-interface useDHCP is mandatory. (Not Required by NetworkManager)
    # interfaces = {
    #   enp1s0.useDHCP = true;
    #   wlan0.useDHCP = true;
    # };

    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };

    nat = {
      enable = true;
      externalInterface = "eth0";
      internalInterfaces = [ "wg0" ];
    };

    iproute2 = {
      enable = true;
    };

    firewall = {
      allowedTCPPorts = [ 53 ];
      allowedUDPPorts = [ 53 51820 ];                               # Wireguard
      allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];       # KDE-Connect
      allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];       # KDE-Connect
    };

  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  time.timeZone = "Europe/Stockholm";

  # Recommended for pipewire
  security = {
    rtkit = {
      enable = true;
    };
  };

  hardware = {
    enableRedistributableFirmware = true;

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    pulseaudio = {
      enable = false;
    };

    bluetooth = {
      enable = true;
    };

    openrazer = {
      enable = true;
      devicesOffOnScreensaver = false;
      syncEffectsEnabled = true;
      mouseBatteryNotifier = true;
    };
  };

  documentation = {
    man.enable   = true;
    info.enable  = true;
  };

  programs = {
    fish.enable  = true;
    adb.enable   = true;
    gnupg.agent.enable = true;
  };

  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ 
        "Iosevka"
        "JetBrainsMono"
        ]; 
      })

      source-code-pro
      emacs-all-the-icons-fonts
      liberation_ttf
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji

    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "Cantarell" "Noto Kufi Arabic" ];
        sansSerif = [ "Cantarell" "Noto Kufi Arabic" ];
        monospace = [ "Cantarell" "Noto Kufi Arabic" ];
      };
    };
  };

  systemd.services = {
    systemd-resolved.enable = true;
    systemd-machined.enable = false;
    upower.enable = true;
  };

  services = {
    printing = {
      enable = true;
    };

    xserver = {
      enable = true;
      layout = "us";
      xkbOptions = "eurosign:e";

      libinput = {
        enable = true;
        touchpad = {
          naturalScrolling = true;
          tapping = true;
          disableWhileTyping = true;
        };
      };
    };

    flatpak = {
      enable = true;
    };

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };

      pulse = {
        enable = true;
      };

      # If you want to use JACK applications, uncomment:
      # #jack.enable = true;

      # Bluetooth pipewire settings:
      media-session.config.bluez-monitor.rules = [
        {
          # Matches all cards
          matches = [ { "device.name" = "~bluez_card.*"; } ];
          actions = {
            "update-props" = {
              "bluez5.reconnect-profiles" = [ "hfp_hf" "hsp_hs" "a2dp_sink" ];
              # mSBC is not expected to work on all headset + adapter combinations.
              "bluez5.msbc-support" = true;
            };
          };
        }

        {
          matches = [
            # Matches all sources
            { "node.name" = "~bluez_input.*"; }
            # Matches all outputs
            { "node.name" = "~bluez_output.*"; }
          ];
          actions = {
            "node.pause-on-idle" = false;
          };
        }
      ];
    };
  };

}