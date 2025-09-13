{ pkgs, self, ... }: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment = {
    variables = {
      "EDITOR" = "nvim";
      "VSCODE_PORTABLE" = "~/.vscode";
    };
    systemPackages = with pkgs; [ tree nixpkgs-fmt ];
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
    persistent-apps = [ "/Applications/Arc.app" "/Applications/kitty.app" ];
    persistent-others = [ ];
    minimize-to-application = true;
    mineffect = "suck";
    tilesize = 56;
  };
  system.primaryUser = "martyn";

  system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = false;
  system.defaults.WindowManager.EnableStandardClickToShowDesktop = false;
  system.defaults.smb.NetBIOSName = "mbair-martynv";

  system.defaults.screensaver.askForPassword = true;
  system.defaults.screensaver.askForPasswordDelay = 300; # 5 minutes
  system.defaults.CustomUserPreferences = {
    "com.apple.screensaver" = {
      idleTime = 1200; # 0 disables the screensaver
    };
  };

  networking.hostName = "mbair-martynv";
  networking.localHostName = "mbair-martynv";

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
    taps = [ "FelixKratz/formulae" "nikitabobko/tap" ];
    brews = [ "borders" ];
    casks = [
      "1password"
      "aerospace"
      "arc"
      "chatgpt"
      "font-symbols-only-nerd-font"
      "google-chrome"
      "kitty"
      "nordvpn"
      "notion"
      "spotify"
      "sunsama"
      "visual-studio-code"
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
