" get osname
if has('linux')
  let osnameline = system('grep PRETTY /etc/os-release')
  let osnameinfos = split(osnameline, " ")
  let osname = substitute(osnameinfos[0],"PRETTY_NAME=\"","","g")
elseif has('mac')
  let osname = "Mac"
endif

" filer
nnoremap <silent><C-e> <Cmd>NvimTreeToggle<CR>

" completion (coc or deoplete)
if index(['Mac', 'Ubuntu', 'Debian'], osname) != -1
  " === coc ===
  " No line break on Enter in completion candidate display
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : '<CR>'
  inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#pum#confirm() : '<Tab>'
  " Select a candidate for completion by Tab/Shift-Tab
  " function! s:check_back_space() abort
  "   let col = col('.') - 1
  "   return !col || getline('.')[col - 1]  =~ '\s'
  " endfunction
  " inoremap <silent><expr> <TAB>  coc#pum#visible() ? coc#pum#next(1): <SID>check_back_space() ? '<Tab>'  : coc#refresh()
  " inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : '<S-Tab>'
  " Select a candidate for completion by Up/Down
  inoremap <expr><Down> coc#pum#visible() ? coc#pum#next(1) : '<Down>'
  inoremap <expr><Up>   coc#pum#visible() ? coc#pum#prev(1) : '<Up>'
  " Others
  nnoremap <silent>H : <C-u>call CocAction('doHover') <CR>
  nnoremap <silent>df  <Plug>(coc-definition)
  nnoremap <silent>rf  <Plug>(coc-references)
  nnoremap <silent>rn  <Plug>(coc-rename)
  nnoremap <silent>fmt <Plug>(coc-format)
  nnoremap <silent>mne <Plug>(coc-diagnostic-next-error)
  nnoremap <silent>mpe <Plug>(coc-diagnostic-prev-error)
endif
