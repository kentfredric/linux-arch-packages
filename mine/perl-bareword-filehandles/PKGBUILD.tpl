__[ data ]__
{
  cpan_distname => 'bareword-filehandles' =>,
  cpan_author   => ILMARI                 =>,
  cpan_version  => '0.003'                =>,
}
__[ template ]__
# Maintainer : Kent Fredric <kentnl@cpan.org>

[% arch.describe %]

pkgname='[% arch.pkgname %]'
# normalised version
pkgver='[% arch.pkgver %]'

pkgrel='2'
pkgdesc="disables bareword filehandles"
arch=('i686' 'x86_64')
license=('PerlArtistic' 'GPL')
options=('!emptydirs')
depends=('perl' 'perl-b-hooks-op-check' 'perl-lexical-sealrequirehints' 'perl-xsloader')
makedepends=('perl-test-simple>=0.88' 'perl-extutils-depends' 'perl-extutils-makemaker>=6.31')
checkdepends=()
optdepends=()
url='[% arch.metacpan_release %]'
source=('[% arch.primary_src %]')
changelog='ChangeLog'
sha512sums=('184c37f737a638a3cfad7657b39918a2aff862faa7c84ef965cc9f2a7c157b05eac732807a0ebb1de44a0ce76b72a96016a126cbba658cddd8230f3de6ab5d8b')

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
