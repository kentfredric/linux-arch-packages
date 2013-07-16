use strict;
use warnings;

package ArchIntel;

use Moo 1.000008;
use Data::Dump qw(pp);

my @attrs;

has 'pkgname' => (
  is => ro =>,
  lazy => 1,
  builder => sub {
    'perl-' . lc($_[0]->cpan_distname );
  }
);
push @attrs, 'pkgname';

has pkgver   => (
  is => ro =>,
  lazy => 1,
  builder => sub {
    my $cpanv = $_[0]->cpan_version;
    if ( $cpanv =~ /^(\d+)[.](\d+)$/ ) {
      my ($head,$mantissa) = ($1,$2);
      if( length $mantissa <= 3 ){
        return sprintf '%.3f', $cpanv;
      }
      if( length $mantissa <= 6 ){
        return sprintf '%.6f', $cpanv;
      }
      if( length $mantissa <= 9 ){
        return sprintf '%.9f', $cpanv;
      }
      if( length $mantissa <= 12 ){
        return sprintf '%.12f', $cpanv;
      }
    }
    die "Normalising <$cpanv> unsupported atm";
  },
);
push @attrs, 'pkgver';
has cpan_distname => ( is => ro =>, required => 1 );
push @attrs, 'cpan_distname';
has cpan_author   => ( is => ro =>, required => 1 );
push @attrs, 'cpan_author';
has cpan_version  => ( is => ro =>, required => 1 );
push @attrs, 'cpan_version';

has author_first   => ( is => ro =>, lazy => 1, builder => sub {
  return substr( $_[0]->cpan_author, 0, 1 );
});
push @attrs, 'author_first';
has author_first_two   => ( is => ro =>, lazy => 1, builder => sub {
  return substr( $_[0]->cpan_author, 0, 2 );
});
push @attrs, 'author_first_two';
has tar_suffix => ( is => ro =>, lazy => 1, builder => sub {
  return '.tar.gz';
});
push @attrs, 'tar_suffix';
has tar_filename => ( is => ro =>, lazy => 1, builder => sub {
  return $_[0]->cpan_distname . '-' . $_[0]->cpan_version . $_[0]->tar_suffix;
});
push @attrs, 'tar_filename';
has tar_dirname  => ( is => ro =>, lazy => 1, builder => sub {
  return $_[0]->cpan_distname . '-' . $_[0]->cpan_version;
});
push @attrs, 'tar_dirname';
has primary_mirror => ( is => ro =>, lazy => 1, builder => sub {
  'http://search.cpan.org/CPAN/authors/id'
});
push @attrs, 'primary_mirror';
has primary_src => ( is => ro =>, lazy => 1, builder => sub {
  return $_[0]->primary_mirror . '/' . $_[0]->author_first . '/' . $_[0]->author_first_two  . '/' .
  $_[0]->cpan_author . '/' . $_[0]->tar_filename;
});
push @attrs, 'primary_src';
has 'metacpan_release'  => ( is => ro => , lazy => 1, builder => sub {
  return 'https://metacpan.org/release/' . $_[0]->cpan_distname;
});
push @attrs, 'metacpan_release';

has configure_requires => ( is => ro =>, lazy => 1, builder => sub { [] } );
has build_requires => ( is => ro =>, lazy => 1, builder => sub { ['perl'] } );
has runtime_requires => ( is => ro =>, lazy => 1, builder => sub { ['perl'] } );
has test_requires => ( is => ro =>, lazy => 1, builder => sub { [] } );

sub list_exclude {
  my ( $source, $exclusions ) = @_ ;
  my $blacklist = {};
  $blacklist->{$_}++ for @{$exclusions};
  return  [ grep { not exists $blacklist->{$_} } @{$source} ];
}
sub list_uniq {
  my ( $source ) = @_;
  my $blacklist = {};
  my @out;
  for my $item (@{$source}){
    next if exists $blacklist->{$item};
    $blacklist->{$item} = 1;
    push @out, $item;
  }
  return [@out];
}
sub list_join {
  my ( $source, $add ) = @_;
  my $blacklist = {};
  $blacklist->{$_}++ for @{$source};
  return [ @{$source}, grep { not exists $blacklist->{$_} } @{$add} ];
}


sub pac_makedepends {
  # depends = configure + build - runtime
  my $include = [ @{$_[0]->configure_requires }, @{ $_[0]->build_requires }];
  my $exclude = $_[0]->runtime_requires;
  return list_uniq( list_exclude( $include, $exclude ));
}
sub pac_depends {
  return list_uniq($_[0]->runtime_requires);
}
sub pac_checkdepends {
  my $exclude =  [@{ $_[0]->configure_requires }, @{ $_[0]->build_requires }, @{ $_[0]->runtime_requires }];
  return list_uniq( list_exclude( $_[0]->test_requires, $exclude ));
}
sub _pac_list {
  return join q[ ], map { "'$_'" } sort @_;
}
sub pac_makedepends_string {
  return _pac_list(@{ $_[0]->pac_makedepends });
}
sub pac_depends_string {
  return _pac_list(@{ $_[0]->pac_depends });
}
sub pac_checkdepends_string {
  return _pac_list(@{ $_[0]->pac_checkdepends });
}


sub describe {
  my @out;
  push @out, '{';
  for my $attr ( @attrs ) {
    push @out, ' ' . $attr . ' => ' . $_[0]->$attr;
  }
  push @out, '}';
  $_ =~ s/^/# / for @out;
  return join qq{\n}, @out, '';
}

sub eumm_build {
  return <<'EOF'
  _env_setup || return 1;
  $PERL Makefile.PL && make || return 1;
EOF
}
sub mb_build {
  return <<'EOF'
  _env_setup || return 1;
  $PERL Build.PL && ./Build || return 1;
EOF
}

sub eumm_check {
  return <<'EOF';
  _env_setup || return 1;
  make test || return 1;
EOF
}

sub mb_check {
  return <<'EOF';
  _env_setup || return 1;
  ./Build test || return 1;
EOF
}

sub eumm_package {
  return <<'EOF';
  _env_setup || return 1;
  make install || return 1;
  find "$pkgdir" -name perllocal.pod -delete
EOF
}
sub mb_package {
  return <<'EOF';
  _env_setup   || return 1;
  ./Build pure_install || return 1;
  find "$pkgdir" -name perllocal.pod -delete
EOF
}

sub env {
  my $tar_dirname = $_[0]->tar_dirname;
  return <<"EOF";
_env_setup(){
  export                        \\
    PERL=/usr/bin/perl          \\
    PERL_MM_USE_DEFAULT=1       \\
    PERL5LIB=""                 \\
    PERL_AUTOINSTALL=--skipdeps \\
    PERL_MM_OPT="INSTALLDIRS=vendor DESTDIR='\$pkgdir'" \\
    PERL_MB_OPT="--installdirs vendor --destdir '\$pkgdir'" \\
    MODULEBUILDRC=/dev/null \\
    HARNESS_OPTIONS=j10     \\
    PROJ_ROOT="\${srcdir}/${tar_dirname}"
  cd "\$PROJ_ROOT" || return 1;
}
EOF
}



1;
