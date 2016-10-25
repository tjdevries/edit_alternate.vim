
""
" Helper function for determining if a file is a cpp header or a c header
" Assumes you are using a .h file
function! edit_alternate#util#c_or_cpp_header() abort
  if filereadable(expand('%:r' . '.cpp'))
    echon 'cpp'
  else
    echon 'c'
  endif
endfunction
