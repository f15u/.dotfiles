{pkgs, ...}: {
  virtualisation = {
    containers.enable = true;

    docker = {
      enable = true;
      enableOnBoot = true;
      liveRestore = false;
      storageDriver = "overlay2";

      daemon = {
        settings = {
          experimental = true;
        };
      };

      extraPackages = with pkgs; [
        docker-buildx
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}
