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

      /usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:60:enabled true" ~/Library/Preferences/com.apple.symbolichotkeys.plist
      /usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:60:value:parameters:2 131072" ~/Library/Preferences/com.apple.symbolichotkeys.plist
    '';
  };
}
