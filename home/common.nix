{ lib, pkgs, user, ... }:

{
  programs.home-manager.enable = true;

  manual.manpages.enable = true;

  modules = {
    apps = {
      alacritty.enable = true;
      bingwallpaper.enable = true;
      fzf.enable = true;
      pandoc.enable = true;
      starship.enable = true;
      zsh.enable = true;
      xterm-24bit.enable = true;
    };

    base = {
      core.enable = true;
      utils.enable = true;
    };

    dev = {
      clojure.enable = true;
      cpp.enable = true;
      emacs.enable = true;
      git.enable = true;
      go.enable = true;
      haskell.enable = true;
      java.enable = true;
      nix.enable = true;
      ocaml.enable = true;
      rust.enable = true;
    };
  };

  home = {
    username = "${user.name}";
    stateVersion = "22.11";
  };

  xdg.configFile."nix/nix.conf".text = ''
    experimental-features = nix-command flakes
  '';
}
