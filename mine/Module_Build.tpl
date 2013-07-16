__[ data ]__
{
  cpan_distname => 'String-Sections'      =>,
  cpan_author   => KENTNL                 =>,
  cpan_version  => '0.2.2'                =>,
}
__[ configure_requires ]__
Module::Name  version
__[ build_requires     ]__
Module::Name  version
__[ runtime_requires   ]__
Module::Name  version
__[ test_requires      ]__
Module::Name  version
__[ template ]__
# Maintainer : Kent Fredric <kentnl@cpan.org>
# Note: This file is generated from a template with a little instrumentation
#       to avoid weird quirks of bash occurring with advanced substitution.
#       For ease of maintenance, please modify the source file PKGBUILD.tpl
#       https://github.com/kentfredric/linux-arch-packages/tree/master/mine
#
[% arch.describe %]

pkgrel='1'
pkgdesc=''
sha512sums=()
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
