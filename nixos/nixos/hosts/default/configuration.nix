{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/config/hyprland-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "Artemis";
    # networkmanager.enable = true;  # Comment this out
    wireless.iwd.enable = true;
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  hardware.graphics = {
    enable = true;
  };

  services.xserver.videoDrivers = ["amdgpu"];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "catppuccin-mocha";
    package = pkgs.kdePackages.sddm;
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.rstoffel = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "audio"];
    packages = with pkgs; [
      tree
    ];
    shell = pkgs.fish;
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;

  # Packages & Programs.
  programs.firefox.enable = true;
  programs.chromium = {
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
  programs.fish.enable = true;
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;
  programs.git = {
    enable = true;
    config = {
      user.name = "RyanStoffel";
      user.email = "772612@calbaptist.edu";
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  environment.systemPackages = with pkgs; [
    # Development
    vim
    wget
    kitty
    starship
    zoxide
    eza
    bat
    fastfetch
    stow

    # Applications
    rofi-wayland
    mangohud
    protonup
    prismlauncher
    networkmanagerapplet
    blueberry
    pavucontrol
    hyprpaper
    bibata-cursors
    libnotify
    pipewire
    wireplumber
    nwg-look
    magnetic-catppuccin-gtk
    nautilus
    hyprlock
    (catppuccin-sddm.override
      {
        flavor = "mocha";
        font = "JetBrainsMono Nerd Font";
        fontSize = "11";
        background = "${../../assets/wallpapers/wallpaper1.png}";
        loginBackground = true;
      })
    chromium
    impala
    iwd
    papirus-icon-theme
    hicolor-icon-theme
    adwaita-icon-theme
    btop
  ];

  # Font configuration - make JetBrains Mono the system default
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

  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = {inherit inputs;};
    users = {
      "rstoffel" = import ./home.nix;
    };
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?
}
