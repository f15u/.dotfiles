{
  pkgs,
  lib,
  ...
}: let
  version = "0.6.0";
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

  fastpotify = pkgs.stdenv.mkDerivation {
    pname = "fastpotify";
    inherit version;

    src = pkgs.fetchurl {
      url = "https://github.com/crmne/fastpotify/releases/download/v${version}/fastpotify-v${version}-${target}.tar.gz";
      hash = "sha256-FXIuJZGBLQgwTzUD/7mx405zyHhhSBMP75yHfB4rCxI=";
    };

    nativeBuildInputs = [pkgs.autoPatchelfHook pkgs.makeWrapper];
    buildInputs = [pkgs.stdenv.cc.cc.lib pkgs.alsa-lib pkgs.libpulseaudio];

    sourceRoot = "fastpotify-v${version}-${target}";

    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      runHook preInstall
      install -Dm755 fastpotify $out/bin/fastpotify
      install -Dm644 packaging/applications/fastpotify.desktop \
        $out/share/applications/fastpotify.desktop
      install -Dm644 packaging/icons/fastpotify.svg \
        $out/share/icons/hicolor/scalable/apps/fastpotify.svg
      runHook postInstall
    '';

    postFixup = ''
      wrapProgram $out/bin/fastpotify \
        --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath runtimeLibs}
    '';

    meta = with lib; {
      description = "Fast native Spotify client with local playback and Spotify Connect";
      homepage = "https://fastpotify.rocks";
      license = licenses.mit;
      platforms = ["x86_64-linux"];
      sourceProvenance = with sourceTypes; [binaryNativeCode];
      mainProgram = "fastpotify";
    };
  };
in {
  home.packages = [fastpotify];
}
