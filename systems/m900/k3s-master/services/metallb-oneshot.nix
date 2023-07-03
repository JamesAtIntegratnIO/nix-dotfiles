{
  self,
  config,
  lib,
  pkgs,
  ...
}: let
  crds = pkgs.writeTextFile {
    name = "metallb-crds.yaml";
    text = ''
      ---
      apiVersion: metallb.io/v1beta1
      kind: IPAddressPool
      metadata:
        name: default
        namespace: metallb-system
      spec:
        addresses:
        - 10.0.1.200-10.0.1.253
      ---
      apiVersion: metallb.io/v1beta1
      kind: L2Advertisement
      metadata:
        name: default
        namespace: metallb-system
      ---
    '';
  };
in {
  systemd.services = {
    "metallb-install" = {
      wantedBy = ["k3s.service"];
      after = ["k3s.service"];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = "yes";
        ExecStart = [
          "${pkgs.kubernetes-helm}/bin/helm --kubeconfig=/etc/rancher/k3s/k3s.yaml repo add metallb https://metallb.github.io/metallb"
          "${pkgs.kubernetes-helm}/bin/helm --kubeconfig=/etc/rancher/k3s/k3s.yaml --namespace metallb-system install --create-namespace metallb metallb/metallb"
        ];
      };
    };
    "metallb-deploy" = {
      wantedBy = ["k3s.service"];
      after = ["metallb-install.service"];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = "yes";
        ExecStart = "${pkgs.k3s}/bin/k3s kubectl apply -f ${crds}";
      };
    };
  };
}
