
let s:has_quickmenu = get(s:, 'has_quickmenu', stridx(&runtimepath, 'quickmenu.vim') >= 0)
let s:has_confvim = get(s:, 'has_confvim', stridx(&runtimepath, 'conf.vim') >= 0)

if !s:has_confvim
  echoerr '[EDIT_ALTERNATE] EditAlternate requires "tjdevries/conf.vim". Please install it'
  finish
endif

command! EditAlternate :call edit_alternate#switch()
command! EditOops :call edit_alternate#fix_oops()

" TODO: Add some variable for this or something?
if edit_alternate#conf#get('defaults', 'enable_default_rules')
  call edit_alternate#rule#default()
endif
