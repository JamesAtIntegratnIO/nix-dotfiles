{ pkgs, ... }:
{
  (appimageTools.wrapType2
    {
      # or wrapType1
      name = "prospect-mail";
      src = fetchurl {
        url = "https://github.com/julian-alarcon/prospect-mail/releases/download/v0.4.0/Prospect-Mail-0.4.0.AppImage";
        sha512 = "E7P94ZUro6c/3wlQ/sC1J6TifOgf9k+dfN13l+JLbg3PjKTIhoc0LZBDGzmSX4UWdCw/FPb5eZSNfNpLNi6T1w==";
      };
  })
}