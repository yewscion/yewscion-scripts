

# The `yewscion-scripts` README

**A Small Collection of Utility Scripts.**

*Last Updated: 2023-02-21 (W08) 16:00:49 GMT*


# Installation


## GNU Guix

If You use [GNU Guix](https://guix.gnu.org/), this package 
is on [my channel](https://sr.ht/~yewscion/yewscion-guix-channel/).

Once You have it set up, You can just run:

    guix pull
    guix install yewscion-scripts

If You just want to try it out, You can use Guix Shell instead:

    guix shell --pure --rebuild-cache -v4 yewscion-scripts bash guile -- guile

And if You'd rather just try it out without my channel, You can clone this
repo and then do:

    cd yewscion-scripts
    ./cast.sh

Either of these will create a profile with **just** this project in it, to mess around with.


## Source

If You don't want to use [GNU Guix](https://guix.gnu.org/),
You can clone this repo and install it in the normal way:

    git clone https://git.sr.ht/~yewscion/yewscion-scripts
    cd yewscion-scripts
    ./configure
    make
    make check
    make install

If You don't want to use git, or would rather stick with an
actual release, then see the tagged releases for some tarballs
of the source.

The needed dependencies are tracked in the `DEPENDENCIES.txt` file
to support this use case.


# Usage

Full usage is documented in the `doc/yewscion-scripts.info` file. Here are
only generic instructions.

You should be able to access all of
its exported functions in guile by using its modules:

    (use-modules (cdr255 core))

Any binaries or scripts will be available in Your `$PATH`. A list of these
is maintained in the info file. They all also have the `--help` flag, so
if You prefer learning that way, that is also available.


# Contributing

Pull Requests are welcome, as are bugfixes and extensions. Please open
issues as needed. If You contribute a feature, needs to be tests and
documentation.

Development is expected to be done using [GNU Guix](https://guix.gnu.org/).
If You have `guix` set up, You should be able to enter a development
environment with the following:

    cd yewscion-scripts
    guix shell -D -f guix.scm bash --pure

If You've made changes without the above precautions, those changes will
need to be confirmed to work in the above environment before merge.


# License

The `yewscion-scripts` project and all associated files are ©2022 Christopher
Rodriguez, but licensed to the public at large under the terms of the:

[GNU AGPL3.0+](https://www.gnu.org/licenses/agpl-3.0.html) license.

Please see the `LICENSE` file and the above link for more information.

