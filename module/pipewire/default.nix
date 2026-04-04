{
  # Disable PulseAudio completely (redundant with Pipewire)
  services.pulseaudio.enable = false;

  # Enable rtkit for real-time scheduling
  security.rtkit.enable = true;

  # Enable Pipewire with all features
  services.pipewire = {
    enable = true;

    # Enable ALSA support for legacy applications
    alsa.enable = true;
    alsa.support32Bit = true;

    # Enable PulseAudio compatibility layer
    pulse.enable = true;

    # Enable JACK compatibility for professional audio applications
    jack.enable = true;

    # Use WirePlumber as the session manager (default and recommended)
    wireplumber.enable = true;
  };

  # Ensure systemd user services for audio are properly configured
  systemd.user.services.pipewire.wantedBy = ["default.target"];
  systemd.user.services.pipewire-pulse.wantedBy = ["default.target"];
  systemd.user.services.wireplumber.wantedBy = ["pipewire.service"];
}
