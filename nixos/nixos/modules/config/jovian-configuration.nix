{
  pkgs,
  lib,
  ...
}: {
  # ================================
  # JOVIAN NIXOS CONFIGURATION
  # ================================
  jovian = {
    # Enable Steam gaming experience
    steam = {
      enable = true;
      autoStart = false; # Don't auto-start on boot
      user = "rstoffel";
    };

    # Decky Loader for Steam Deck plugins (optional)
    decky-loader.enable = false; # Disable for now
  };

  # ================================
  # GAMING PACKAGES AND SCRIPTS (NO GAMESCOPE CONFIG)
  # ================================

  environment.systemPackages = with pkgs; [
    # Gaming mode launcher script
    (pkgs.writeShellScriptBin "launch-gaming-mode" ''
      #!/usr/bin/env bash
      set -e

      echo "Starting Gaming Mode..."

      # Set environment variables for Gamescope
      export DISPLAY=:0
      export WAYLAND_DISPLAY=wayland-0
      export WLR_NO_HARDWARE_CURSORS=1

      # Kill existing Steam processes
      pkill -f steam || true
      sleep 1

      # Launch Gamescope with Steam Big Picture
      exec gamescope \
        --output-width 3440 \
        --output-height 1440 \
        --nested-width 1920 \
        --nested-height 1080 \
        --borderless \
        --rt \
        --expose-wayland \
        -- steam -gamepadui
    '')

    # Desktop mode launcher script
    (pkgs.writeShellScriptBin "launch-desktop-mode" ''
      #!/usr/bin/env bash

      echo "Returning to Desktop Mode..."

      # Stop any running Gamescope sessions
      pkill -f gamescope || true
      pkill -f steam || true
      sleep 2

      # Start Hyprland if not running
      if ! pgrep Hyprland; then
        echo "Starting Hyprland..."
        exec Hyprland
      else
        echo "Hyprland already running"
      fi
    '')

    # Environment switcher with rofi
    (pkgs.writeShellScriptBin "switch-environment" ''
      #!/usr/bin/env bash

      choice=$(printf "Gaming Mode\\nDesktop Mode\\nQuit" | rofi -dmenu -p "Choose Environment:")

      case "$choice" in
        "Gaming Mode")
          launch-gaming-mode &
          ;;
        "Desktop Mode")
          launch-desktop-mode &
          ;;
        "Quit")
          exit 0
          ;;
        *)
          exit 1
          ;;
      esac
    '')

    # Simple Steam Big Picture launcher
    (pkgs.writeShellScriptBin "steam-gamepad" ''
      #!/usr/bin/env bash
      steam -gamepadui
    '')

    # Test Gamescope launcher
    (pkgs.writeShellScriptBin "test-gamescope" ''
      #!/usr/bin/env bash
      echo "Testing Gamescope in windowed mode..."

      export WLR_NO_HARDWARE_CURSORS=1
      export DISPLAY=:0

      gamescope \
        --nested-width 1280 \
        --nested-height 720 \
        --borderless \
        --expose-wayland \
        -- steam -gamepadui
    '')

    # Game launchers and tools
    lutris
    bottles
    heroic

    # Gaming utilities (gamescope will be provided by NixOS built-in config)
    gamemode

    # Controller tools
    antimicrox # Controller mapping
    jstest-gtk # Controller testing

    # Performance monitoring
    mangohud
    radeontop # AMD GPU monitoring

    # Steam tools
    steamcmd
    steam-run
  ];

  # ================================
  # UDEV RULES FOR CONTROLLERS
  # ================================
  services.udev.packages = with pkgs; [
    game-devices-udev-rules
  ];

  # ================================
  # USER GROUPS
  # ================================
  users.users.rstoffel.extraGroups = ["input" "gamemode"];
}
