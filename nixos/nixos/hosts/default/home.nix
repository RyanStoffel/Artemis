{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.username = "rstoffel";
  home.homeDirectory = "/home/rstoffel";
  home.stateVersion = "25.05";
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    inputs.self.packages.${pkgs.system}.default
  ];
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Enable Mako notification daemon
  services.mako = {
    enable = true;
    settings = {
      # Basic positioning and size
      anchor = "top-right";
      width = 400;
      height = 150;
      margin = "10";
      padding = "15";

      # Appearance settings
      background-color = "#1e1e2e";
      text-color = "#cdd6f4";
      border-color = "#313244";
      border-radius = 12;
      border-size = 1;

      # Font and text
      font = "Ubuntu Nerd Font 14";

      # Behavior
      default-timeout = 10000; # 10 seconds
      ignore-timeout = false;
      max-visible = 5;

      # Progress bar styling
      progress-color = "#89b4fa";

      # Group notifications by app
      group-by = "app-name";
    };

    # Extra configuration
    extraConfig = ''
      [urgency=low]
      background-color=#1e1e2e
      text-color=#a6adc8
      border-color=#45475a
      default-timeout=5000

      [urgency=normal]
      background-color=#1e1e2e
      text-color=#cdd6f4
      border-color=#313244
      default-timeout=10000

      [urgency=critical]
      background-color=#1e1e2e
      text-color=#f38ba8
      border-color=#f38ba8
      border-size=2
      default-timeout=0

      [app-name="Spotify"]
      background-color=#1e1e2e
      text-color=#a6e3a1
      border-color=#a6e3a1

      [summary~=".*[Bb]attery.*"]
      background-color=#1e1e2e
      text-color=#f9e2af
      border-color=#f9e2af
    '';
  };

  programs.home-manager.enable = true;
}
