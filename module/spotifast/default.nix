{
  pkgs,
  lib,
  ...
}: let
  version = "0.14.1";
  target = "x86_64-unknown-linux-gnu";

  # dlopen'd at run time, so absent from the binary's NEEDED entries and
  # invisible to autoPatchelfHook.  Wrapped onto LD_LIBRARY_PATH instead.
  runtimeLibs = with pkgs; [
    libxkbcommon
    wayland
    libGL
    libx11
    libxcursor
    libxi
    libxrandr
  ];

  spotifast = pkgs.stdenv.mkDerivation {
    pname = "spotifast";
    inherit version;

    src = pkgs.fetchurl {
      url = "https://github.com/crmne/spotifast/releases/download/v${version}/spotifast-v${version}-${target}.tar.gz";
      hash = "sha256-+Ev6R+3RiEM7oiSxnjJuCjaLqkWaFNlBTemOWadg3Lw=";
    };

    nativeBuildInputs = [pkgs.autoPatchelfHook pkgs.makeWrapper];
    buildInputs = [pkgs.stdenv.cc.cc.lib pkgs.alsa-lib pkgs.libpulseaudio pkgs.pipewire];

    sourceRoot = "spotifast-v${version}-${target}";

    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      runHook preInstall
      install -Dm755 spotifast $out/bin/spotifast
      install -Dm644 packaging/applications/spotifast.desktop \
        $out/share/applications/spotifast.desktop
      install -Dm644 packaging/icons/spotifast.svg \
        $out/share/icons/hicolor/scalable/apps/spotifast.svg
      runHook postInstall
    '';

    postFixup = ''
      wrapProgram $out/bin/spotifast \
        --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath runtimeLibs}
    '';

    meta = with lib; {
      description = "Fast native Spotify client with local playback and Spotify Connect";
      homepage = "https://spotifast.rocks";
      license = licenses.mit;
      platforms = ["x86_64-linux"];
      sourceProvenance = with sourceTypes; [binaryNativeCode];
      mainProgram = "spotifast";
    };
  };
in {
  home.packages = [spotifast];
}
