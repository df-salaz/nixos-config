This is a NixOS flake that defines both my system and user configuration declaratively. Follows `nixpkgs-unstable`.

From within this directory:
- Regenerate NixOS using `sudo nixos-rebuild switch --flake .`
- Update the software repository using `nix flake update .`

The aliases `nixr` and `nixu` are defined respectively. These aliases can be ran from anywhere and assume that this repository has been cloned into `$HOME/.nixos-config`. When making massive changes, use `nixb` to regenerate NixOS and add a boot entry without performing an in-place switch.
