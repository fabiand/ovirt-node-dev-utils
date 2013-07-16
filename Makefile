
help:
	@echo ""
	@echo " Usage"
	@echo " ====="
	@echo ""
	@echo " Bulding"
	@echo " -------"
	@echo "$(MAKE) rpms         - Build packages"
	@echo "$(MAKE) iso          - Build packages and an ISO afterwards"
	@echo "$(MAKE) relocate-iso - Move the ISO into the CWD"
	@echo ""
	@echo "$(MAKE) release WITH_RELEASE=<major>.<minor> WITH_BUILDNUMBER=<n> - Do a release build"
	@echo "$(MAKE) make-release-tarball - Bundle all release related files into one tarball
	@echo ""
	@echo " Workspace"
	@echo " ---------"
	@echo "$(MAKE) clone-repos                - Clone ovirt-node and ovirt-node-iso repo into CWD"
	@echo "$(MAKE) install-build-requirements - Install the packages required to build everything"
	@echo ""
	@echo " Debugging"
	@echo " ---------"
	@echo "$(MAKE) run-iso-in-qemu iso=<isofilename>"
	@echo ""

include makefile.workspace
include makefile.build
include makefile.debug
