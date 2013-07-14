__[ data ]__
{
  cpan_distname => 'aliased'      =>,
  cpan_author   => OVID           =>,
  cpan_version  => '0.31'         =>,
  pkgver        => '0.310'        =>,
}
__[ template ]__
# Maintainer : Kent Fredric <kentnl@cpan.org>

[% arch.describe %]

pkgname='[% arch.pkgname %]'
# normalised version
pkgver='[% arch.pkgver %]'

pkgrel='2'
pkgdesc="Use shorter versions of class names."
arch=('any')
license=('PerlArtistic' 'GPL')
options=('!emptydirs')
depends=('perl')
makedepends=('perl-test-simple' 'perl-module-build>=0.400')
optdepends=()

url="[% arch.metacpan_release %]"
source=("[% arch.primary_src %]")
changelog="ChangeLog"
sha512sums=('3a90100ff85f97bc682d423dc32991c98f7637dd2c14156cf189be437ec7be0b689ea04e12283ad050e0ff854aa76a71a3a977161567fac01e9b7ddffe5b6ccd')

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
