-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.pack.lua" },
    { import = "astrocommunity.pack.markdown" },
    { import = "astrocommunity.pack.python-ruff" },
    { import = "astrocommunity.pack.yaml" },
    { import = "astrocommunity.pack.json" },
    { import = "astrocommunity.pack.toml" },
    { import = "astrocommunity.pack.rust" },
    { import = "astrocommunity.pack.go" },
    { import = "astrocommunity.pack.html-css" },
    { import = "astrocommunity.pack.typescript" },
    { import = "astrocommunity.pack.cmake" },
    { import = "astrocommunity.pack.cpp" },
    { import = "astrocommunity.pack.bash" },
    { import = "astrocommunity.pack.docker" },

    { import = "astrocommunity.recipes.vscode" },
    { import = "astrocommunity.recipes.neovide" },
    { import = "astrocommunity.recipes.heirline-nvchad-statusline" },

    { import = "astrocommunity.debugging.nvim-bqf" },

    { import = "astrocommunity.git.git-blame-nvim" },

    { import = "astrocommunity.editing-support.treesj" },

    { import = "astrocommunity.diagnostics.trouble-nvim" },

    { import = "astrocommunity.motion.flash-nvim" },
    { import = "astrocommunity.motion.nvim-surround" },

    { import = "astrocommunity.scrolling.neoscroll-nvim" },

    { import = "astrocommunity.completion.copilot-cmp" },

    { import = "astrocommunity.colorscheme.tokyonight-nvim" },
    { import = "astrocommunity.colorscheme.gruvbox-nvim" },

    { import = "astrocommunity.markdown-and-latex.vimtex" },
    { import = "astrocommunity.markdown-and-latex.markdown-preview-nvim" },
    -- import/override with your plugins folder
}
