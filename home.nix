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
    "github.copilot-chat"
    "panicbit.cargo"
    "uniquevision.vscode-plpgsql-lsp"
    "ckolkman.vscode-postgres"
    "ms-python.python"
    "hashicorp.terraform"
    "eamodio.gitlens"
    "vue.volar"
    "ibm.output-colorizer"
    "fill-labs.dependi"
    "vadimcn.vscode-lldb"
    "ms-vscode.test-adapter-converter"
    "inferrinizzard.prettier-sql-vscode"
    "usernamehw.errorlens"

    # Add more extensions here
  ];
in
{
  imports = [
    ./mutable-files.nix
  ];
  home = {
    stateVersion = "24.05";
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    username = "martyn";
    # Packages that should be installed to the user profile.
    packages = with pkgs; [
      awscli2
      aws-sam-cli
      eza
      fd
      ffmpegthumbnailer
      file
      fzf
      gh
      kubernetes-helm
      htop
      imagemagick
      jq
      kubectl
      poppler
      ripgrep
      zoxide
    ];
    shellAliases = {
      ls = "eza -1lh --no-quotes -I .DS_Store";
      ll = "eza -1lah --no-quotes -I .DS_Store";
      rstudio = "open -a RStudio";
      positron = "open -a Positron";
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
      ".config/aerospace/aerospace.toml" = {
        source = ./configs/aerospace.toml;
      };
      ".config/zed/settings.json" = {
        source = ./configs/zed/settings.json;
      };
      ".config/sketchybar/sketchybarrc" = {
        source = ./configs/sketchybar/sketchybarrc;
        executable = true;
      };
      ".config/sketchybar/plugins/" = {
        source = ./configs/sketchybar/plugins;
        target = ".config/sketchybar/plugins/";
        recursive = true;
        executable = true;
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
    enableUpdateCheck = true;
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

  programs.k9s = {
    enable = true;
  };
}
