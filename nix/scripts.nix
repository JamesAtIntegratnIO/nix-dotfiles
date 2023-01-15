{
  perSystem = {
    self',
    config,
    lib,
    pkgs,
    ...
  }: {
    mission-control.scripts = {
      helloWorld = {
        category = "Test";
        description = "hello world test";
        exec = pkgs.writeShellScriptBin "helloworld" ''
          echo 'Hello Worls'
        '';
      };
    };
  };
}
