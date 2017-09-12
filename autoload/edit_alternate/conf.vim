if !exists('g:loaded_edit_alternate')
  runtime! plugin/edit_alternate.vim
endif

if g:loaded_edit_alternate == v:null
  echoerr '[edit_alternate] Could not load because of setup issues. Check ":messages"'
  finish
endif

" Prefix to use for this autoload file
let s:autoload_prefix = "edit_alternate#conf"

" Set the name of name of your plugin.
" Here is my best guess
call conf#set_name(s:, 'edit_alternate')

call conf#set_version(s:, [1, 0, 0])

call conf#add_area(s:, 'defaults')
call conf#add_setting(s:, 'defaults', 'enable_default_rules', {
      \ 'default': v:true,
      \ 'type': v:t_bool,
      \ 'description': '(Boolean): Automatically add the default rules provided by the plugin.'
      \ })
call conf#add_setting(s:, 'defaults', 'debug', {
      \ 'default': v:false,
      \ 'type': v:t_bool,
      \ 'description': '(Boolean): Whether to print out debug messages during execution.',
      \ })
call conf#add_setting(s:, 'defaults', 'file_print', {
      \ 'default': v:false,
      \ 'type': v:t_bool,
      \ 'description': '(Boolean): Whether to print the filename on switching.',
      \ })
call conf#add_setting(s:, 'defaults', 'oops_order', {
      \ 'default': ['.c', '.cpp', '.h', '.py'],
      \ 'type': v:t_list,
      \ 'description': '(List): A list of the order of oops files to open',
      \ })

call conf#add_area(s:, 'mappings')
call conf#add_setting(s:, 'mappings', 'EditAlternate', {
      \ 'default': '<leader>ea',
      \ 'type': v:t_string,
      \ 'description': 'Default mapping for `EditAlternate`. Set to "" to disable mapping',
      \ 'action': conf#actions#mapping({'rhs': ':EditAlternate<CR>', 'mode': 'n'}),
      \ })
call conf#add_setting(s:, 'mappings', 'EditOops', {
      \ 'default': '<leader>eo',
      \ 'type': v:t_string,
      \ 'description': 'Default mapping for `EditOops`. Set to "" to disable mapping',
      \ 'action': conf#actions#mapping({'rhs': ':EditOops<CR>', 'mode': 'n'}),
      \ })

""
" edit_alternate#conf#set
" Set a "value" for the "area.setting"
" See |conf.set_setting|
function! edit_alternate#conf#set(area, setting, value) abort
  return conf#set_setting(s:, a:area, a:setting, a:value)
endfunction


""
" edit_alternate#conf#get
" Get the "value" for the "area.setting"
" See |conf.get_setting}
function! edit_alternate#conf#get(area, setting) abort
  return conf#get_setting(s:, a:area, a:setting)
endfunction


""
" edit_alternate#conf#view
" View the current configuration dictionary.
" Useful for debugging
function! edit_alternate#conf#view() abort
  return conf#view(s:)
endfunction


""
" edit_alternate#conf#menu
" Provide the user with an automatic "quickmenu"
" See |conf.menu|
function! edit_alternate#conf#menu() abort
  return conf#menu(s:)
endfunction


""
" edit_alternate#conf#generate_docs
" Returns a list of lines to be placed in your documentation
" 0
function! edit_alternate#conf#generate_docs() abort
  return conf#docs#generate(s:, s:autoload_prefix)
endfunction

function! edit_alternate#conf#__sid()
  echo matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
endfunction
