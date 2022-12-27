{ pkgs, user, ... }:
{
  users.users.${user.name} = {
    home = "/Users/${user.name}";
    shell = pkgs.zsh;
  };

  services = {
    nix-daemon.enable = true;
  };
}
