{
  pkgs,
  inputs,
  ...
}: {
  # ================================
  # IMPORTS
  # ================================
  imports = [
    ./hardware-configuration.nix
    ../../modules/config/hyprland-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  # ================================
  # SYSTEM INFORMATION
  # ================================
  system.stateVersion = "25.05";

  # ================================
  # BOOT CONFIGURATION
  # ================================
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 1; # Faster boot menu timeout
    };

    plymouth = {
      enable = true;
      theme = "breeze";
    };

    # Boot optimizations
    initrd.systemd.enable = true;
    kernelModules = ["amdgpu"]; # Preload AMD GPU modules
    kernelParams = [
      "amdgpu.dc=1"
      "8250.nr_uarts=0" # Disable serial ports to save 7+ seconds
      "udev.log_level=3" # Reduce udev logging overhead
      "quiet" # Reduce boot message overhead
    ];
  };

  # ================================
  # LOCALIZATION & TIME
  # ================================
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";

  # ================================
  # NETWORKING
  # ================================
  networking = {
    hostName = "Artemis";
    dhcpcd.enable = false; # Disable slow dhcpcd
    useNetworkd = true; # Use fast systemd-networkd
    wireless.iwd.enable = true;
  };

  # Fast systemd-networkd configuration
  systemd.network = {
    enable = true;
    networks = {
      "20-wired" = {
        matchConfig.Name = "en*";
        networkConfig = {
          DHCP = "ipv4";
          IPv4Forwarding = false;
        };
        dhcpV4Config.RouteMetric = 1024;
      };
      "25-wireless" = {
        matchConfig.Name = "wl*";
        networkConfig = {
          DHCP = "ipv4";
          IPv4Forwarding = false;
        };
        dhcpV4Config.RouteMetric = 1025;
      };
    };
  };

  services.resolved.enable = true;

  # ================================
  # HARDWARE CONFIGURATION
  # ================================
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    graphics.enable = true;
  };

  # ================================
  # GRAPHICS & DISPLAY
  # ================================
  services.xserver.videoDrivers = ["amdgpu"];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "catppuccin-mocha";
    package = pkgs.kdePackages.sddm;
  };

  # ================================
  # AUDIO
  # ================================
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  # ================================
  # USER CONFIGURATION
  # ================================
  users.users.rstoffel = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "audio"];
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };

  # ================================
  # NIX CONFIGURATION
  # ================================
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };

  # ================================
  # PROGRAMS & APPLICATIONS
  # ================================
  programs = {
    # Browsers
    firefox.enable = true;
    chromium = {
      enable = true;
      extraOpts = {
        "default_search_provider.enabled" = true;
        "default_search_provider.name" = "Kagi";
        "default_search_provider.search_url" = "https://kagi.com/search?q={searchTerms}";
        "default_search_provider.keyword" = "kagi.com";
        "default_search_provider.replace_search_url_in_history" = true;
        "default_search_provider.id" = 1;
      };
    };

    # Shell & Development
    zsh.enable = true;
    fish.enable = true;
    bash.blesh.enable = true;
    git = {
      enable = true;
      config = {
        user.name = "RyanStoffel";
        user.email = "772612@calbaptist.edu";
        init.defaultBranch = "main";
        pull.rebase = true;
      };
    };

    # Gaming
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    gamemode.enable = true;
  };

  # ================================
  # SYSTEM PACKAGES
  # ================================
  environment.systemPackages = with pkgs; [
    # === Development Tools ===
    vim
    wget
    kitty
    starship
    zoxide
    eza
    bat
    fastfetch
    stow
    lazygit
    alacritty
    postman
    vscode
    zed-editor
    blesh
    nix-bash-completions

    # === Desktop Environment ===
    rofi-wayland
    networkmanagerapplet
    blueberry
    pavucontrol
    hyprpaper
    hyprlock
    nwg-look
    nautilus
    swayosd
    spotify
    slack
    _1password-gui-beta
    obsidian
    obs-studio
    vlc
    hyprshot
    grim
    slurp

    # === Themes & Appearance ===
    bibata-cursors
    magnetic-catppuccin-gtk
    papirus-icon-theme
    hicolor-icon-theme
    adwaita-icon-theme
    (catppuccin-sddm.override {
      flavor = "mocha";
      font = "JetBrainsMono Nerd Font";
      fontSize = "11";
      background = "${../../assets/wallpapers/catppuccin-mocha.png}";
      loginBackground = true;
    })

    # === Gaming ===
    mangohud
    protonup
    prismlauncher

    # === System Utilities ===
    libnotify
    pipewire
    wireplumber
    chromium
    impala
    iwd
    btop
    wl-clipboard
    libqalculate
    fd
  ];

  # ================================
  # FONTS
  # ================================
  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = ["JetBrainsMono Nerd Font"];
        sansSerif = ["JetBrainsMono Nerd Font"];
        monospace = ["JetBrainsMono Nerd Font"];
      };
    };
  };

  # ================================
  # ENVIRONMENT VARIABLES
  # ================================
  environment.variables = {
    EDITOR = "nvim";
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
    MOZ_ENABLE_WAYLAND = "1";
    PULSE_RUNTIME_PATH = "/run/user/1000/pulse";
  };

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATH = "/home/rstoffel/.steam/root/compatibilitytools.d";
  };

  # ================================
  # SYSTEM SERVICES & OPTIMIZATION
  # ================================
  services = {
    openssh.enable = true;
  };

  # Journal optimization (reduce the 2.2s journal flush time)
  services.journald.extraConfig = ''
    SystemMaxUse=100M
    SystemMaxFileSize=10M
    ForwardToSyslog=no
    ForwardToKMsg=no
    ForwardToConsole=no
  '';

  # Systemd optimizations
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
    DefaultTimeoutStartSec=10s
  '';

  # ================================
  # HOME MANAGER
  # ================================
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "rstoffel" = import ./home.nix;
    };
  };
}
