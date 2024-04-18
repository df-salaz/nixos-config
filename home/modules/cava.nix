{ config, inputs, pkgs, ... }:

{
	programs.cava = {
		enable = true;
		settings = {
			input.method = "pipewire";
			smoothing.noise_reduction = 15;
		};
	};
}
