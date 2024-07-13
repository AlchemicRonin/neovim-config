-- Customize Treesitter

---@type LazySpec
return {
    "nvim-treesitter/nvim-treesitter",
    opts = {
        ensure_installed = {
            "lua",
            "vim",
            "vimdoc",
            "markdown",
            "markdown_inline",
            "python",
            "yaml",
            "json",
            "rust",
            "go",
            "css",
            "html",
            "javascript",
            "typescript",
            "gitignore",
            "c",
            "cpp",
            "cmake",
            "bash",
            "dockerfile",
            -- add more arguments for adding more treesitter parsers
        },
    },
}
