__[ data ]__
{
  cpan_distname => 'Config-MVP'        =>,
  cpan_author   => RJBS                =>,
  cpan_version  => '2.200003'          =>,
}
__[ configure_requires ]__
ExtUtils::MakeMaker 6.30
__[ build_requires     ]__
__[ runtime_requires   ]__
Class::Load 0.17
File::Spec 0
Module::Pluggable::Object 0
Moose 0.91
Moose::Role 0
Moose::Util::TypeConstraints  0
MooseX::OneArgNew 0
Params::Util  0
Role::HasMessage  0
Role::Identifiable::HasIdent  0
StackTrace::Auto  0
Test::More  0.88
Throwable 0
Tie::IxHash 0
Try::Tiny 0
overload  0
strict  0
warnings 0
__[ test_requires     ]__
File::Find  0
File::Temp  0
Test::Fatal 0
Test::More  0.96
__[ template ]__
# Maintainer : Kent Fredric <kentnl@cpan.org>
# Note: This file is generated from a template with a little instrumentation
#       to avoid weird quirks of bash occurring with advanced substitution.
#       For ease of maintenance, please modify the source file PKGBUILD.tpl
#       https://github.com/kentfredric/linux-arch-packages/tree/master/mine
#
[% arch.describe %]

pkgrel='3'
pkgdesc='multivalue-property package-oriented configuration'
sha512sums=('8e8fe73501b782d2a488e0bf50b39567f8b0de1eb3f389d618027fd954cb3272f39e1d9414b125d6be807807e6505571fccf511ea0534abcb3540ad881bcdd5d')
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
