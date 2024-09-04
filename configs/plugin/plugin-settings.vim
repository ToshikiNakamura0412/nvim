" get osname
let osnameline = system('grep PRETTY /etc/os-release')
let osnameinfos = split(osnameline, " ")
let osname = substitute(osnameinfos[0],"PRETTY_NAME=\"","","g")


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

" === vim-print-debug ===
let g:print_debug_templates = {
\   'python': 'print(f"+++ {}")',
\   'cpp':    'std::cout << "+++ " << __LINE__ << " {}" << std::endl;',
\ }

" === gitgutter ===
highlight GitGutterDelete guifg=#EB0A13 ctermfg=1
highlight GitGutterAdd    guifg=#AEC90B ctermfg=2
highlight GitGutterChange guifg=#FB8505 ctermfg=3

if osname != "Ubuntu" && osname != "Debian"
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

-- === telescope ===
require'telescope'.setup {  }

-- === mini.indentscope ===
require'mini.indentscope'.setup { symbol = '▏' }

--- === nvim-surround ===
require'nvim-surround'.setup {  }

-- === diffview ===
require'diffview'.setup { }

-- === toggleterm ===
require'toggleterm'.setup {  }

if vim.fn.has('nvim-0.9') == 1 then
  --- === nvim-tree ===
  require'nvim-tree'.setup {  }

  -- === gitsigns ===
  require'gitsigns'.setup {  }
end

END
