{...}: {
  # Enable the OpenSSH daemon with sane defaults
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    kbdInteractiveAuthentication = false;
    openFirewall = true;
    knownHosts = {
      "github.com".publicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==";
      "github.com".publicKey = "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg=";
      "github.com".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
      "black-hanekawa.home.arpa".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC3crc1ExB359cU7gI4IBUjiQRK4laeffe6ICAigyf9B";
      "black-hanekawa.home.arpa".publicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQClT30gGPlgdEKRB14StQd4j+uPbnHn9FkROKUrt0ka/mU2qX+uxM0Gz8FEXlBcUlwxPrXZqgiuPDYbTe8nMWpGbwZ8OKNAjymB77zmuKjvZjD1BJPiSRM2R8GuoGXqs7Z+oBoXZwZbGMh1sATsvZmBV8S1XdHKYIq3sAjq8rvzR141n5MTH0TwD5D/WQw//OfShZe5xDY/yCGlqHEf03fOPcRbPNmmA8m+vzXrritcNmjoBos+rhiLp6A5HrRt7qPKMx4VMUdPx+ldNVxwfKWim65Qwi/ACfVP6qp2ff06ukNoe+hbfkOgv0HGMcwG1oRUr9vmZ8Sc+88CRXb43oaItmxCi9irbhLj7RY82evHpBfo9F6ST8bq6l9r1ezthcMGLEOQfR4pxKSWhiq583gKtOIXctY4cyU/SdjWcxcc9UjHpyohTbiscpZuCHh0THBfIDLE3mdKcb9MZGCk4Oa8VytBTziKuxxYV3rY326Q9Y0iyUfZswh9ng2gsV8hI3M=";
      "black-hanekawa.home.arpa".publicKey = "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBJmK9my+JbqHTibFSa2M4SILZpWmtzBxplGVh7arTn5dnofhJH9lelzn+S+UTVpLA0DAZSaSAcoMxqUVCcth+Ac=";
    };
  };
}
