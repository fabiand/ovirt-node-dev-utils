NODEISO=$1
IMGBASEIMG=$2

in_node() {
guestfish --ro -a $NODEISO run : mount /dev/sda1 / : mount-loop /LiveOS/squashfs.img /isolinux : mount-loop /isolinux/LiveOS/ext3fs.img / : sh "$@" ;
}

in_imgbased() {
guestfish --ro -a $IMGBASEIMG run : mount /dev/HostVG/Image-0.0 / : sh "$@" ;
}

calc() { bc <<<"scale=2;$@" ; }

B_to_MB() { calc "$1/1024/1024" ; }
size_of() { echo $(B_to_MB $(stat -c"%B*%b" $1)) ; }
stats() {
local NUMPKGS=$($1 "rpm -qa | wc -l")
local SIZEPKGS=$(B_to_MB $(( $($1 "rpm -qa --queryformat '%{SIZE} + '"  ; echo -n 0) )) )
local SIZEROOTFS=$(calc $($1 "df --output=used / | tail -n1") / 1024 )
echo $1
echo "  NumPkgs:    $NUMPKGS"
echo "  SizePkgs:   $SIZEPKGS MB"
echo "  SizeRootfs: $SIZEROOTFS MB"
#echo "  Size/Pkg: "$( calc "$SIZEPKGS/$NUMPKGS" )" MB"

eval export $1_NUMPKGS=$NUMPKGS
eval export $1_SIZEPKGS=$SIZEPKGS
eval export $1_SIZEROOTFS=$SIZEROOTFS
}

imgstats() {
echo Image: $1
echo ImageSize: $( size_of $1 ) MB
}

imgstats $NODEISO
stats in_node

echo ""

imgstats $IMGBASEIMG
stats in_imgbased

echo DiffNum:        $(( $in_node_NUMPKGS - $in_imgbased_NUMPKGS ))
echo DiffSizePkgs:   $( bc <<<"scale=2;$in_node_SIZEPKGS-$in_imgbased_SIZEPKGS" )
echo DiffSizeRootfs: $( bc <<<"scale=2;$in_node_SIZEROOTFS-$in_imgbased_SIZEROOTFS" )

