{ lib, pkgs, config, ... }:

with lib; {
  config = mkIf config.modules.darwin.darwin-settings.enable {
    home.file.darwin-settings.target = ".darwin-settings";
    home.file.darwin-settings.onChange = ''
      ${pkgs.bash}/bin/bash "$HOME/.darwin-settings"
    '';
    home.file.darwin-settings.text = ''
      defaults write com.apple.dock autohide -bool true
      defaults write com.apple.dock orientation -string "left"
      killall Dock

      defaults write 'Apple Global Domain' _HIHideMenuBar -float 1
      defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag 0
    '';
  };
}
