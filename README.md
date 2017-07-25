This demonstrates one way of including a dependency on a binary using Nix, without polluting `PATH`.

# Demonstration
    
    $ nix-build 
    [...]
    /nix/store/plksm4axzclz3dkg5ndqmc42zbpjji9s-it-depends-0.1.0.0
    $ ./result/bin/it-depends 
    Using "/nix/store/q014dgl0kl5l0dhqrzlj7izwjx66v5fz-hello-2.10/bin/hello"
    Hello, world!
    $ which hello
    which: no hello in ([...])

    $ nix-shell
    [nix-shell:...] $ cd it-depends
    [nix-shell:...] $ cabal configure --package-db=clear --package-db=global && cabal repl
    [...]
    *Main> main
    Using "hello"
    Hello, world!
    [...]
    $ which hello
    /nix/store/q014dgl0kl5l0dhqrzlj7izwjx66v5fz-hello-2.10/bin/hello

You can install this package using `nix-env`:

    $ nix-env -i -f .
    $ it-depends
    Using "/nix/store/q014dgl0kl5l0dhqrzlj7izwjx66v5fz-hello-2.10/bin/hello"
    Hello, world!
    $ nix-env -e it-depends

Or you can see the transitive closure of runtime dependencies:

    $ nix-build
    $ nix-store -qR ./result
    [...]
    /nix/store/q014dgl0kl5l0dhqrzlj7izwjx66v5fz-hello-2.10
    [...]
