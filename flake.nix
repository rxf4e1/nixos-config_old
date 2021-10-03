{
  description = "rx/Flake Configuration";

  inputs = {
    master.url = "github:NixOS/nixpkgs/master";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    flake-utils.url = "github:numtide/flake-utils";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };
  
  outputs =
    inputs @ { self, master, unstable, ...}:
    {
      
      nixosConfigurations = {
        nixos = unstable.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
        };
        
        aspire-a315 = unstable.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            # System
            ./hosts/aspire-a315
            ./modules/system/amdgpu.nix
            ./modules/system/nix.nix
            ./modules/system/progs.nix
            ./modules/system/serv.nix
            ./modules/system/users.nix
            # Home-manager
            inputs.home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.rxf4el = {
                imports = [
                  # ./modules/home-manager/wm.nix
                  ./modules/home-manager/sway.nix
                  ./modules/home-manager/alacritty.nix
                  ./modules/home-manager/progs.nix
                  ./modules/home-manager/git.nix
                  # ./modules/home-manager/serv.nix
                  # ./modules/home-manager/emacs.nix
                  # ./modules/home-manager/neovim.nix
                  ./modules/home-manager/zsh.nix
                ];
              };
            }
          ];
        };
      };
    };
}
