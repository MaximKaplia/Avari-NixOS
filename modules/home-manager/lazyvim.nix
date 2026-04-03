{
  pkgs,
  inputs,
  ...
}: {
  programs.lazyvim = {
    enable = true;
    ignoreBuildNotifications = true;
    extras = {
      lang.nix.enable = true;
      lang.python = {
        enable = true;
        installDependencies = true; # Install ruff
        installRuntimeDependencies = true; # Install python3
      };
      editor.telescope = {
        enable = true;
        # picker = "telescope";
      };
      editor.neo_tree.enable = true; # File explorer
      editor.harpoon2.enable = true; # Quick file navigation
      editor.illuminate.enable = true; # Highlight other uses of word under cursor
    };
    # configFiles = ./configs/nvim;
    extraPackages = with pkgs; [
      # LSP servers
      nixd
      pyright

      # Formatters
      black
      alejandra

      shfmt # For shell scripts
      stylua # For Lua files
      # Tools
      ripgrep
      fd
      cmake
    ];
  };
}
