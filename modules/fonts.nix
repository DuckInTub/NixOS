{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      nerd-fonts.hack
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
    ];

    fontconfig.allowBitmaps = false;
    fontconfig.defaultFonts.monospace = ["Hack Nerd Font"];
    fontconfig.defaultFonts.emoji = ["Noto Color Emoji"];
  };
}
