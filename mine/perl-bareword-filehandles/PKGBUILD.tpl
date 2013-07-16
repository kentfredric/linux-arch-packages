__[ data ]__
{
  cpan_distname => 'bareword-filehandles' =>,
  cpan_author   => 'ILMARI'               =>,
  cpan_version  => '0.003'                =>,
}
__[ configure_requires ]__
B::Hooks::OP::Check 0
ExtUtils::Depends 0
ExtUtils::MakeMaker 6.31
__[ build_requires ]__
Test::More 0.88
__[ runtime_requires ]__
B::Hooks::OP::Check 0
Lexical::SealRequireHints 0
XSLoader 0
__[ template ]__
# Maintainer : Kent Fredric <kentnl@cpan.org>
# Note: This file is generated from a template with a little instrumentation
#       to avoid weird quirks of bash occurring with advanced substitution.
#       For ease of maintenance, please modify the source file PKGBUILD.tpl
#       https://github.com/kentfredric/linux-arch-packages/tree/master/mine
#
[% arch.describe %]

pkgrel='2'
pkgdesc="disables bareword filehandles"
sha512sums=('184c37f737a638a3cfad7657b39918a2aff862faa7c84ef965cc9f2a7c157b05eac732807a0ebb1de44a0ce76b72a96016a126cbba658cddd8230f3de6ab5d8b')
arch=('i686' 'x86_64')
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
[% arch.eumm_build -%]
}
check() {
[% arch.eumm_check -%]
}
package() {
[% arch.eumm_package -%]
}

# Local Variables:
# mode: shell-script
# sh-basic-offset: 2
# End:
# vim:set ts=2 sw=2 et:
