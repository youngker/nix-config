{
  inputs,
  outputs,
  pkgs,
  ...
}:

{
  home = {
    homeDirectory = "/home/${outputs.user.name}";
    username = "${outputs.user.name}";
    stateVersion = "26.05";
  };

  modules = {
    apps = {
      vim.enable = true;
      bash.enable = true;
      starship.enable = true;
      zsh.enable = true;
      xterm-24bit.enable = true;
    };

    base = {
      core.enable = true;
      utils.enable = true;
    };

    dev = {
      emacs.enable = true;
      git.enable = true;
    };
  };
}
