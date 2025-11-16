{ config, pkgs, ... }:

let
  androidComposition = pkgs.androidenv.composeAndroidPackages {
    buildToolsVersions = [ "35.0.0" ];
    platformVersions = [ "35" ];
    includeEmulator = false;
  };
in
{
  nixpkgs.config = {
    allowUnfree = true;
    android_sdk.accept_license = true;
  };

  home.username = "imza";
  home.homeDirectory = "/home/imza";
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "mqnoy";
    userEmail = "qnoy.social@gmail.com";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      edit = "sudo -e";
      update = "sudo nixos-rebuild switch";
    };

    history = {
      size = 10000;
      path = "${config.home.homeDirectory}/.zsh_history";
    };

    initExtra = ''
      setopt HIST_IGNORE_ALL_DUPS
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
  };

  home.packages = with pkgs; [
    vscode
    google-chrome
    scrcpy

    # other
    # ytmdesktop

    # Javascript development
    nodejs_22
    pnpm

    # Android development
    android-studio
    androidComposition.androidsdk
  ];
}
