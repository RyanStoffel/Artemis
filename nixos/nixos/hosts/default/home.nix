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

  # Enable SwayNC (Sway Notification Center) - using the correct option name
  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      control-center-layer = "top";
      layer-shell = true;
      cssPriority = "application";
      control-center-margin-top = 0;
      control-center-margin-bottom = 0;
      control-center-margin-right = 0;
      control-center-margin-left = 0;
      notification-2fa-action = true;
      notification-inline-replies = false;
      notification-icon-size = 64;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      timeout = 10;
      timeout-low = 5;
      timeout-critical = 0;
      fit-to-screen = true;
      control-center-width = 500;
      control-center-height = 600;
      notification-window-width = 500;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 200;
      hide-on-clear = false;
      hide-on-action = true;
      script-fail-notify = true;
    };

    style = ''
      /* Import Catppuccin colors - you may need to define these */
      @define-color base   #1e1e2e;
      @define-color mantle #181825;
      @define-color crust  #11111b;
      @define-color text     #cdd6f4;
      @define-color subtext0 #a6adc8;
      @define-color subtext1 #bac2de;
      @define-color surface0 #313244;
      @define-color surface1 #45475a;
      @define-color surface2 #585b70;
      @define-color overlay0 #6c7086;
      @define-color overlay1 #7f849c;
      @define-color overlay2 #9399b2;
      @define-color blue      #89b4fa;
      @define-color lavender  #b4befe;
      @define-color sapphire  #74c7ec;
      @define-color sky       #89dceb;
      @define-color teal      #94e2d5;
      @define-color green     #a6e3a1;
      @define-color yellow    #f9e2af;
      @define-color peach     #fab387;
      @define-color maroon    #eba0ac;
      @define-color red       #f38ba8;
      @define-color mauve     #cba6f7;
      @define-color pink      #f5c2e7;
      @define-color flamingo  #f2cdcd;
      @define-color rosewater #f5e0dc;

      .notification-row {
        outline: none;
      }

      .notification-row:focus,
      .notification-row:hover {
        background: @surface0;
      }

      .notification {
        border-radius: 12px;
        margin: 6px 12px;
        box-shadow: 0 0 0 1px rgba(0, 0, 0, 0.3), 0 1px 3px 1px rgba(0, 0, 0, 0.7),
          0 2px 6px 2px rgba(0, 0, 0, 0.2);
        padding: 0;
      }

      .notification-content {
        background: transparent;
        padding: 6px;
        border-radius: 12px;
      }

      .close-button {
        background: @red;
        color: @crust;
        text-shadow: none;
        padding: 0;
        border-radius: 100%;
        margin-top: 10px;
        margin-right: 16px;
        box-shadow: none;
        border: none;
        min-width: 24px;
        min-height: 24px;
      }

      .close-button:hover {
        box-shadow: none;
        background: @maroon;
        transition: all 0.15s ease-in-out;
        border: none;
      }

      .notification-default-action,
      .notification-default-action:hover {
        padding: 6px;
        margin: 0;
        box-shadow: none;
        background: @base;
        border: 1px solid @surface0;
        color: @text;
        transition: all 0.15s ease-in-out;
      }

      .notification-default-action:hover {
        -gtk-icon-effect: none;
        background: @surface0;
      }

      .notification-default-action .notification-content {
        background: transparent;
        color: @text;
        text-shadow: none;
        padding: 6px;
        border-radius: 12px;
      }

      .low {
        background: @surface0;
        padding: 6px;
        border-radius: 12px;
      }

      .normal {
        background: @surface0;
        padding: 6px;
        border-radius: 12px;
      }

      .critical {
        background: @red;
        padding: 6px;
        border-radius: 12px;
      }

      .control-center {
        background: @base;
        border: 1px solid @surface0;
        border-radius: 12px;
      }

      .control-center-list {
        background: transparent;
      }

      .control-center-list-placeholder {
        opacity: 0.5;
      }

      .floating-notifications {
        background: transparent;
      }

      .blank-window {
        background: alpha(black, 0.25);
      }

      .widget-title {
        color: @text;
        background: @surface0;
        padding: 5px 10px;
        border-radius: 12px;
      }

      .widget-title > button {
        font-size: 16px;
        color: @text;
        text-shadow: none;
        background: @surface0;
        border: 1px solid @surface1;
        border-radius: 12px;
        box-shadow: none;
      }

      .widget-title > button:hover {
        background: @surface1;
      }

      .widget-dnd {
        background: @surface0;
        padding: 5px 10px;
        border-radius: 12px;
        color: @text;
      }

      .widget-dnd > switch {
        border-radius: 12px;
        background: @surface1;
      }

      .widget-dnd > switch:checked {
        background: @mauve;
      }

      .widget-dnd > switch slider {
        background: @text;
        border-radius: 12px;
      }

      .widget-dnd > switch:checked slider {
        background: @crust;
      }
    '';
  };

  programs.home-manager.enable = true;
}
