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

      # Infrastructure tools
      # terraform
      minikube
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
  system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = false;
  system.defaults.WindowManager.EnableStandardClickToShowDesktop = false;
  system.primaryUser = "martyn";
  networking.hostName = "macst-martynv";
  networking.localHostName = "macst-martynv";

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
    taps = [ "nikitabobko/tap" "FelixKratz/formulae" "f/mcptools" ];
    brews = [ "sevenzip" "mcp" ];
    casks = [
      "1password"
      "aerospace"
      "arc"
      "beekeeper-studio"
      "bruno"
      "chatgpt"
      "figma"
      "font-symbols-only-nerd-font"
      "gitkraken-cli"
      "gitkraken"
      "google-chrome"
      "inkscape"
      "kitty"
      "logi-options+"
      "microsoft-teams"
      "nordvpn"
      "notion"
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

  fonts.packages =
    [ pkgs.ibm-plex pkgs.nerd-fonts.hack pkgs.open-sans pkgs.montserrat ];

}
