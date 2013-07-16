__[ data ]__
{
  cpan_distname => 'Devel-NYTProf'      =>,
  cpan_author   => 'TIMB'               =>,
  cpan_version  => '5.05'                =>,
}
__[ configure_requires ]__
ExtUtils::MakeMaker 0
__[ build_requires     ]__
ExtUtils::MakeMaker 0
__[ runtime_requires   ]__
Getopt::Long  0
JSON::Any     0
List::Util    0
Test::Differences 0.60
Test::More  0.84
XSLoader  0
__[ template ]__
# Maintainer : Kent Fredric <kentnl@cpan.org>
# Note: This file is generated from a template with a little instrumentation
#       to avoid weird quirks of bash occurring with advanced substitution.
#       For ease of maintenance, please modify the source file PKGBUILD.tpl
#       https://github.com/kentfredric/linux-arch-packages/tree/master/mine
#
[% arch.describe %]

pkgrel=1
pkgdesc='Powerful fast feature-rich perl source code profiler'
sha512sums=('ca2e5c0410a701ced306258dd8f6cce7e71d0a3c63660cfdd30493a678ed6bf81c7c65b83a155be1baa6fc5cc339fee69c38b4f90d7f15e872dc88df97ef874f')
arch=('i686' 'x86_64')
license=('GPL')

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
