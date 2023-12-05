{ inputs, ... }:
{
  additions = final: prev: import ../packages { pkgs = final; };
  modifications = final: prev: { };
}
