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
Plug 'tomasr/molokai', { 'branch': 'master', 'depth': 1 }
Plug 'EdenEast/nightfox.nvim', { 'branch': 'main', 'depth': 1 }
" statusline
Plug 'nvim-lualine/lualine.nvim', { 'branch': 'master', 'depth': 1 }
" bufferline
Plug 'akinsho/bufferline.nvim', { 'branch': 'main', 'depth': 1 }
" filer
Plug 'nvim-tree/nvim-tree.lua', { 'branch': 'master', 'depth': 1 }
" highlight
Plug 'sheerun/vim-polyglot', { 'branch': 'master', 'depth': 1 }
Plug 'octol/vim-cpp-enhanced-highlight', { 'branch': 'master', 'depth': 1 }
Plug 'luochen1990/rainbow', { 'branch': 'master', 'depth': 1 }
Plug 'Yggdroot/indentLine', { 'branch': 'master', 'depth': 1 }
Plug 'echasnovski/mini.indentscope', { 'branch': 'main', 'depth': 1 }
Plug 'machakann/vim-highlightedyank', { 'branch': 'master', 'depth': 1 }
" coding
if index(["Mac", 'Ubuntu', 'Debian'], osname) != -1
  Plug 'neoclide/coc.nvim', {'branch': 'release', 'depth': 1 }
  Plug 'github/copilot.vim'
else
  if has('python3')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'deoplete-plugins/deoplete-jedi'
  endif
endif
Plug 'honza/vim-snippets', { 'branch': 'master', 'depth': 1 }
Plug 'tpope/vim-commentary', { 'branch': 'master', 'depth': 1 }
Plug 'jiangmiao/auto-pairs', { 'branch': 'master', 'depth': 1 }
Plug 'kylechui/nvim-surround', { 'branch': 'main', 'depth': 1 }
" debug
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }
Plug 'skanehira/translate.vim', { 'branch': 'master', 'depth': 1 }
" git
Plug 'lewis6991/gitsigns.nvim', { 'branch': 'main', 'depth': 1 }
" icon
Plug 'nvim-tree/nvim-web-devicons', { 'branch': 'master', 'depth': 1 }
call plug#end()
if index(['Mac', 'Ubuntu', 'Debian'], osname) != -1
  let g:coc_global_extensions = [
      \'coc-lists',
      \'coc-snippets',
      \'coc-pyright',
      \]
endif
