{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.username = "rstoffel";
  home.homeDirectory = "/home/rstoffel";
  home.stateVersion = "25.05";

  home.packages = [
    inputs.self.packages.${pkgs.system}.default
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Shell configuration with Powerlevel10k
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Oh My Zsh configuration - DISABLE THEME HERE
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
        "web-search"
        "copypath"
        "copyfile"
        "copybuffer"
        "dirhistory"
        "history"
        "jsontools"
        "colored-man-pages"
        "command-not-found"
        "extract"
      ];
      theme = ""; # Disable oh-my-zsh theme to use Powerlevel10k
    };

    # Environment variables
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      SUDO_EDITOR = "nvim";
      BROWSER = "chromium";
      TERMINAL = "alacritty";
    };

    # History configuration
    history = {
      size = 50000;
      save = 50000;
      path = "$HOME/.zsh_history";
      ignoreDups = true;
      ignoreSpace = true;
      expireDuplicatesFirst = true;
      share = true;
    };

    # Shell aliases
    shellAliases = {
      # System
      c = "clear";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "~" = "cd ~";
      "-" = "cd -";

      # Enhanced ls with eza
      ls = "eza -lh --group-directories-first --icons=auto";
      lsa = "ls -a";
      lt = "eza --tree --level=2 --long --icons --git";
      lta = "lt -a";

      # File operations
      rm = "rm -i";
      mv = "mv -i";
      cp = "cp -i";
      mkdir = "mkdir -p";

      # Git aliases
      g = "git";
      gs = "git status";
      gss = "git status -s";
      ga = "git add";
      gaa = "git add --all";
      gc = "git commit -m";
      gcam = "git commit -a -m";
      gp = "git push";
      gpl = "git pull";
      gb = "git branch";
      gco = "git checkout";
      gd = "git diff";
      gl = "git log --oneline --graph --decorate";
      gundo = "git reset --soft HEAD~1";
      gpush = "git push -u origin $(git branch --show-current)";

      # Development
      dev = "cd ~/dev";
      downloads = "cd ~/downloads";

      # NixOS specific
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos#Artemis";
      nix-update = "nix flake update ~/nixos";
      nix-clean = "sudo nix-collect-garbage -d";

      # Network
      ports = "netstat -tuln";
      myip = "curl -s ifconfig.me";
      ping = "ping -c 5";
    };

    # Custom initialization with Powerlevel10k
    initContent = ''
      # Enable Powerlevel10k instant prompt
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

      # Load Powerlevel10k theme
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

      # Initialize Zoxide (smart cd replacement)
      if command -v zoxide >/dev/null 2>&1; then
          eval "$(zoxide init zsh)"
      fi

      # FZF configuration with Catppuccin Mocha theme
      export FZF_DEFAULT_OPTS="
      --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
      --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
      --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
      --height 40% --layout=reverse --border --margin=1 --padding=1"

      # Use fd for file search if available
      if command -v fd >/dev/null 2>&1; then
          export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
          export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
          export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
      fi

      # Custom functions
      mkcd() {
          mkdir -p "$1" && cd "$1"
      }

      backup() {
          cp "$1" "$1.backup.$(date +%Y%m%d_%H%M%S)"
      }

      open() {
          if [[ "$#" -eq 0 ]]; then
              nautilus . > /dev/null 2>&1 &
          else
              xdg-open "$@" > /dev/null 2>&1 &
          fi
      }

      # Smart cd function (using zoxide)
      cd() {
          if [ $# -eq 0 ]; then
              builtin cd ~ && return
          elif [ -d "$1" ]; then
              builtin cd "$1"
          else
              z "$@"
          fi
      }

      # Load Powerlevel10k configuration (will be created after running p10k configure)
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
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

      # Appearance settings to match Hyprland Catppuccin Mocha
      background-color = "#1e1e2e"; # base
      text-color = "#cdd6f4"; # text
      border-color = "#cba6f7"; # mauve (matching your active border)
      border-radius = 0; # Sharp corners like you requested
      border-size = 2; # Same as Hyprland border size

      # Font and text
      font = "JetBrainsMono Nerd Font 14";

      # Behavior
      default-timeout = 10000; # 10 seconds
      ignore-timeout = false;
      max-visible = 5;

      # Progress bar styling
      progress-color = "#cba6f7"; # mauve to match border

      # Group notifications by app
      group-by = "app-name";
    };

    # Extra configuration with Catppuccin Mocha colors
    extraConfig = ''
      [urgency=low]
      background-color=#1e1e2e
      text-color=#a6adc8
      border-color=#45475a
      border-size=2
      default-timeout=5000

      [urgency=normal]
      background-color=#1e1e2e
      text-color=#cdd6f4
      border-color=#cba6f7
      border-size=2
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
      border-size=2

      [summary~=".*[Bb]attery.*"]
      background-color=#1e1e2e
      text-color=#f9e2af
      border-color=#f9e2af
      border-size=2
    '';
  };

  programs.home-manager.enable = true;
}
