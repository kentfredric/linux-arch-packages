__[ data ]__
{
  cpan_distname => 'Test-File-ShareDir'      =>,
  cpan_author   => KENTNL                 =>,
  cpan_version  => '0.3.3'                =>,
  pkgver        => '0.3.3'                =>,
}
__[ configure_requires ]__
Module::Build 0.4004
__[ build_requires     ]__
Module::Build 0.4004
__[ runtime_requires   ]__
Carp 0
File::Copy::Recursive 0
File::ShareDir 1.00
File::Temp 0
perl 5.006
strict 0
warnings 0
__[ test_requires      ]__
Cwd 0
File::Find 0
FindBin 0
Test::Fatal 0
Test::More 0.98
__[ template ]__
# Maintainer : Kent Fredric <kentnl@cpan.org>
# Note: This file is generated from a template with a little instrumentation
#       to avoid weird quirks of bash occurring with advanced substitution.
#       For ease of maintenance, please modify the source file PKGBUILD.tpl
#       https://github.com/kentfredric/linux-arch-packages/tree/master/mine
#
[% arch.describe %]

pkgrel='1'
pkgdesc='Create a Fake ShareDir for your modules for testing'
sha512sums=('c2155cab89eb9a19ce045873b49236cd150432971ad5b41f19b6274dc43abb947428f6c996df9b23a7629c8bbf3a6ca6cbed06f3323f928b652a3df14b429d5c')
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
