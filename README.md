# edit_alternate.vim

Quickly edit related / alternate files in vim.

## Usage

### Adding rules

Adding rules will provide more ways to get an alternate file for the one you are currently editting. The plugin will run each rule until it finds one that matches, and then it will choose that one and open the file.

For example:

```vim
" Adds a rule to files with the extension "c" to edit the alternative file, ".h"
call edit_alternate#rule#add('c', {filename -> fnamemodify(filename, ':r') . '.h'})
```

The rule must be a function that takes one argument, the filename, and then returns a string pointing to the potential alternate file

### Current File

If you are working on a `.c`/`.cpp` file, it will switch you to the `.h` with the same name. If you are working on a `.h` file, it will switch you to either the `.c` or `.cpp` file that goes with that file as well. It figures it out ;)

You can add the mapping to easily use edit alternate

```vim
nnoremap <leader>ea :EditAlternate<CR>
```

### Nonexistent Files

Consider:

```
my_folder/
-> main.c
-> util.c
-> util.h
```

You now run the command

```
:e my_folder/ut<TAB>
```

You'll get completed

```
:e my_folder/util.
```

because there is a `.c` and a `.h` file in the same directory... but I'll just press enter right away anyway.

Now, you can just do:

```vim
" :EditOops
nnoremap <leader>eo :EditOops<CR>
```

This will make it so that you default open the `.c` file instead.
