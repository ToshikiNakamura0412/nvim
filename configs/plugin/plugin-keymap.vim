" get osname
let osnameline = system('grep PRETTY /etc/os-release')
let osnameinfos = split(osnameline, " ")
let osname = substitute(osnameinfos[0],"PRETTY_NAME=\"","","g")


" filer
if has('nvim-0.9')
  " === nvim-tree ===
  nnoremap <silent><C-e> <Cmd>NvimTreeToggle<CR>
else
" === nerdtree ===
  nnoremap <silent><C-e> :NERDTreeToggle<CR>
endif

" === telescope ===
nnoremap <silent>ff <Cmd>Telescope find_files<CR>
nnoremap <silent>fg <Cmd>Telescope live_grep<CR>

" === vim-print-debug ===
nnoremap <silent>dp <Cmd>call print_debug#print_debug()<CR>

" === diffview ===
nnoremap <silent>gd <Cmd>DiffviewOpen<CR>

" === toggleterm ===
nnoremap <silent><C-t> <Cmd>ToggleTerm<CR>


" completion (coc or deoplete)
if osname == "Ubuntu" || osname == "Debian"
  " === coc ===
  " No line break on Enter in completion candidate display
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : '<CR>'
  " Select a candidate for completion by Tab/Shift-Tab
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
  endfunction
  inoremap <silent><expr> <TAB>  coc#pum#visible() ? coc#pum#next(1): <SID>check_back_space() ? '<Tab>'  : coc#refresh()
  inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : '<S-Tab>'
  " Others
  nnoremap <silent>H : <C-u>call CocAction('doHover') <CR>
  nnoremap <silent>df  <Plug>(coc-definition)
  nnoremap <silent>rf  <Plug>(coc-references)
  nnoremap <silent>rn  <Plug>(coc-rename)
  nnoremap <silent>fmt <Plug>(coc-format)
  nnoremap <silent>mne <Plug>(coc-diagnostic-next-error)
  nnoremap <silent>mpe <Plug>(coc-diagnostic-prev-error)
endif
