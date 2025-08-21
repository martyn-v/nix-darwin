{ config, pkgs, lib, ... }:
let
  vscodeExtensions = [
    "catppuccin.catppuccin-vsc"
    "catppuccin.catppuccin-vsc-icons"
  ];
in {
  imports = [ ./../mutable-files.nix ];
  home = {
    stateVersion = "24.05";
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    username = "martyn";
    # Packages that should be installed to the user profile.
    packages = with pkgs; [
      eza
      fd
      ffmpegthumbnailer
      file
      gh
      htop
      jq
      nixfmt
      poppler
      ripgrep
    ];
    shellAliases = {
      ls = "eza -1lh --no-quotes -I .DS_Store";
      ll = "eza -1lah --no-quotes -I .DS_Store";
      vc = "code .";
    };
    file = {
      ".config/kitty/kitty.conf" = { source = ./configs/kitty.conf; };
      ".config/starship.toml" = { source = ./configs/starship.toml; };
      ".config/aerospace/aerospace.toml" = {
        source = ./configs/aerospace.toml;
      };

      "Library/Application Support/Code/User/settings.json" = {
        source = ./configs/vscode-settings.json;
        force = true;
        mutable = true;
      };
    };
    activation.postInstall = ''
      for ext in ${lib.concatStringsSep " " vscodeExtensions}; do
        ${pkgs.vscode}/bin/code --install-extension $ext || true
      done
    '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "martyn-v";
    userEmail = "m@rtyn.io";
  };

  programs.vscode = {
    enable = true;
    # enableUpdateCheck = true;
    mutableExtensionsDir = true;
    # userSettings = {carg
    #   "editor.fontSize" = 16;
    #   "editor.fontFamily" = "'Zed Plex Mono', 'IBM Plex Mono', Menlo, Monaco, 'Courier New', monospace";
    #   "editor.formatOnSave" = true;
    #   "editor.detectIndentation" = false;
    #   "editor.inlayHints.enabled" = "offUnlessPressed";
    #   "editor.tabSize" = 4;
    #   "[nix]"."editor.tabSize" = 4;
    #   "terminal.external.osxExec" = "kitty.app";
    #   "terminal.integrated.defaultProfile.osx" = "zsh";
    #   "terminal.integrated.fontSize" = 14;
    #   "window.autoDetectColorScheme" = true;
    #   "workbench.colorTheme" = "Catppuccin Latte";
    #   "workbench.preferredLightColorTheme" = "Catppuccin Latte";
    #   "workbench.preferredDarkColorTheme" = "Catppuccin Frappé";
    #   "workbench.iconTheme" = "catppuccin-latte";
    #   "gitlens.ai.experimental.model" = "openai:gpt-4";
    #   "rust-analyzer.check.command" = "clippy";
    #   "rust-analyzer.testExplorer" = true;
    #   "rust-analyzer.interpret.tests" = true;
    #   "[vue]"."editor.defaultFormatter" = "Vue.volar";
    #   "editor.minimap.enabled" = false;

    # };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    profileExtra = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = false;
    enableZshIntegration = true;
  };

  programs.yazi = {
    # See: https://yazi-rs.github.io/docs/installation#nix
    enable = false;
    enableZshIntegration = true;
  };

  programs.k9s = { enable = false; };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
