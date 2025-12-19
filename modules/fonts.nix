{pkgs, ...}: {
  # Overlay to remove Noto-Tangut from noto-fonts package.
  # This font has documented conflicts with CJK renderings.
  # nixpkgs.overlays = [
  #   (self: super: {
  #     noto-fonts = super.noto-fonts.overrideAttrs (old: {
  #       installPhase =
  #         old.installPhase
  #         + ''
  #           rm -f $out/share/fonts/noto/NotoSerifTangut-Regular.otf
  #         '';
  #     });
  #   })
  # ];

  fonts = {
    packages = with pkgs; [
      nerd-fonts.hack
      nerd-fonts.jetbrains-mono
      nerd-fonts.noto
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
