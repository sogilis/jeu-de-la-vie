Linkopts Makefile
=================

This is a Makefile generator that detect all the project logic from code that
is in the source files themselves. Credit for the idea to
[Caleb James DeLisle](https://github.com/cjdelisle) in the
[cjdns project](https://github.com/cjdelisle/cjdns).

Usage
=====

Usage is simple, just copy the linkopts directory. Then create a `GNUMakefile`
with:

    include linkopts/gendeps.make

    include src/main.D
    ...

You just have to include `gendeps.make`, then you include the `.D` file
corresponding to your source file containing the `main()` routing. In the
previous example, this will create a target called `src/main`.

Declaring the linked files is done in the source code itself. For example, if
`main.c` makes use of `util.c` via a header file in `util.h`, you should put in
`util.h`:

    #include <linkopts.h>

    LINK_SOURCE("util.c")

This tells `make` that any file that is including `util.h` should also be built
with `util.c`.