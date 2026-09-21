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

## ESP32 development

[`esp32.nvim`](https://github.com/Aietes/esp32.nvim) provides ESP-IDF build,
flash, monitor, menuconfig, target selection, and Espressif clangd integration.
Launch Neovim from an activated ESP-IDF environment, then run
`:ESPReconfigure` once in the project to generate `build.clang`.

Use `<Leader>r` for the ESP32 command menu and `:ESPInfo` to diagnose the active
ESP-IDF environment, toolchain, compilation database, and LSP configuration.

## STM32 development

The STM32 workflow from
[`segfaultzz/nvim-site`](https://segfaultzz.github.io/nvim-site/) supports
STM32CubeIDE and ARM CMake projects. Use `<Leader>mb` to build, `<Leader>mf` to
build and flash through OpenOCD, `<Leader>md` to build and debug, `<Leader>ma`
to attach to an existing OpenOCD server, `<Leader>mc` to generate or inspect the
compilation database, and `<Leader>mp` for the SVD peripheral viewer.

The integration uses `arm-none-eabi-gcc`, `arm-none-eabi-gdb`, OpenOCD,
`cortex-debug`, and the existing AstroNvim DAP UI. STM32 clangd sessions use the
system clangd and ARM GCC query driver, while ESP-IDF projects continue to use
Espressif clangd.
