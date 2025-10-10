{ pkgs, lib, config, inputs, ... }:

{
  # https://devenv.sh/basics/
  env.GREET = "devenv";

  # https://devenv.sh/packages/
  packages = [
    pkgs.git
    pkgs.go
    pkgs.goreleaser
    pkgs.cosign
    pkgs.docker
    pkgs.yamlfmt
    pkgs.nil
    pkgs.fzf
    pkgs.zsh
  ];

  # https://devenv.sh/languages/
  languages = {
    go.enable = true;
    go.enableHardeningWorkaround = true;
    nix.enable = true;
    nix.lsp.package = pkgs.nixd;
  };

  # https://devenv.sh/processes/
  # processes.dev.exec = "${lib.getExe pkgs.watchexec} -n -- ls -la";

  # https://devenv.sh/services/
  # services.postgres.enable = true;

  # https://devenv.sh/scripts/
  scripts.hello.exec = ''
    echo hello from $GREET
  '';

  # https://devenv.sh/basics/
  enterShell = ''
    hello         # Run scripts directly
    git --version # Use packages
  '';

  # https://devenv.sh/tasks/
  # tasks = {
  #   "myproj:setup".exec = "mytool build";
  #   "devenv:enterShell".after = [ "myproj:setup" ];
  # };

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    git --version | grep --color=auto "${pkgs.git.version}"
  '';

  # https://devenv.sh/git-hooks/
  # git-hooks.hooks.shellcheck.enable = true;
  git-hooks = {
    hooks = {
      shellcheck.enable = true;
    };
  };

  # https://devenv.sh/devcontainer/
  devcontainer = {
    enable = true;
    settings.customizations.vscode.extensions = [
      "golang.go"
      "GitHub.copilot"
    ];
  };

  cachix = {
    enable = true;
    pull = [ 
      "pre-commit-hooks"
    ];
  };

  # See full reference at https://devenv.sh/reference/options/
}
