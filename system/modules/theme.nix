{pkgs, systemSettings, lib, ...}:

let
	catppuccin = systemSettings.colorScheme == "catppuccin";
in
{
	catppuccin.flavour = lib.mkIf catppuccin "mocha";
	console.catppuccin.enable = lib.mkIf catppuccin true;
	boot.loader.grub.catppuccin.enable = lib.mkIf catppuccin true;
	services.displayManager.sddm.theme = lib.mkIf catppuccin 
		"catppuccin-sddm-corners";

	environment.systemPackages = with pkgs; lib.optionals (catppuccin) [
		catppuccin-sddm-corners
	];
}
