{ config, pkgs, lib, ... }:
let
  vscodeExtensions = [
    "tamasfe.even-better-toml"
    "jnoortheen.nix-ide"
    "tamasfe.even-better-toml"
    "jnoortheen.nix-ide"
    "catppuccin.catppuccin-vsc"
    "catppuccin.catppuccin-vsc-icons"
    "rust-lang.rust-analyzer"
    "github.copilot"
    "panicbit.cargo"
    "uniquevision.vscode-plpgsql-lsp"
    "ckolkman.vscode-postgres"
    "ms-python.python"
    # Add more extensions here
  ];
in
{

  home = {
    stateVersion = "24.05";
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    username = "martyn";
    # Packages that should be installed to the user profile.
    packages = with pkgs; [
      awscli2
      eza
      fd
      ffmpegthumbnailer
      file
      fzf
      gh
      htop
      imagemagick
      jq
      poppler
      ripgrep
      zoxide
    ];
    shellAliases = {
      ls = "eza -1lh --no-quotes -I .DS_Store";
      ll = "eza -1lah --no-quotes -I .DS_Store";
      rstudio = "open -a RStudio";
    };
    file = {
      ".config/kitty/kitty.conf" = {
        source = ./configs/kitty.conf;
      };
      ".config/yazi/yazi.toml" = {
        source = ./configs/yazi.toml;
      };
      ".config/starship.toml" = {
        source = ./configs/starship.toml;
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
    enableUpdateCheck = true;
    enableExtensionUpdateCheck = false;
    mutableExtensionsDir = true;
    userSettings = {
      "editor.fontSize" = 14;
      "editor.fontFamily" = "'IBM Plex Mono', Menlo, Monaco, 'Courier New', monospace";
      "editor.formatOnSave" = true;
      "editor.detectIndentation" = false;
      "editor.tabSize" = 4;
      "[nix]"."editor.tabSize" = 4;
      "terminal.external.osxExec" = "kitty.app";
      "terminal.integrated.defaultProfile.osx" = "zsh";
      "terminal.integrated.fontSize" = 14;
      "window.autoDetectColorScheme" = true;
      "workbench.colorTheme" = "Catppuccin Latte";
      "workbench.preferredLightColorTheme" = "Catppuccin Latte";
      "workbench.preferredDarkColorTheme" = "Catppuccin Macchiato";
      "workbench.iconTheme" = "catppuccin-latte";
    };
  };

  programs.zsh = {
    enable = true;
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
    enable = true;
    enableZshIntegration = true;
  };

  programs.yazi = {
    # See: https://yazi-rs.github.io/docs/installation#nix
    enable = true;
    enableZshIntegration = true;
  };


}
