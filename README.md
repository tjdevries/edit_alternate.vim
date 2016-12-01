# edit_alternate.vim

Quickly edit related / alternate files in vim.

## Usage

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
