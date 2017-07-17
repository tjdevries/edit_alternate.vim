function! s:get_extension(args) abort
  if len(a:args) > 0
    return a:args[0]
  else
    return expand('%:e')
  endif
endfunction

let s:configuration = get(s:, 'configuration', {})

""
" Function to add rules for switching files
" Example:
"   call edit_alternate#rule#add('c', {filename -> fnamemodify(filename, ':r') . '.h'})
function! edit_alternate#rule#add(extension, rule) abort
  if type(a:extension) == v:t_string
    let extension_list = [a:extension]
  else
    let extension_list = a:extension
  endif

  for single_extension in extension_list
    if !has_key(s:configuration, single_extension)
      let s:configuration[single_extension] = []
    endif

    call add(s:configuration[single_extension], a:rule)
  endfor
endfunction

function! edit_alternate#rule#get(...) abort
  let extension = s:get_extension(a:000)

  if !has_key(s:configuration, extension)
    return []
  else
    return s:configuration[extension]
  endif
endfunction

function! edit_alternate#rule#clear(...) abort
  let extension = s:get_extension(a:000)

  unlet s:configuration[extension]
endfunction

function! edit_alternate#rule#default() abort
  call edit_alternate#rule#add('c', {filename -> fnamemodify(filename, ':r') . '.h'})
  call edit_alternate#rule#add('cpp',
        \ {filename ->
          \ fnamemodify(filename, ':r')
          \ . edit_alternate#util#h_or_hpp_header(filename)
          \ }
        \ )
  call edit_alternate#rule#add(['h', 'hpp'],
        \ {filename ->
          \ fnamemodify(filename, ':r')
          \ . edit_alternate#util#c_or_cpp_header(filename)
          \ }
        \ )
endfunction
