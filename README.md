ovirt-node-dev-utils
====================

A couple of tools for developing and releasing oVirt Node


makefile.build
--------------
This makefile provides a couple of targets to build the packages and ISO.

To get started and build an ISO:

    # Create some workspace
    $ mkdir node-ws
    $ pushd node-ws

    # Clone this repository
    $ git clone https://github.com/fabiand/ovirt-node-dev-utils.git dev-utils

    # ... install some build requirements
    $ make -f dev-utils/makefile.build install-build-requirements clone-repos

    # ... and build the ISO
    $ make iso
