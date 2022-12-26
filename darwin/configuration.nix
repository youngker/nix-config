{ pkgs, user, ... }:
{
  users.users.${user.username} = {
    home = "/Users/${user.username}";
    shell = pkgs.zsh;
  };

  services = {
    nix-daemon.enable = true;
  };
}
