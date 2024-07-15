vim.cmd([[
  hi Cursor0 guibg=#00ff00 guifg=#000000
  set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff600-blinkon600-Cursor0/lCursor0,sm:block-blinkwait175-blinkoff150-blinkon175
]])

if vim.g.neovide then
    vim.keymap.set("n", "<D-s>", ":w<CR>")      -- Save
    vim.keymap.set("v", "<D-c>", '"+y')         -- Copy
    vim.keymap.set("n", "<D-v>", '"+P')         -- Paste normal mode
    vim.keymap.set("v", "<D-v>", '"+P')         -- Paste visual mode
    vim.keymap.set("c", "<D-v>", "<C-R>+")      -- Paste command mode
    vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode
end

-- Allow clipboard copy paste in neovim
vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })

if not vim.g.neovide then
    return {} -- do nothing if not in a Neovide session
end

return {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
        options = {
            opt = { -- configure vim.opt options
                -- configure font
                guifont = "JetbrainsMono Nerd Font:h14",
                -- line spacing
                linespace = 0,
            },
            g = { -- configure vim.g variables
                -- configure scaling
                neovide_scale_factor = 1.0,
                -- configure padding
                neovide_padding_top = 0,
                neovide_padding_bottom = 0,
                neovide_padding_right = 0,
                neovide_padding_left = 0,

                neovide_hide_mouse_when_typing = true,
                neovide_cursor_vfx_mode = "ripple",
                -- neovide_transparency = 0.9,
            },
        },
    },
}
