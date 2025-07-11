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
    };
  };

  environment.systemPackages = with pkgs; [
    docker-compose
    docker-buildx
  ];
}
