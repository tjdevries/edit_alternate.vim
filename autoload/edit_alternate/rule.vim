function! s:get_extension(args) abort
  if len(a:args) > 0
    return a:args[0]
  else
    return expand('%:e')
  endif
endfunction

let s:configuration = get(s:, 'configuration', {})
let s:named_configuration = get(s:, 'named_configuration', {})

""
" Function to add rules for switching files
" Example:
"   call edit_alternate#rule#add('c', {filename -> fnamemodify(filename, ':r') . '.h'})
function! edit_alternate#rule#add(extension, rule, ...) abort
  let is_named_rule = v:false
  if a:0 > 0
    let is_named_rule = v:true
    let rule_name = a:1
  endif

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

    if is_named_rule
      if !has_key(s:named_configuration, single_extension)
        let s:named_configuration[single_extension] = {}
      endif

      let s:named_configuration[single_extension][rule_name] = len(s:configuration[single_extension]) - 1
    endif
  endfor
endfunction

function! edit_alternate#rule#get(...) abort
  let extension = s:get_extension(a:000)

  let is_named_rule = v:false
  if a:0 > 1
    let is_named_rule = v:true
    let rule_name = a:2
  endif

  if !is_named_rule
    return get(s:configuration, extension, [])
  else
    if !has_key(s:named_configuration, extension)
      return []
    else
      let rule_index = get(s:named_configuration[extension], rule_name, -1)
      if rule_index >= 0
        return s:configuration[extension][rule_index]
      else
        return v:null
    endif
  endif
endfunction

function! edit_alternate#rule#clear(...) abort
  let extension = s:get_extension(a:000)

  let is_named_rule = v:false
  if a:0 > 1
    let is_named_rule = v:true
    let rule_name = a:2
  endif

  if !is_named_rule
    silent! unlet s:configuration[extension]
  else
    silent! unlet s:configuration[extension][s:named_configuration[extension][rule_name]]
    silent! unlet s:named_configuration[extension][rule_name]
  endif

  return v:true
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

function! edit_alternate#rule#reset() abort
  let s:configuration = {}
  let s:named_configuration ={}
endfunction


function! edit_alternate#rule#__get_rules() abort
  return s:configuration
endfunction

function! edit_alternate#rule#__get_names() abort
  return s:named_configuration
endfunction
