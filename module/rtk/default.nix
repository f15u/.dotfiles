{
  pkgs,
  lib,
  ...
}: let
  version = "0.51.0";
  target = "x86_64-unknown-linux-musl";

  rtk = pkgs.stdenv.mkDerivation {
    pname = "rtk";
    inherit version;

    src = pkgs.fetchurl {
      url = "https://github.com/rtk-ai/rtk/releases/download/v${version}/rtk-${target}.tar.gz";
      hash = "sha256-UCjTsZqPCZDTD+yfuwfjJ4K8VpjmGPsYYarYqcy6TrU=";
    };

    sourceRoot = ".";

    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      runHook preInstall
      install -Dm755 rtk $out/bin/rtk
      runHook postInstall
    '';

    meta = with lib; {
      description = "Rust Token Killer: CLI proxy that compresses command output for LLM agents";
      homepage = "https://github.com/rtk-ai/rtk";
      license = licenses.asl20;
      platforms = ["x86_64-linux"];
      sourceProvenance = with sourceTypes; [binaryNativeCode];
      mainProgram = "rtk";
    };
  };
in {
  home.packages = [rtk];
}
