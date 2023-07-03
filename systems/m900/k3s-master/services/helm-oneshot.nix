{pkgs, ...}: {
  systemd.services."metallb-install" = {
    wantedBy = ["k3s.service"];
    after = ["k3s.service"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.k3s}/bin/k3s helm repo add metallb https://metallb.github.io/metallb";
      ExecStart = "${pkgs.k3s}/bin/k3s helm --namespace metallb-system install --create-namespace metallb metallb/metallb";
      ExecStart = "${pkgs.k3s}/bin/k3s kubectl apply -f metallb/crds";
    };
  };
}
