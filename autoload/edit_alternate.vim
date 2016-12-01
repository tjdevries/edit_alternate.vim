" Option configuration {{{
let s:options = {
      \ 'file_print': v:true,
      \ 'debug': v:false,
      \ }

function! edit_alternate#set_opt_file_print(status) abort
  let s:options['file_print'] = a:status
endfunction

function! edit_alternate#set_debug() abort
    let s:options['debug'] = v:true
endfunction

function! edit_alternate#set_no_debug() abort
    let s:options['debug'] = v:false
endfunction

" The order in which you will open oops files
let g:edit_alternate_file_list = get(g:, 'edit_alternate_file_list', [
      \ '.c',
      \ '.cpp',
      \ '.h',
      \ '.py',
      \ ])
" }}}

""
" Helper function to update the configuration
function! edit_alternate#update_configuration(option) abort
    call extend(g:alternate_configuration, a:option)
endfunction

""
" Helper function to switch between a .c and .h files
function! edit_alternate#switch() abort
  let l:current_extension = expand('%:e')

  if has_key(g:alternate_configuration, l:current_extension)
    let l:configuration = g:alternate_configuration[l:current_extension]
  else
    " Clear the command prompt
    echo ''
    return
  endif

  " If a command is specified, run it.
  " Else, we just take the value
  if has_key(l:configuration, 'executable_extension') && l:configuration['executable_extension']
    let l:alternate_extension = execute(':echon ' . l:configuration['alternate_extension'])
  else
    let l:alternate_extension = l:configuration['alternate_extension']
  endif

  if has_key(l:configuration, 'executable_name') && l:configuration['executable_name']
    let l:alternate_name = execute(':echon ' . l:configuration['alternate_name'])
  else
    let l:alternate_name = l:configuration['alternate_name']
  endif

  if s:options['debug']
    echom 'new_run'
    echom 'Ext : ' . l:alternate_extension
    echom 'Name: ' . l:alternate_name
    echom 'Bufn: ' . bufnr(l:alternate_name)
  endif

  if bufnr(l:alternate_name) > 0
    execute(':silent buffer ' . bufnr(l:alternate_name))
  else
    execute(':silent edit ' . l:alternate_name)
  endif

  if s:options['file_print']
    file!
  endif
endfunction

""
" For those `oops` moments
function! edit_alternate#oops(filename, directory_list) abort
  " If it doesn't end with a period, just ignore this.
  " Maybe later add some abilty to have a list of these?
  if a:filename[len(a:filename) - 1] !=# '.'
    return []
  endif

  let l:possible_results = []
  for l:possible_file in a:directory_list
    if matchstr(l:possible_file, '^' . a:filename . '\a*') !=# ''
      call add(l:possible_results, l:possible_file)
    endif
  endfor

  return l:possible_results
endfunction

let s:ending_rankings = [
      \ '.c',
      \ ]

function! edit_alternate#choose_oops(file_list, file_options) abort
  if len(a:file_list) == 1
    return a:file_list[0]
  endif

  for l:ending in g:edit_alternate_file_list
    for l:filename in a:file_list
      if matchstr(l:filename, l:ending . '$') !=# ''
        return l:filename
      endif
    endfor
  endfor

  return ''  
endfunction

function! edit_alternate#fix_oops() abort
  let l:potential_oops = edit_alternate#oops(
        \ expand('%:p'),
        \ split(glob(expand('%:p:h') . '/*'))
        \ )

  if len(potential_oops) > 0
    let l:chosen = edit_alternate#choose_oops(potential_oops, g:edit_alternate_file_list)

    if l:chosen !=# ''
      if bufnr(substitute(l:chosen, getcwd() . '/', '', 'g')) > 0
        execute ':silent buffer ' . bufnr(substitute(l:chosen, getcwd() . '/', '', 'g'))
      else
        execute ':silent e ' . l:chosen
      endif
    endif
  endif
endfunction
