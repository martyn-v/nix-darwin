{ pkgs, self, ... }: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment = {
    variables = {
      "EDITOR" = "nvim";
    };
    systemPackages =
      with pkgs; [
        neovim

        # Development tools
        devenv
        nixpkgs-fmt
        # Infrastructure tools
        # terraform
      ];
  };


  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
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
      "/Applications/Superhuman.app"
      "/Applications/Obsidian.app"
      "/Applications/Microsoft Teams.app"
      "/Applications/Google Chrome.app"
    ];
    persistent-others = [ ];
    minimize-to-application = true;
    mineffect = "suck";
    tilesize = 56;
  };
  system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = false;

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
    ];
    brews = [
      "r"
      "sevenzip"
    ];
    casks = [
      "1password"
      "aerospace"
      "affinity-photo"
      "bruno"
      "chatgpt"
      "font-symbols-only-nerd-font"
      "gitkraken"
      "gitkraken-cli"
      "google-chrome"
      "kitty"
      "microsoft-excel"
      "microsoft-powerpoint"
      "microsoft-teams"
      "microsoft-word"
      "obsidian"
      "rstudio"
      "spotify"
      "superhuman"
      "tableplus"
      "whatsapp"
      "zoom"
    ];
  };

  fonts.packages = [
    pkgs.ibm-plex
    pkgs.nerdfonts
    pkgs.open-sans
    pkgs.montserrat
  ];

}
