ocamlczmq
=========

Ocaml binding to the high-level C binding for ØMQ

Building
========

The CZMQ high-level C binding for ØMQ is included as a submodule, hence you need to do a 

    git submodule init
    git submodule update

to get also clone the CZMQ repository. 

Then the usual

    autoconf
    ./configure --with-libzmq=<path to lib/libzmq.so>
    make

will build both CZMQ and the OCaml bindings. 