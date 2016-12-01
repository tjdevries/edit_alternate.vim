# Edit Alternate

Set alternate files easily with vimscript.

Use command `:EditAlternate`. Currently just C file endings are supported.

More documentation to come.

## Oops!

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

And then you'll of course press enter... because you expect to open a file.

Now, you can just do:

```
:EditOops
```

And you'll be editing `my_folder/util.c`.
