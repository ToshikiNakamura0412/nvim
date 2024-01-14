" Automatic vim-plug installation
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent execute '!curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" Run :PlugInstall if any plugins are missing
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" List of plugins
call plug#begin('~/.local/share/nvim/plugged')
" colorscheme
Plug 'tomasr/molokai'
Plug 'EdenEast/nightfox.nvim'
" statusline
Plug 'nvim-lualine/lualine.nvim'
" bufferline
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
" filer
Plug 'nvim-tree/nvim-tree.lua'
" fuzzy finder
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }
Plug 'nvim-lua/plenary.nvim'
" highlight
Plug 'sheerun/vim-polyglot'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'luochen1990/rainbow'
Plug 'Yggdroot/indentLine'
Plug 'echasnovski/mini.indentscope'
Plug 'machakann/vim-highlightedyank'
" coding
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'kylechui/nvim-surround'
" debug
Plug 'sentriz/vim-print-debug'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }
Plug 'skanehira/translate.vim'
" git
Plug 'NeogitOrg/neogit'
Plug 'sindrets/diffview.nvim'
Plug 'lewis6991/gitsigns.nvim'
" icon
Plug 'nvim-tree/nvim-web-devicons'
" terminal
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
call plug#end()
let g:coc_global_extensions = [
    \'coc-lists',
    \'coc-snippets',
    \'coc-sh',
    \'coc-cmake',
    \'coc-jedi',
    \'coc-yaml',
    \'coc-vimlsp',
    \]
