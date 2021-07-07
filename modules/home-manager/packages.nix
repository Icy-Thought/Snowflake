{ config, lib, pkgs, inputs, ... }:

let
  defaultPkgs = with pkgs; [
    wl-clipboard # Wayland c-p/c-v.
    zathura # Minimal Document Reader.
    latest.firefox-nightly-bin # Latest Firefox Browser.
    brave # Chromium-based browser.
    # Polychromatic                                 # GUI to control OpenRazer.
    anki # Spaced repetition flashcard.
    celluloid # GTK frontend for MPV.
    gimp # Better Photoshop alternative.
    inkscape # Better Illustrator alternative.
    # blender                                         # 3D Creation/Animation.
    libreoffice # Better office alternative suit.
    obs-studio # Streaming/Recording.
    qalculate-gtk # Scientific calculator.
    discord # Latest Discord client.
    tdesktop # Telegram Desktop.
    signal-desktop # More secure WA alternative.
    element-desktop # Matrix client by Element.
    easytag # M3U Editor.
    transmission-gtk # BitTorrent Client.
    freetube # FOSS private YT app.
    glade # UI GTK designer.
    cawbird # GTK Twitter client.
    foliate # Minimal E-Book reader.
    zoom-us # Conferencing application..
    heimdall-gui # Suit to flash Android firmware.
    gsmartcontrol # HDD health inspection tool.
  ];

  gitPkgs = with pkgs.gitAndTools; [
    diff-so-fancy # Colored git diff.
    git-crypt # git file encryption.
    tig # diff and commit view.
  ];

  editorPkgs = with pkgs; [
    gnuplot # Plotting through programming.
    tmux # Terminal multiplexer.
  ];

  devPkgs = with pkgs; [
    rust-bin.nightly.latest.default # Latest Rust compiler.
    rust-analyzer # Rust completion.
    sumneko-lua-language-server # Lua language server.
    gcc11 # GNU Compiler Collection.
    ccls # C/C++ language server - Clang.
    gnumake # Control exec. files.
    cmake # Auto Testing & packaging.
    nodejs-16_x # I/O framwork for JS v8.
    languagetool # Proofreading.
    openssl # SSL and TLS protocols.
    sqlite # Serverless SQL database.
    jq # Lightweight JSON processor.
    xsv # Fast CSV toolkit (Rust).
    python39 # Py-lang.
    pipenv # Py-dev workflow for humans.
    graphviz # Graph visualization.
    tectonic # LaTeX support.
    hugo # Modern static web-engine.
  ];

  lanservPkgs = with pkgs.nodePackages; [
    # javascript-typescript-langserver                # JavaScript/TypeScript.
    pyright # Python.
    typescript-language-server # TypeScript.
    bash-language-server # Bash.
  ];

  pyPkgs = with pkgs.python39Packages; [
    black # Python code formatter.
    isort # Sort Py-imports.
    pyflakes # Py-error check.
    nose-timer # Nosetests timer.
    nose-exclude # Exclude dirs from nosetests.
    pytest # Py-test framework.
  ];

  spellPkgs = with pkgs; [
    aspell # Spelling support.
    aspellDicts.en # en_US aspell.
    aspellDicts.sv # sv_SE aspell.
    hunspellDicts.sv_SE # sv_SE hunspell.
    hunspellDicts.en_US # en_US hunspell.
  ];

  nixPkgs = with pkgs; [
    any-nix-shell # Fish/ZSH support.
    nix-direnv # Fast nix-impl of direnv.
    hydra-check # Hydra build status check.
    nix-prefetch-github # Prefetch from GH.
    nixpkgs-review # Review nixpkgs PR.
    nix-top # Tracks nix builds.
    nixfmt # Nix code formatter.
    nixpkgs-fmt # [...] -> for nixpkgs.
    lorri # Project's nix-env.
  ];

  utilsPkgs = with pkgs; [
    # uutils-coreutils                              # Rust GNU-coreutils alt.
    wget # TUI Downloader.
    unzip # Unzipping files.
    ffmpeg # Files & streams management.
    dconf2nix # Nixify your dconf-settings.
    pwgen # Password generator.
    imagemagick # LaTeX image export.
    winetricks # Required DLL for exe trouble.
    tree-sitter # Generator + incremental parse.
    ncdu # Dis analyzer (NCurses).
  ];

  tuiPkgs = with pkgs; [
    starship # Minimal + customizable prompt.
    nnn # TUI file manager.
    glances # Curses-based monitoring tool.
    neofetch # Fetch system information.
    youtube-dl # YouTube media downloader.
    # spotify-tui # TUI for premium Spotify users.
    # speedtest-cli # TUI Speedtest.
  ];

  gamingPkgs = with pkgs; [
    wine-staging # Latest Wine package.
    lutris # WINE gaming platform.
    osu-lazer # FOSS Rythm game!
  ];

in {
  home.packages = builtins.concatLists [
    defaultPkgs
    gitPkgs
    editorPkgs
    devPkgs
    lanservPkgs
    pyPkgs
    spellPkgs
    nixPkgs
    utilsPkgs
    tuiPkgs
    gamingPkgs
  ];

}
