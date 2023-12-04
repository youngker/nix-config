{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.dev.texlive;
in {
  options.modules.dev.texlive = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.texlive = {
      enable = true;
      extraPackages = tpkgs: {
        inherit (tpkgs) scheme-full texdoc latex2e-help-texinfo;
        pkgFilter = pkg:
          pkg.tlType == "run"
          || pkg.tlType == "bin"
          || pkg.pname == "latex2e-help-texinfo";
      };
    };
    home.packages = with pkgs; [
      inkscape
      librsvg
      noto-cjk
    ];
  };
}
