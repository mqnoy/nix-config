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

  home.packages = with pkgs; [
    vscode
    google-chrome
    scrcpy

    # other
    onlyoffice-desktopeditors

    # Javascript development
    nodejs_22
    pnpm

    # Android development
    android-studio
    androidComposition.androidsdk
  ];
}
