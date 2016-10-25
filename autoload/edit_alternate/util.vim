
""
" Helper function for determining if a file is a cpp header or a c header
" Assumes you are using a .h file
function! edit_alternate#util#c_or_cpp_header() abort
  if filereadable(expand('%:r' . '.cpp'))
    return 'cpp'
  else
    return 'c'
  endif
endfunction

""
" Helper function for determining if a file is a hpp header or a h header
function! edit_alternate#util#h_or_hpp_header() abort
  if filereadable(expand('%:r' . '.hpp'))
    return 'hpp'
  else
    return 'h'
  endif
endfunction
