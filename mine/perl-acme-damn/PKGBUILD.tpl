__[ data ]__
{
  cpan_distname => 'Acme-Damn'      =>,
  cpan_author   => 'IBB'            =>,
  cpan_version  => '0.05'           =>,
  pkgver        => '0.05'           =>,
}
__[ configure_requires ]__
ExtUtils::MakeMaker 0
__[ build_requires     ]__
ExtUtils::MakeMaker 0
__[ runtime_requires   ]__
Test::Exception 0
Test::More 0
__[ test_requires      ]__
__[ template ]__
# Maintainer : Kent Fredric <kentnl@cpan.org>
# Note: This file is generated from a template with a little instrumentation
#       to avoid weird quirks of bash occurring with advanced substitution.
#       For ease of maintenance, please modify the source file PKGBUILD.tpl
#       https://github.com/kentfredric/linux-arch-packages/tree/master/mine
#
[% arch.describe %]

pkgrel='4'
pkgdesc="'Unbless' Perl objects"
sha512sums=('19b46816adbd7087cbffb6bca8437051a888f9e81fca8b033eac4c906a67e4695690adf7cf8333c066cbb3d7045b6ae086daf0e64f0dcd06c5b0226fe02b4409')
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
