{ config, pkgs, ... }:

let
  androidComposition = pkgs.androidenv.composeAndroidPackages {
    buildToolsVersions = [ "35.0.0" ];
    platformVersions = [ "35" ];
    includeEmulator = false;
  };
  
  antigravity-pkg = (builtins.getFlake "github:jacopone/antigravity-nix").packages.${pkgs.system}.google-antigravity-no-fhs;
in
{
  nixpkgs.config = {
    allowUnfree = true;
    android_sdk.accept_license = true;
  };

  home.username = "imza";
  home.homeDirectory = "/home/imza";
  home.stateVersion = "25.11";

  home.sessionVariables = {
    PNPM_HOME = "$HOME/.local/share/pnpm";
  };
  
  home.sessionPath = [
    "$HOME/.local/share/pnpm"
  ];

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user.name = "mqnoy";
      user.email = "qnoy.social@gmail.com";
    };
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi # optional AMD hardware acceleration
      obs-gstreamer
      obs-vkcapture
    ];
  };

  programs.chromium = {
    enable = true;
    package = pkgs.google-chrome;
  };

  xdg.desktopEntries.antigravity = {
    name = "Antigravity";
    exec = "antigravity %u";
    terminal = false;
    type = "Application";
    categories = [ "Development" ];
    mimeType = [ "x-scheme-handler/antigravity" ];
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/antigravity" = [ "antigravity.desktop" ];

      # Set Google Chrome as the default web browser
      "text/html" = [ "google-chrome.desktop" ];
      "x-scheme-handler/http" = [ "google-chrome.desktop" ];
      "x-scheme-handler/https" = [ "google-chrome.desktop" ];
      "x-scheme-handler/about" = [ "google-chrome.desktop" ];
      "x-scheme-handler/unknown" = [ "google-chrome.desktop" ];
    };
  };

  xdg.configFile."mimeapps.list".force = true;
  xdg.dataFile."applications/mimeapps.list".force = true;

  home.packages = with pkgs; [
    vscode
    google-chrome
    scrcpy

    # other
    onlyoffice-desktopeditors
    postman

    # Javascript development
    nodejs_22
    nodePackages.pnpm

    # Android development
    android-studio
    androidComposition.androidsdk
    filezilla
    remmina
    winbox4

    camunda-modeler
    antigravity-pkg 
    dbeaver-bin
    protobuf
    poppler-utils
    google-cloud-sdk
    biome
  ];
}