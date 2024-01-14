" === Look ===
set number
set cursorline
set mousemoveevent
set colorcolumn=121
highlight ColorColumn guibg=gray ctermbg=gray
" Enable True Color
set termguicolors
" The maximum number of items to show in the popup menu
set pumheight=10

" === Control ===
" Allows other files to be opened while buffers are being edited
set hidden
" Scroll margin
set scrolloff=20
" Allow the cursor to move one character beyond the end of line
set virtualedit=onemore
" Allows movement across lines
set whichwrap=b,s,h,l,<,>,[,],~

" === Edit ===
" Copy to clipboard
set clipboard=unnamedplus
" Remove space at the end of line when saving
autocmd BufWritePre * :%s/\s\+$//ge
" Place the cursor at the last position of the last time when opening file
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END
" undo
if has('persistent_undo')
  set undodir=~/.config/nvim/undo
  set undofile
endif
" Don't create backupfiles
set nobackup
" Don't create swapfiles
set noswapfile

" === Tab ===
" Show Tab with ▸-
set list listchars=tab:\▸\-
" Make Tab half-width space
set expandtab
" The number of space as Tab
set tabstop=4
set softtabstop=4
" Indent size when shifting text
set shiftwidth=4
" Auto indent size
set autoindent
set smartindent
set cindent

" === Search ===
" Ignore upper and lower case letters when searching
set ignorecase
" Normal search
set smartcase
