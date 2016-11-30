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

Many times while editting, I'll do something like:

`:e mydir/my_fi<TAB>`

and it will complete to:

`:e mydir/my_file.`

because there is a `.c` and a `.h` file in the same directory... but I'll just press enter right away anyway.

This will make it so that you default open the `.c` file instead.
