ovirt-node-dev-utils
====================

A couple of tools for developing and releasing oVirt Node


makefile.build
--------------
This makefile provides a couple of targets to build the packages and ISO.

To get started and build an ISO:

    # Pre-requirements
    $ yum install -y make git

    # Create some workspace
    $ mkdir node-ws
    $ pushd node-ws

    # Clone this repository
    $ git clone https://github.com/fabiand/ovirt-node-dev-utils.git dev-utils
    $ cd dev-utils

    # ... install some build requirements
    $ make install-build-requirements

    $ popd
    $ make -f dev-utils/Makefile clone-repos

    # ... and build the ISO
    $ make -f dev-utils/Makefile iso

    # ... run the iso in qemu
    $ make -f dev-utils/Makefile \
        run-iso-in-qemu iso=$(ls -1 ovirt-node-iso/*.iso)
