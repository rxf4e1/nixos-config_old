{ config, pkgs, inputs, ... }:

{
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
    autoOptimiseStore = true;
    #allowedUsers = ["@wheels"];
    #trustedUsers = ["@wheels"];
    #useSandbox = true;
    maxJobs = 8;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 3d";
    };

    # --- Cachix:
    binaryCaches =
      [ "https://nix-community.cachix.org"
      ];
    binaryCachePublicKeys =
      [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
  };

  nixpkgs = {
    config = { allowUnfree = true; };
    #overlays = [ inputs.emacs-overlay.overlay ];
  };
}
