return {
    "neovim/nvim-lspconfig",
    opts = {
        servers = {
            nixd = {
                cmd = { "nixd" },
                settings = {
                    nixd = {
                        nixpkgs = {
                            expr = "import <nixpkgs> { }",
                        },
                        formatting = {
                            command = { "alejandra" },
                        },
                        options = {
                            nixos = {
                                expr = '(builtins.getFlake "/home/avari/.nixfiles").nixosConfigurations.avari.options',
                            },
                            home_manager = {
                                expr = '(builtins.getFlake "/home/avari/.nixfiles").homeConfigurations.avari.options',
                            },
                        },
                    },
                },
            },
        },
    },
}
