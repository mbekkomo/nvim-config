# nvim-config
my neovim config \*0\*

## how to use
*"it's as shrimple as that"*
```bash
# clone the repo into $HOME/.config as nvim
git clone https://github.com/UrNightmaree/nvim-config $HOME/.config/nvim
# make sure $HOME/.config is exist and is a directory

# setup the config
$HOME/.config/nvim/init-config.sh
# if successed, there should be an instruction to reload
# your shell with exec
# if not and the output shows unsupported shell, follow the
# instruction to set the environment variable, ex: in nushell,
# use `let-env` to set environment variable

# open nvim and wait lazy.nvim to install all plugin
nvim
```

## how to tweak config
before tweaking the config, you need to know that `$NVIMLUA` and `$NVIMAFTERLUA` is a different directories.
`$NVIMLUA` contains lua files that is used before plugin load, while
`$NVIMAFTERLUA` contains lua files that is used after plugin load.

for example, `$NVIMAFTERLUA/cooline.lua` is loaded after galaxyline.nvim loaded by lazy. while `$NVIMLUA/vim-conf.lua` is loaded before any plugins loaded.

now to the main part. for example, you want to change the colorscheme to tokyonight because you dont want catppuccin as your colorscheme. to change it, open `$NVIMLUA/pm.lua` and search for array containing `catppuccin/nvim` string. remove `; name = "catppuccin"` and replace code inside `config` with one that is instructed in tokyonight readme
