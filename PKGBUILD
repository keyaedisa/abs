# This is an example PKGBUILD file. Use this as a start to creating your own,
# and remove these comments. For more information, see 'man PKGBUILD'.
# NOTE: Please fill out the license field for your package! If it is unknown,
# then please put 'unknown'.

# Maintainer: Your Name <keyaedisa>
pkgname="abs"
pkgver=3.5
pkgrel=60
epoch=
pkgdesc="CLI tool to automate the customization and build of custom and built in distros such as Vanilla Arch and XeroLinux."
arch=('x86_64')
url="https://github.com/keyaedisa/abs"
#license=('')
#groups=()
depends=("git"
		"gawk"
		"sed"
		"archiso"
		"bash")
makedepends=('git')
#checkdepends=()
#optdepends=()
provides=('abs')
#conflicts=('')
#replaces=('')
#backup=()
#options=()
#install=abs.install
#changelog=
source=("gc"::"git+https://github.com/keyaedisa/abs.git")
#noextract=()
#md5sums=()
sha256sums=('SKIP')

package() {
	mkdir -p "${pkgdir}/usr/local/bin/"
	cp "${srcdir}/gc/abs" "${pkgdir}/usr/local/bin/abs"
	mkdir -p "${pkgdir}/etc/abs/"
	cp -rf "${srcdir}/gc/misc/" "${pkgdir}/etc/abs/"
	cp -rf "${srcdir}/gc/options/" "${pkgdir}/etc/abs/"
	rm -rf "../gc"
	rm -r "${srcdir}"
}


