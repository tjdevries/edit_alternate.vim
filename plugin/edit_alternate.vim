command! EditAlternate :call edit_alternate#switch()
command! EditOops :call edit_alternate#fix_oops()

" TODO: Add some variable for this or something?
call edit_alternate#rule#default()
