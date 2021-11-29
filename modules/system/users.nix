{ config, pkgs, ... }:

{
  users.users.rxf4el = {
    isNormalUser = true;
    # isMutable = true;
    createHome = true;
    home = "/home/rxf4el";
    shell = pkgs.zsh;
    uid = 1000;
    group = "users";
    extraGroups =
      [ "wheel" "audio" "video" "networkmanager" "input" "disk" "adbusers" ];
    openssh.authorizedKeys.keys =
      [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJc7lx/1LWAjujhMRtQNb19xzvY26dn4rOCZ+d6wuTPx rxf4e1@tuta.io"
      ];
  };

  users.users.rx = {
		isNormalUser = true;
		createHome = true;
		home = "/home/rx";
		shell = pkgs.zsh;
		uid = 1010;
		group = "users";
		extraGroups =
			[ "wheel" "audio" "video" "networkmanager" "input" "disk" "adbusers" ];
  };

}
