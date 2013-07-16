__[ data ]__
{
  cpan_distname => 'aliased'      =>,
  cpan_author   => 'OVID'         =>,
  cpan_version  => '0.31'         =>,
  pkgver        => '0.310'        =>,
}
__[ configure_requires ]__
Module::Build 0.40
__[ build_requires ]__
Test::More 0
__[ template ]__
# Maintainer : Kent Fredric <kentnl@cpan.org>
# Note: This file is generated from a template with a little instrumentation
#       to avoid weird quirks of bash occurring with advanced substitution.
#       For ease of maintenance, please modify the source file PKGBUILD.tpl
#       https://github.com/kentfredric/linux-arch-packages/tree/master/mine
#
[% arch.describe %]

pkgrel='2'
pkgdesc="Use shorter versions of class names."
sha512sums=('3a90100ff85f97bc682d423dc32991c98f7637dd2c14156cf189be437ec7be0b689ea04e12283ad050e0ff854aa76a71a3a977161567fac01e9b7ddffe5b6ccd')
arch=('any')
license=('PerlArtistic' 'GPL')

pkgname='[% arch.pkgname %]'
# normalised version
pkgver='[% arch.pkgver %]'
options=('!emptydirs')
optdepends=()
url='[% arch.metacpan_release %]'
source=('[% arch.primary_src %]')

changelog='ChangeLog'

depends=([% arch.pac_depends_string %])
makedepends=([% arch.pac_makedepends_string %])
checkdepends=([% arch.pac_checkdepends_string %])

[% arch.env %]
build() {
[% arch.mb_build -%]
}
check() {
[% arch.mb_check -%]
}
package() {
[% arch.mb_package -%]
}

# Local Variables:
# mode: shell-script
# sh-basic-offset: 2
# End:
# vim:set ts=2 sw=2 et:
