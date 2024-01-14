colorscheme molokai

" === vim-polyglot ===
let g:cpp_member_highlight = 1
let g:cpp_simple_highlight = 1

" === vim-cpp-enhanced-highlight ===
let g:cpp_class_scope_highlight = 1

" === rainbow ===
let g:rainbow_active = 1

" === vim-print-debug ===
let g:print_debug_templates = {
\   'python': 'print(f"+++ {}")',
\   'cpp':    'std::cout << "+++ " << __LINE__ << " {}" << std::endl;',
\ }

" === gitgutter ===
highlight GitGutterDelete guifg=#EB0A13 ctermfg=1
highlight GitGutterAdd    guifg=#AEC90B ctermfg=2
highlight GitGutterChange guifg=#FB8505 ctermfg=3

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

--- === nvim-tree ===
require'nvim-tree'.setup {  }

-- === telescope ===
require'telescope'.setup {  }

-- === mini.indentscope ===
require'mini.indentscope'.setup { symbol = '▏' }

--- === nvim-surround ===
require'nvim-surround'.setup {  }

-- === neogit ===
require'neogit'.setup {  }

-- === diffview ===
require'diffview'.setup { }

-- === gitsigns ===
require'gitsigns'.setup {  }

-- === toggleterm ===
require'toggleterm'.setup {  }
END
