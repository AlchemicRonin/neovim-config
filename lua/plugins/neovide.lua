vim.cmd([[
  hi Cursor0 guibg=#00ff00 guifg=#000000
  set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff600-blinkon600-Cursor0/lCursor0,sm:block-blinkwait175-blinkoff150-blinkon175
]])

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
