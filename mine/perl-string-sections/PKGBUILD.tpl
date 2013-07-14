__[ data ]__
{
  cpan_distname => 'String-Sections'      =>,
  cpan_author   => KENTNL                 =>,
  cpan_version  => '0.2.2'                =>,
  pkgver        => '0.2.2'                =>,
}
__[ template ]__
# Maintainer : Kent Fredric <kentnl@cpan.org>

[% arch.describe %]

pkgname='[% arch.pkgname %]'
# normalised version
pkgver='[% arch.pkgver %]'

pkgrel='1'
pkgdesc="Extract labeled groups of sub-strings from a string."
arch=('any')
license=('PerlArtistic' 'GPL')
options=('!emptydirs')
depends=('perl>=5.10.1' 'perl-carp' 'perl-moo' 'perl-params-classify' 'perl-scalar-list-utils')
makedepends=('perl-module-build>=0.4005')
checkdepends=('perl-data-dump' 'perl-file-temp' 'perl-path-tiny' 'perl-sub-exporter-progressive' 'perl-test-fatal' 'perl-test-simple>=0.98' 'perl-lib')
optdepends=()
url="[% arch.metacpan_release %]"
source=("[% arch.primary_src %]")
changelog="ChangeLog"
sha512sums=('f8d3e5387379d42bc5521558fee6ada60169ffe55b0689e4ff6e5c8bd3730bc481971b8c547229735dbad9f44e91c4cb1a21848568ae3b821acd82c822a03bad')

_env_setup(){
  export \
    PERL=/usr/bin/perl          \
    PERL_MM_USE_DEFAULT=1       \
    PERL5LIB=""                 \
    PERL_AUTOINSTALL=--skipdeps \
    PERL_MM_OPT="INSTALLDIRS=vendor DESTDIR='$pkgdir'"     \
    PERL_MB_OPT="--installdirs vendor --destdir '$pkgdir'" \
    MODULEBUILDRC=/dev/null     \
    HARNESS_OPTIONS=j10         \
    PROJ_ROOT="${srcdir}/[% arch.tar_dirname %]"
  cd "$PROJ_ROOT" || return 1;
}

build() {
  _env_setup                || return 1;
  $PERL Build.PL && ./Build || return 1
}

check() {
  _env_setup || return 1;
  ./Build test  || return 1
}

package() {
  _env_setup   || return 1;
  ./Build pure_install || return 1;
  find "$pkgdir" -name perllocal.pod -delete
}

# Local Variables:
# mode: shell-script
# sh-basic-offset: 2
# End:
# vim:set ts=2 sw=2 et:
