if !exists('g:loaded_edit_alternate')
  runtime! plugin/edit_alternate.vim
endif

if g:loaded_edit_alternate == v:null
  echoerr '[edit_alternate] Could not load because of setup issues. Check ":messages"'
  finish
endif

""
" Helper function to update the configuration
function! edit_alternate#update_configuration(option) abort
    call extend(g:alternate_configuration, a:option)
endfunction

""
" Helper function to switch between a .c and .h files
function! edit_alternate#switch() abort
  let l:current_extension = expand('%:e')

  let l:configuration = edit_alternate#rule#get(l:current_extension)

  for Rule in l:configuration
    let current_name = ''

    " TODO: Support other options?
    if type(Rule) == v:t_func
      let current_name = Rule(expand('%:p'))
    endif

    if edit_alternate#conf#get('defaults', 'debug')
      echo '[EditAlternate] Attempt: ' . current_name
    endif

    if !filereadable(current_name)
      continue
    endif

    let alternate_name = current_name

    if edit_alternate#conf#get('defaults', 'debug')
      echo '[EditAlternate] Chosen:'
      echo 'Name: ' . alternate_name
      echo 'Bufn: ' . bufnr(alternate_name)
    endif

    if bufnr(alternate_name) > 0
      execute(':silent buffer ' . bufnr(alternate_name))
    else
      execute(':silent edit ' . alternate_name)
    endif

    if edit_alternate#conf#get('defaults', 'file_print')
      file!
    endif

    return alternate_name
  endfor

  echo '[EditAlternate] No applicable rules found for ' . l:current_extension
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

  for l:ending in edit_alternate#conf#get('defaults', 'oops_order')
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
    let l:chosen = edit_alternate#choose_oops(potential_oops, edit_alternate#conf#get('defaults', 'oops_order'))

    if l:chosen !=# ''
      if bufnr(substitute(l:chosen, getcwd() . '/', '', 'g')) > 0
        execute ':silent buffer ' . bufnr(substitute(l:chosen, getcwd() . '/', '', 'g'))
      else
        execute ':silent e ' . l:chosen
      endif
    endif
  endif
endfunction
