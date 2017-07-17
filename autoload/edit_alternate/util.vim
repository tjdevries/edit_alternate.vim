
""
" Helper function for determining if a file is a cpp header or a c header
" Assumes you are using a .h file
function! edit_alternate#util#c_or_cpp_header(filename) abort
  if filereadable(fnamemodify(a:filename, ':r') . '.cpp')
    return '.cpp'
  else
    return '.c'
  endif
endfunction

""
" Helper function for determining if a file is a hpp header or a h header
function! edit_alternate#util#h_or_hpp_header(filename) abort
  if filereadable(fnamemodify(a:filename, ':r') . '.hpp')
    return '.hpp'
  else
    return '.h'
  endif
endfunction


function! edit_alternate#util#change_folder(filename, folder, extension) abort
  return fnamemodify(a:filename, ':h:h'),
        \ . '/' . a:folder . '/'
        \ . fnamemodify(a:filename, ':t:r') . '.' . a:extension
endfunction
