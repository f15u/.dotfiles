{
  services.blocky = {
    enable = true;
    settings = {
      ports = {
        dns = 53;
        http = 4000;
      };

      upstreams = {
        groups = {
          default = [
            "45.90.28.138"
            "45.90.30.138"
            "1.1.1.1"
            "1.0.0.1"
          ];
        };
      };

      blocking = {
        blackLists = {
          ads = [
            "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
          ];
        };
        clientGroupsBlock = {
          default = ["ads"];
        };
      };

      # Cache DNS responses
      caching = {
        minTime = "5m";
        maxTime = "30m";
        prefetching = true;
      };

      # Query logging
      queryLog = {
        type = "console";
      };
    };
  };

  # Use Blocky as system DNS resolver
  networking.nameservers = ["127.0.0.1"];

  # Prevent NetworkManager from overwriting DNS
  networking.networkmanager.dns = "none";

  # Open DNS port in firewall
  networking.firewall.allowedTCPPorts = [
    53
    4000
  ];
  networking.firewall.allowedUDPPorts = [53];
}
