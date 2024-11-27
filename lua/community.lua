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
    { import = "astrocommunity.pack.swift" },
    { import = "astrocommunity.pack.kotlin" },
    { import = "astrocommunity.pack.java" },

    { import = "astrocommunity.recipes.vscode" },
    { import = "astrocommunity.recipes.neovide" },
    { import = "astrocommunity.recipes.heirline-nvchad-statusline" },
    { import = "astrocommunity.recipes.astrolsp-no-insert-inlay-hints" },

    { import = "astrocommunity.quickfix.nvim-bqf" },
    { import = "astrocommunity.quickfix.quicker-nvim" },

    { import = "astrocommunity.git.diffview-nvim" },
    { import = "astrocommunity.git.octo-nvim" },

    { import = "astrocommunity.editing-support.suda-vim" },
    { import = "astrocommunity.editing-support.treesj" },
    { import = "astrocommunity.editing-support.zen-mode-nvim" },
    { import = "astrocommunity.editing-support.conform-nvim" },
    { import = "astrocommunity.editing-support.auto-save-nvim" },
    { import = "astrocommunity.editing-support.vim-visual-multi" },
    { import = "astrocommunity.editing-support.nvim-treesitter-context" },
    { import = "astrocommunity.editing-support.bigfile-nvim" },

    { import = "astrocommunity.indent.mini-indentscope" },

    { import = "astrocommunity.workflow.hardtime-nvim" },

    { import = "astrocommunity.diagnostics.trouble-nvim" },

    { import = "astrocommunity.motion.flash-nvim" },
    { import = "astrocommunity.motion.nvim-surround" },

    { import = "astrocommunity.scrolling.neoscroll-nvim" },
    { import = "astrocommunity.scrolling.nvim-scrollbar" },

    { import = "astrocommunity.search.nvim-hlslens" },

    { import = "astrocommunity.syntax.vim-cool" },

    { import = "astrocommunity.completion.copilot-cmp" },

    { import = "astrocommunity.colorscheme.tokyonight-nvim" },
    { import = "astrocommunity.colorscheme.gruvbox-nvim" },
    { import = "astrocommunity.colorscheme.catppuccin" },

    { import = "astrocommunity.markdown-and-latex.vimtex" },
    { import = "astrocommunity.markdown-and-latex.markdown-preview-nvim" },
    { import = "astrocommunity.markdown-and-latex.render-markdown-nvim" },

    { import = "astrocommunity.neovim-lua-development.helpview-nvim" },

    { import = "astrocommunity.game.leetcode-nvim" },

    { import = "astrocommunity.note-taking.obsidian-nvim" },

    { import = "astrocommunity.bars-and-lines.dropbar-nvim" },

    { import = "astrocommunity.register.nvim-neoclip-lua" },
    -- import/override with your plugins folder
}
