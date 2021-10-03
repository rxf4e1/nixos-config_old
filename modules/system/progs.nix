{ config, pkgs, ... }:

{
  environment = {
    variables = {
      XDG_DESKTOP_DIR = "$HOME";
      XDG_CACHE_HOME  = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME   = "$HOME/.local/share";
      XDG_BIN_HOME    = "$HOME/.local/bin";
    };
    
    systemPackages = with pkgs; [
      (aspellWithDicts (ps: with ps; [pt_BR en]))
      cacert curl gitFull wget
      autoconf cmake gnumake gcc 
      coreutils dnsutils inetutils pciutils usbutils
      file man zip unzip
      zlib.dev
      rlwrap sbcl
      nixpkgs-lint nixpkgs-fmt
      nix-index nix-prefetch-git
      rnix-lsp
    ];
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "DejaVuSansMono" "FiraCode"
        "Hack" "Meslo" "Monoid"
        "SourceCodePro" "Terminus"]; })
    iosevka-bin
    emacs-all-the-icons-fonts
  ];

  programs = {
    gnupg = {
      agent = { enable = true; };
    };
    mtr = { enable = true; };
    zsh = {
      enable = true;
    };
  };
}
