{ pkgs, ... }:
{
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
      # Make the Podman socket available in place of the Docker socket, so
      #  Docker tools can find the Podman socket.
      dockerSocket.enable = true;
      extraPackages = [ pkgs.podman-compose ];

      autoPrune = {
        enable = true;
        dates = "monthly";
      };

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };

  };
}