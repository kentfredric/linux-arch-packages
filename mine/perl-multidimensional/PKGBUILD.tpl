__[ data ]__
{
  cpan_distname => multidimensional       =>,
  cpan_author   => ILMARI                 =>,
  cpan_version  => 0.011                  =>,
}
__[ template ]__
# Maintainer : Kent Fredric <kentnl@cpan.org>

[% arch.describe %]

pkgname='[% arch.pkgname %]'
# normalised version
pkgver='[% arch.pkgver %]'

pkgrel='2'
pkgdesc="disables multidimensional array emulation"
arch=('i686' 'x86_64')
license=('PerlArtistic' 'GPL')
options=('!emptydirs')
depends=('perl' 'perl-b-hooks-op-check>=0.19' 'perl-lexical-sealrequirehints>=0.005' 'perl-xsloader')
makedepends=('perl-test-simple>=0.88' 'perl-extutils-makemaker>=6.30' 'perl-extutils-depends' 'perl-cpan-meta>=2.112580')
optdepends=()
url="[% arch.metacpan_release %]"
source=("[% arch.primary_src %]")
changelog="ChangeLog"
sha512sums=('8e121388b1325b6cfb73a74a9655f28ce52059096a9a8326bbe743cf663523812f3d171c1cf5d1b4841b98ec57c4240130d6def3e064e809db1d1bd4c4510081')

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
  $PERL Makefile.PL && make || return 1
}

check() {
  _env_setup || return 1;
  make test  || return 1
}

package() {
  _env_setup   || return 1;
  make install || return 1;
  find "$pkgdir" -name perllocal.pod -delete
}

# Local Variables:
# mode: shell-script
# sh-basic-offset: 2
# End:
# vim:set ts=2 sw=2 et:
