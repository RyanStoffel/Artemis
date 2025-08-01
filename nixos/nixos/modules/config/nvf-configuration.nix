{
  pkgs,
  lib,
  ...
}: {
  vim = {
    options = {
      tabstop = 2;
      shiftwidth = 2;
      autoindent = true;
      wrap = false;
    };

    autopairs = {
      nvim-autopairs.enable = true;
    };

    theme = {
      enable = true;
      name = "catppuccin";
      style = "mocha";
      transparent = true;
    };

    statusline.lualine.enable = true;

    telescope.enable = true;

    autocomplete.nvim-cmp.enable = true;

    clipboard = {
      enable = true;
      registers = "unnamedplus";
      providers = {
        wl-copy.enable = true;
        xclip.enable = true;
        xsel.enable = true;
      };
    };

    filetree.neo-tree.enable = true;

    lsp = {
      enable = true;
      formatOnSave = true;
      lspSignature.enable = true;
      lightbulb.enable = true;
    };

    languages = {
      enableFormat = true;
      enableTreesitter = true;
      bash.enable = true;
      clang.enable = true;
      tailwind.enable = true;
      java.enable = true;
      html.enable = true;
      css.enable = true;
      sql.enable = true;
      nix.enable = true;
      ts.enable = true;
    };

    keymaps = [
      {
        key = "<leader>ee";
        action = ":Neotree toggle<CR>";
        mode = "n";
        desc = "Toggle Neo-Tree";
      }
    ];
  };
}
