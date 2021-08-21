# yaclt.nvim

A Neovim plugin for [Yaclt](https://github.com/mrjones2014/yaclt).

## Installation

### Packer

```lua
use {'mrjones2014/yaclt.nvim', requires = 'nvim-lua/plenary.nvim'}
```

### Vim Plug

```VimL
Plug 'nvim-lua/plenary.nvim'
Plug 'mrjones2014/yaclt.nvim'
```

## Configuration

Configure the plugin by using the setup function. Not required if you want to use a globally installed
`yaclt` without default arguments and don't want to set the Nvim commands up.

Defaults:

```lua
require('yaclt').setup({
  cmd = 'yaclt', -- can also change this to ./node_modules/.bin/yaclt to use a version from package.json
  args = {}, -- you can specify default args here that will be passed to yaclt, e.g. { '--changeType', 'NEW' }
})
```

## API

For `yaclt` command arguments and documentation, see [Yaclt docs](https://github.com/mrjones2014/yaclt/blob/master/COMMANDS.md).

### Lua

```lua
require('yaclt').new(args) -- e.g. require('yaclt').new({ '--changeType', 'NEW', '-m', 'Message here' })

require('yaclt').validate(args)

require('yaclt').prepareRelease(args) -- e.g. require('yaclt').prepareRelease({ '--releaseNumber', '0.5.0' })
```

### Nvim Commands

```VimL
" runs :lua require('yaclt').new()
:YacltNew

" runs :lua require("yaclt").validate()
:YacltValidate

" runs :lua require("yaclt").prepareRelease()
:YacltPrepareRelease
```
