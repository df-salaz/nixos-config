This is a NixOS flake that defines both my system and user configuration declaratively. Follows `nixpkgs-unstable`.

From within this directory:
- Regenerate NixOS using `sudo nixos-rebuild switch --flake .`
- Update the software repository using `nix flake update .`

The aliases `nixr` and `nixu` are defined respectively, and can be ran from anywhere assuming this repository has been cloned into your home directory. For making massive changes, `nixb` 
will regenerate NixOS and add a boot entry without performing an in-place switcheroo ~~that ends up crashing and wiping out your efi partition~~.
