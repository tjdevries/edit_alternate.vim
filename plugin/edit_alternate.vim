
let s:has_quickmenu = get(s:, 'has_quickmenu', stridx(&runtimepath, 'quickmenu.vim') >= 0)
let s:has_confvim = get(s:, 'has_confvim', stridx(&runtimepath, 'conf.vim') >= 0)
let s:has_standardvim = get(s:, 'has_standardvim', stridx(&runtimepath, 'standard.vim') >= 0)

let g:loaded_edit_alternate = v:null

if !s:has_confvim
  echoerr '[EDIT_ALTERNATE] EditAlternate requires "tjdevries/conf.vim". Please install it'
  finish
endif

if !conf#runtime#require([0, 9, 0])
  echoerr '[EDIT_ALTERNATE] Please update "tjdevries/conf.vim".'
  finish
endif

if !s:has_standardvim
  echoerr '[EDIT_ALTERNATE] EditAlternate requires the plugin "tjdevries/standard.vim". Please install it'
  finish
endif

if !std#info#require([1, 0, 0])
  echoerr '[EDIT_ALTERNATE] Please update "tjdevries/standard.vim".'
  finish
endif

let g:loaded_edit_alternate = v:true


command! EditAlternate :call edit_alternate#switch()
command! EditOops :call edit_alternate#fix_oops()

" TODO: Add some variable for this or something?
if edit_alternate#conf#get('defaults', 'enable_default_rules')
  call edit_alternate#rule#default()
endif
