{pkgs, ...}: let
  prospect-mail-desktop =
    pkgs.writeTextDir
    {
      name = "share/applications/prospect-mail.desktop";
      text = ''
        [Desktop Entry]
        Type=Appication
        Name=Prospect Mail
        Exec=prospect-mail
        StartupWMClass===AppRun
      '';
    };
  bambu-studio-desktop =
    pkgs.writeTextDir
    {
      name = "share/applications/bambu-studio.desktop";
      text = ''
        [Desktop Entry]
        Type=Appication
        Name=Bambu Studio
        Exec=bambu-studio
        StartupWMClass===AppRun
      '';
    };
in {
  users.users.boboysdadda = {
    packages = with pkgs; [
      (
        appimageTools.wrapType2 {
          # or wrapType1
          name = "prospect-mail";
          src = fetchurl {
            url = "https://github.com/julian-alarcon/prospect-mail/releases/download/v0.4.0/Prospect-Mail-0.4.0.AppImage";
            sha512 = "E7P94ZUro6c/3wlQ/sC1J6TifOgf9k+dfN13l+JLbg3PjKTIhoc0LZBDGzmSX4UWdCw/FPb5eZSNfNpLNi6T1w==";
          };
        }
      )
      (
        appimageTools.wrapType2 {
          name = "bambu-studio";
          src = fetchurl {
            url = "https://github.com/bambulab/BambuStudio/releases/download/v01.06.02.04/Bambu_Studio_linux_ubuntu_v01.06.02.04-20230427094209.AppImage";
            sha512 = "4OLTdRg9xoAPtYHhhXSyowkf4Hgr6L5LlD00Yl8pjVFXb/IfY/wZkY6NdBYBaixT5aLSqBuF3HkoMVAMvz2+/w==";
          };
        }
      )
    ];
  };
}
