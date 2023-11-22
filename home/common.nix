{ lib, pkgs, user, ... }:

{
  programs.home-manager.enable = true;

  manual.manpages.enable = true;

  modules = {
    apps = {
      alacritty.enable = true;
      bash.enable = true;
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
      cmake.enable = true;
      cpp.enable = true;
      emacs.enable = true;
      git.enable = true;
      go.enable = true;
      haskell.enable = true;
      java.enable = true;
      nix.enable = true;
      ocaml.enable = true;
      python.enable = true;
      rust.enable = true;
      sbcl.enable = true;
      texlive.enable = true;
    };
  };

  home = {
    username = "${user.name}";
    stateVersion = "23.05";
  };

  xdg.configFile."nix/nix.conf".text = ''
    experimental-features = nix-command flakes
  '';
}
