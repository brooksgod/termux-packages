TERMUX_PKG_HOMEPAGE=https://packages.debian.org/apt
TERMUX_PKG_DESCRIPTION="Front-end for the dpkg package manager"
TERMUX_PKG_DEPENDS="libutil, libcurl, liblzma, dpkg, gpgv, libc++"
TERMUX_PKG_VERSION=1.4.7
TERMUX_PKG_SRCURL=http://ftp.debian.org/debian/pool/main/a/apt/apt_${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=ea2a2e8e08daf8ea11aeaa86928d943a42ce53989165a30cc828838d470b7719
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DPERL_EXECUTABLE=`which perl`
-DCMAKE_INSTALL_FULL_LOCALSTATEDIR=$TERMUX_PREFIX
-DCOMMON_ARCH=$TERMUX_ARCH
-DDPKG_DATADIR=$TERMUX_PREFIX/share/dpkg
-DUSE_NLS=OFF
-DWITH_DOC=OFF
"
TERMUX_PKG_FOLDERNAME=apt-${TERMUX_PKG_VERSION}
TERMUX_PKG_ESSENTIAL=yes
TERMUX_PKG_CONFFILES="etc/apt/sources.list"
TERMUX_PKG_CONFLICTS=apt-transport-https
TERMUX_PKG_REPLACES=apt-transport-https
TERMUX_PKG_RM_AFTER_INSTALL="
bin/apt-cdrom
bin/apt-extracttemplates
bin/apt-mark
bin/apt-sortpkgs
etc/apt/apt.conf.d
lib/apt/apt-helper
lib/apt/methods/bzip2
lib/apt/methods/cdrom
lib/apt/methods/mirror
lib/apt/methods/rred
lib/apt/planners/
lib/apt/solvers/
lib/dpkg/
lib/libapt-inst.so
"

termux_step_post_make_install() {
	printf "# The main termux repository:\ndeb [arch=all,${TERMUX_ARCH}] https://termux.net stable main\n" > $TERMUX_PREFIX/etc/apt/sources.list
        cp $TERMUX_PKG_BUILDER_DIR/trusted.gpg $TERMUX_PREFIX/etc/apt/
	rm /data/data/com.termux/files/usr/include/apt-pkg -r
}
