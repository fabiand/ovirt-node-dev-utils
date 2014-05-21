
usage() {
echo "$0 [> edit-node-el6.repo]"
echo "Prints the repos needed to add VDSM to a oVirt Node Base Image"
}

[ "$1" = "-h" ] && { usage ; exit 1 ; }

cpiocat() { cpio --quiet --to-stdout -i $@ ; }
rpmcat() { RPM=$1 ; shift 1 ; rpm2cpio $RPM | cpiocat $@ ; }

debug_comment() {
cat <<EOF
#
# This repofiles was created automatically on $(date)
# $0 $@
#

EOF
}

#
# Node
#
base_repo() {
cat <<EOF
[node-base]
Name=oVirt Node Base Image packages
baseurl=http://ovirt.org/releases/node-base/3.0.0/rpm/EL/6/
gpgcheck=0

EOF
}


#
# vdsm-plugin
#
vdsm_plugin_repo() {
curl -s http://copr.fedoraproject.org/coprs/fabiand/ovirt-node-plugin-vdsm-unofficial/repo/epel-6-x86_64/
echo ""
}

#
# oVirt
#
ovirt_repo() {
rpmcat \
    http://ovirt.org/releases/ovirt-release-el.noarch.rpm \
    ./etc/yum.repos.d/glusterfs-epel.repo \
    ./etc/yum.repos.d/el6-ovirt.repo
}

ovirt33_repo() {
rpmcat \
    http://resources.ovirt.org/releases/3.3.3/rpm/EL/6/noarch/ovirt-release-el6-10.0.1-3.noarch.rpm \
    ./etc/yum.repos.d/glusterfs-epel.repo \
    ./etc/yum.repos.d/el6-ovirt.repo
}

ovirt34_repo() {
local LATESTRPM=http://resources.ovirt.org/releases/3.4.0-rc2/rpm/EL/6/noarch/ovirt-release-11.1.0-1.noarch.rpm
rpmcat \
    $LATESTRPM \
    ./usr/share/ovirt-release/ovirt-epel.repo \
    ./usr/share/ovirt-release/glusterfs-epel.repo \
    ./usr/share/ovirt-release/ovirt.repo.in | sed "s/@DIST@/EL/g"
}


#
# Operatingsystem
#
centos_repo() {
rpmcat \
    http://mirror.centos.org/centos/6/os/x86_64/Packages/centos-release-6-5.el6.centos.11.1.x86_64.rpm \
    ./etc/yum.repos.d/CentOS-Base.repo
}

epel_repo() {
cat <<EOF
[epel]
name=Extra Packages for Enterprise Linux 6 - $basearch
baseurl=http://dl.fedoraproject.org/pub/epel/6/\$basearch
failovermethod=priority
enabled=1
gpgcheck=0
EOF
}

fedora_repo() {
rpmcat \
    http://download.fedoraproject.org/fedora/linux/releases/20/Fedora/x86_64/os/Packages/f/fedora-release-20-1.noarch.rpm \
    ./etc/yum.repos.d/fedora.repo \
    ./etc/yum.repos.d/fedora-updates.repo
}

# Output all repos:
{
debug_comment
base_repo
vdsm_plugin_repo
ovirt34_repo
centos_repo
epel_repo
}
