{ pkgs, systemSettings, ... }:

{
	environment.systemPackages = with pkgs; [
		nh
	];
	environment.sessionVariables = {
		FLAKE = systemSettings.flake;
	};
}
