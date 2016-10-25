let g:alternate_configuration = {
    \ 'c': {
      \ 'executable_extension': v:false,
      \ 'alternate_extension': 'h',
      \ 'executable_name': v:true,
      \ 'alternate_name': "expand('%:r') . '.' . alternate_extension",
      \ },
    \ 'cpp': {
      \ 'executable_extension': v:true,
      \ 'alternate_extension': 'edit_alternate#util#h_or_hpp_header()',
      \ 'executable_name': v:true,
      \ 'alternate_name': "expand('%:r') . '.' . alternate_extension",
      \ },
    \ 'h': {
      \ 'executable_extension': v:true,
      \ 'alternate_extension': 'edit_alternate#util#c_or_cpp_header()',
      \ 'executable_name': v:true,
      \ 'alternate_name': "expand('%:r') . '.' . alternate_extension",
      \ },
    \ }

command EditAlternate :call edit_alternate#switch()
