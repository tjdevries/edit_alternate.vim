" Debug configuration {{{
let s:debug = v:false

function! edit_alternate#set_debug() abort
    let s:debug = v:true
endfunction

function! edit_alternate#set_no_debug() abort
    let s:debug = v:false
endfunction
" }}}
" Option configuration {{{
let s:options = {
      \ 'file_print': v:true,
      \ }

function! edit_alternate#set_opt_file_print(status) abort
  let s:options['file_print'] = status
endfunction
" }}}

""
" Helper function to update the configuration
function! edit_alternate#update_configuration(option) abort
    call extend(g:alternate_configuration, option)
endfunction

""
" Helper function to switch between a .c and .h files
function! edit_alternate#switch() abort
  let current_extension = expand('%:e')

  if has_key(g:alternate_configuration, current_extension)
    let configuration = g:alternate_configuration[current_extension]
  else
    " Clear the command prompt
    echo ''
    return
  endif

  " If a command is specified, run it.
  " Else, we just take the value
  if has_key(configuration, 'executable_extension') && configuration['executable_extension']
    let alternate_extension = execute(':echon ' . configuration['alternate_extension'])
  else
    let alternate_extension = configuration['alternate_extension']
  endif

  if has_key(configuration, 'executable_name') && configuration['executable_name']
    let alternate_name = execute(':echon ' . configuration['alternate_name'])
  else
    let alternate_name = configuration['alternate_name']
  endif

  if s:debug
    echom 'new_run'
    echom 'Ext : ' . alternate_extension
    echom 'Name: ' . alternate_name
    echom 'Bufn: ' . bufnr(alternate_name)
  endif

  if bufnr(alternate_name) > 0
    execute(':silent buffer ' . bufnr(alternate_name))
  else
    execute(':silent edit ' . alternate_name)
  endif

  if s:options['file_print']
    file!
  endif
endfunction
