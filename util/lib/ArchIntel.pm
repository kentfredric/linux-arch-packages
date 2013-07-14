use strict;
use warnings;

package ArchIntel;

use Moo 1.000008;

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

