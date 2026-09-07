{ pkgs, lib, ... }:

let
  inherit (pkgs) appimageTools fetchurl;

  version = "29.0.0";
  pname = "polypane";

  src = fetchurl {
    url = "https://github.com/firstversionist/polypane/releases/download/v${version}/Polypane-${version}.AppImage";
    hash = "sha256-73qbLYydLoF/E4Pyfy5xUv1Oziyr6b7Fr10no0zdmn4=";
  };

  appimageContents = appimageTools.extract {
    inherit pname version src;
  };
in
{
  home.packages = [
    (appimageTools.wrapType2 {
      inherit pname version src;

      extraInstallCommands = ''
        install -m 444 -D ${appimageContents}/polypane.desktop \
          $out/share/applications/polypane.desktop

        substituteInPlace $out/share/applications/polypane.desktop \
          --replace-fail 'Exec=AppRun' 'Exec=polypane'

        for icon in ${appimageContents}/usr/share/icons/hicolor/*/apps/polypane.png; do
          size=$(echo "$icon" | grep -Po '\d+x\d+')
          install -m 444 -D "$icon" \
            "$out/share/icons/hicolor/$size/apps/polypane.png"
        done
      '';

      meta = with lib; {
        description = "Browser for web developers with multi-viewport previews, device emulation and accessibility tooling";
        homepage = "https://polypane.app";
        license = licenses.unfree;
        platforms = [ "x86_64-linux" ];
        sourceProvenance = with sourceTypes; [ binaryNativeCode ];
        mainProgram = "polypane";
      };
    })
  ];
}
