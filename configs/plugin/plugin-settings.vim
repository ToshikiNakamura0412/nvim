" get osname
if has('linux')
  let osnameline = system('grep PRETTY /etc/os-release')
  let osnameinfos = split(osnameline, " ")
  let osname = substitute(osnameinfos[0],"PRETTY_NAME=\"","","g")
elseif has('mac')
  let osname = "Mac"
endif


colorscheme molokai

" === vim-polyglot ===
let g:cpp_member_highlight = 1
let g:cpp_simple_highlight = 1

" === vim-cpp-enhanced-highlight ===
let g:cpp_class_scope_highlight = 1

" === rainbow ===
let g:rainbow_active = 1
let g:rainbow_conf = {
\   'separately': {
\       'cmake': 0,
\   }
\}

" === gitgutter ===
highlight GitGutterDelete guifg=#EB0A13 ctermfg=1
highlight GitGutterAdd    guifg=#AEC90B ctermfg=2
highlight GitGutterChange guifg=#FB8505 ctermfg=3

if index(['Mac', 'Ubuntu', 'Debian'], osname) == -1 && has('python3')
  " === deoplete ===
  let g:deoplete#enable_at_startup = 1
endif


lua << END
-- === lualine ===
require'lualine'.setup {
  options = {
    theme = 'carbonfox',
    path = 2
  }
}

-- === bufferline ===
require'bufferline'.setup {
  options = {
    max_name_length = 30,
    hover = {
      enabled = true,
      delay = 0,
      reveal = {'close'}
    },
  }
}

-- === mini.indentscope ===
require'mini.indentscope'.setup { symbol = '▏' }

-- === nvim-surround ===
require'nvim-surround'.setup {  }

-- === nvim-tree ===
require'nvim-tree'.setup {  }

-- === gitsigns ===
require'gitsigns'.setup {  }
END
