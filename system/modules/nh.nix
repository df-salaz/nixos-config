{ pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		nh
	];
	environment.sessionVariables = {
		FLAKE = "/home/koye/.nixos";
	};
}
