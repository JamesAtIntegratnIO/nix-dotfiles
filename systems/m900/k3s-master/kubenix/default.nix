{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = with kubenix.modules; [k8s];
  kubernetes.resources.pods.example.spec.containers.nginx.image = "nginx";
}
