{pkgs, ...}: let
  # Import the public key declaratively.  Export it on your machine with:
  #
  #   gpg --export --armor 163CB59F72D44DD0 > secrets/federico-public.asc
  #
  # The public key is safe to commit.  NEVER export the private key.
  publicKey = ../../secrets/federico-public.asc;
in {
  programs.git = {
    enable = true;
    lfs.enable = true;

    signing = {
      key = "163CB59F72D44DD0";
      signByDefault = true;
    };

    settings = {
      user = {
        name = "Federico Biccheddu";
        email = "service+git@f15u.dev";
      };

      init.defaultBranch = "main";
      pull.ff = true;
      pull.rebase = true;
      rebase.autosquash = true;
      help.autoCorrect = "prompt";
    };
  };

  programs.gpg = {
    enable = true;

    # Public keys imported into the keyring on every switch.
    publicKeys = [
      {source = publicKey;}
    ];

    settings = {
      keyid-format = "long";
      with-fingerprint = true;

      # Strong digest and cipher defaults.
      personal-digest-preferences = "SHA512";
      cert-digest-algo = "SHA512";
      default-preference-list = "SHA512 SHA384 SHA256 AES256 AES192 AES";

      # Fetch unknown keys from keyservers automatically.
      auto-key-locate = "keyserver";
      auto-key-retrieve = true;
    };
  };

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-qt;

    # Cache passphrases for 10 minutes (first), 2 hours (max).
    defaultCacheTtl = 600;
    maxCacheTtl = 7200;
  };
}
