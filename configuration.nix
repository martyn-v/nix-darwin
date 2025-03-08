{ pkgs, self, ... }: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment = {
    variables = {
      "EDITOR" = "nvim";
      "VSCODE_PORTABLE" = "~/.vscode";
    };
    systemPackages =
      with pkgs; [
        neovim

        # Development tools
        devenv
        nixpkgs-fmt

        # Infrastructure tools
        # terraform
        minikube
        # R tools

      ];
  };



  services = {
    # Auto upgrade nix package and the daemon service.
    nix-daemon = {
      enable = true;
    };
    sketchybar = {
      enable = false;
    };
  };
  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";
  # Allow trusted users to run nix commands without sudo.
  nix.settings.trusted-users = [ "root" "martyn" ];

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  # programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
  system.defaults.dock = {
    show-recents = false;
    persistent-apps = [
      "/Applications/Obsidian.app"
      "/Applications/Microsoft Teams.app"
      "/Applications/Google Chrome.app"
      "/Applications/kitty.app"
    ];
    persistent-others = [ ];
    minimize-to-application = true;
    mineffect = "suck";
    tilesize = 56;
  };
  system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = false;
  system.defaults.WindowManager.EnableStandardClickToShowDesktop = false;
  #   system.defaults.NSGlobalDomain._HIHideMenuBar = true;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config = {
    allowUnfree = true;
  };

  # Homebrew
  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      upgrade = true;
    };
    taps = [
      "nikitabobko/tap"
      "FelixKratz/formulae"
    ];
    brews = [
      "sevenzip"
      "sketchybar"
      "borders"
    ];
    casks = [
      "1password"
      "aerospace"
      "affinity-designer"
      "affinity-photo"
      "arc"
      "blender"
      "bruno"
      "chatgpt"
      "font-symbols-only-nerd-font"
      "gitkraken-cli"
      "gitkraken"
      "google-chrome"
      "kitty"
      "microsoft-excel"
      "microsoft-powerpoint"
      "microsoft-teams"
      "microsoft-word"
      "nordvpn"
      "obsidian"
      "offset-explorer"
      "onedrive"
      "openlens"
      "opera"
      "positron"
      "spotify"
      "steam"
      "tableplus"
      "whatsapp"
      "zed"
      "zoom"
    ];
    masApps = {
      "Flighty" = 1358823008;
      "Perplexity" = 6714467650;
    };
  };

  fonts.packages = [
    pkgs.ibm-plex
    pkgs.nerdfonts
    pkgs.open-sans
    pkgs.montserrat
  ];



}
