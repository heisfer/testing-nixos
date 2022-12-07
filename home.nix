{ config, pkgs, inputs, hyprland, ... }:

{
  home.username = "heisfer";
  home.homeDirectory = "/home/heisfer";
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
  
  home.packages = [
    pkgs.neofetch
    pkgs.pciutils
    pkgs.nix-info
    pkgs.kitty
    pkgs.jetbrains.phpstorm
    pkgs.htop
    pkgs.btop
    pkgs.xorg.xeyes
    inputs.webcord.packages.${pkgs.system}.default
    inputs.hyprpicker.packages.${pkgs.system}.default
  ];

  imports = [
    hyprland.homeManagerModules.default
  ];  
  wayland.windowManager.hyprland.enable = true;
  

  
}
