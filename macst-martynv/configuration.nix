{ pkgs, self, ... }: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment = {
    variables = {
      "EDITOR" = "nvim";
      "VSCODE_PORTABLE" = "~/.vscode";
    };
    systemPackages = with pkgs; [
      neovim
      tree

      # Development tools
      devenv
      nixpkgs-fmt
      nodejs
      graphviz

      # Infrastructure tools
      # terraform
      fluxcd
      # R tools

    ];
  };

  services = {
    # Auto upgrade nix package and the daemon service
    sketchybar = { enable = false; };
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
      "/Applications/Arc.app"
      "/Applications/kitty.app"
      "/Applications/Slack.app"
      "/Applications/Sunsama.app"
    ];
    persistent-others = [ ];
    minimize-to-application = true;
    mineffect = "suck";
    tilesize = 56;
  };
  system.primaryUser = "martyn";

  system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = false;
  system.defaults.WindowManager.EnableStandardClickToShowDesktop = false;
  system.defaults.smb.NetBIOSName = "macst-martynv";

  # HotKeys
  system.defaults.CustomUserPreferences."com.apple.symbolichotkeys" = {
    AppleSymbolicHotKeys = {
      "64" = { enabled = false; }; # Spotlight
      "65" = { enabled = false; }; # Spotlight
    };
  };

  # Screen saver
  system.defaults.screensaver.askForPassword = true;
  system.defaults.screensaver.askForPasswordDelay = 300; # 5 minutes
  system.defaults.CustomUserPreferences."com.apple.screensaver" = {
    idleTime = 1200; # 0 disables the screensaver
  };

  networking.hostName = "macst-martynv";
  networking.localHostName = "macst-martynv";

  power.restartAfterPowerFailure = true;
  power.sleep.computer = "never";
  power.sleep.display = 30; # minutes

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config = { allowUnfree = true; };

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
      "f/mcptools"
      "withgraphite/tap"
    ];
    brews = [ "act" "sevenzip" "mcp" "withgraphite/tap/graphite" ];
    casks = [
      "1password"
      "aerospace"
      "arc"
      "beekeeper-studio"
      "bruno"
      "bunch"
      "chatgpt"
      "claude"
      "docker-desktop"
      "figma"
      "freelens"
      "font-symbols-only-nerd-font"
      "gitkraken-cli"
      "gitkraken"
      "google-chrome"
      "hammerspoon"
      "inkscape"
      "kitty"
      "logi-options+"
      "microsoft-teams"
      "moom"
      "nordvpn"
      "notion"
      "pgadmin4"
      "raycast"
      "slack"
      "spotify"
      "sunsama"
      "tableplus"
      "whatsapp"
      "zoom"
    ];
    masApps = {
      "Canary" = 1236045954;
      "Flighty" = 1358823008;
      "Perplexity" = 6714467650;
    };
  };

  fonts.packages = [
    pkgs.ibm-plex
    pkgs.nerd-fonts.hack
    pkgs.open-sans
    pkgs.montserrat
    pkgs.poppins
  ];

}
