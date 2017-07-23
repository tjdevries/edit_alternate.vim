# edit_alternate.vim

Quickly edit related / alternate files in vim.

Edit alternate uses the concept of `rules` to decide what the "alternate" file should be. By adding your own rules.

It also has a helper to get you to the file that you "meant" to do :smile:

## Usage

### Adding rules

Adding `rules` will provide more ways to get an alternate file for the one you are currently editing.
The plugin will run each rule until it finds one that returns an existing filename,
and then it will choose that one and open the file.

For example:

```vim
" Adds a rule to files with the extension "c" to edit the alternative file, ".h"
call edit_alternate#rule#add('c', {filename -> fnamemodify(filename, ':r') . '.h'})

" Adds a rule to files with the extension ".cpp" to edit the alternative file, ".hpp"
call edit_alternate#rule#add('cpp', {filename -> fnamemodify(filename, ':r') . '.hpp'})

" You can also add a rule to multiple extensions at once
" Just use a list of strings, instead of a single string to do so
call edit_alternate#rule#add(['c', 'cpp'], {filename -> fnamemodify(filename, ':r') . '.h'})
```

The rule must be a function that takes one argument, `filename`, and then returns a string pointing to the potential alternate file. `filename` is guaranteed to be the full path of the current file when running `EditAlternate`.

Rules can be more complicated. This rule checks if there is a header file one folder below the currently edited file. For example, if you were editing `$DIR/src/i2cTask.c` and wanted to switch to `$DIR/include/i2cTask.h`, you could write a rule as follows:

```vim
call edit_alternate#rule#add('c', {filename ->
        \ fnamemodify(filename, ':h:h')
        \ . '/include/'
        \ . 'fnamemodify(filename, ':t:r') . '.h'
        \ })
```


#### Named Rules

It is also possible to give your rule a name, so that you can remove it when desired (for example, leaving a certain project directory, you could add an autocmd to remove the file based on `DirChanged`).

The only difference between named and unnamed rules is specifying a `name` parameter at the end of a rule add call. For example:

```vim
call edit_alternate#rule#add('c', {filename -> fnamemodify(filename, ':r') . '.h'}, 'example_rule')
```

To remove the rule:

```vim
call edit_alternate#rule#clear('c', 'example_rule')
```

And then it won't be evaluated anymore.

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
