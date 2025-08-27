" get osname
if has('linux')
  let osnameline = system('grep PRETTY /etc/os-release')
  let osnameinfos = split(osnameline, " ")
  let osname = substitute(osnameinfos[0],"PRETTY_NAME=\"","","g")
elseif has('mac')
  let osname = "Mac"
endif

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
if has('nvim-0.9')
  Plug 'nvim-tree/nvim-tree.lua'
else
  Plug 'preservim/nerdtree'
endif
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
if index(['Mac', 'Ubuntu', 'Debian'], osname) != -1
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'github/copilot.vim'
else
  if has('python3')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'deoplete-plugins/deoplete-jedi'
  endif
endif
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'kylechui/nvim-surround'
" debug
Plug 'sentriz/vim-print-debug'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }
Plug 'skanehira/translate.vim'
" git
Plug 'sindrets/diffview.nvim'
Plug 'lewis6991/gitsigns.nvim'
" icon
Plug 'nvim-tree/nvim-web-devicons'
" terminal
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
call plug#end()
if index(['Mac', 'Ubuntu', 'Debian'], osname) != -1
  let g:coc_global_extensions = [
      \'coc-lists',
      \'coc-snippets',
      \'coc-pyright',
      \]
endif
