# AstroNvim Template

**NOTE:** This is for AstroNvim v6+

A template for getting started with [AstroNvim](https://github.com/AstroNvim/AstroNvim)

## 🛠️ Installation

#### Make a backup of your current nvim and shared folder

```shell
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

#### Create a new user repository from this template

Press the "Use this template" button above to create a new repository to store your user configuration.

You can also just clone this repository directly if you do not want to track your user configuration in GitHub.

#### Clone the repository

```shell
git clone https://github.com/<your_user>/<your_repository> ~/.config/nvim
```

#### Start Neovim

```shell
nvim
```

## Startup dashboard

Starting Neovim without arguments opens Alpha with the NEOVIM banner. Automatic
session restore is disabled so it does not replace the dashboard. Use `<Leader>h`
to open the home screen or `<Leader>Sl` to restore the last session manually.

## Compatibility

`lua/plugins/copilot-cmp.lua` overrides Copilot's completion-source availability
check to use `client:is_stopped()` on modern Neovim. This avoids the deprecated
dot-call still used upstream without disabling deprecation warnings.
