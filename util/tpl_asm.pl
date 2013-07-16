#!/usr/bin/env perl 

use v5.18;
use warnings;
use utf8;

use FindBin;
use lib "$FindBin::Bin/lib";

use Path::Tiny;
use String::Sections;
use ArchIntel;
use Deps;


my $source;
my $dest;

if ( @ARGV ){ 
    $source = path(shift @ARGV);
} else {
    $source = path('./PKGBUILD.tpl');
}
if ( @ARGV ){ 
    $dest = path(shift @ARGV);
} else {
    $dest = path('./PKGBUILD');
}

my $ss = String::Sections->new();
my $res = $ss->load_filehandle( $source->openr );

my $data = eval ${$res->section('data')};
my $instance = ArchIntel->new($data);

for my $section_name (qw( configure build runtime test ) ) {
	my $real_name = "${section_name}_requires";
	next unless $res->has_section($real_name);
	my $content = ${ $res->section($real_name) };
	for my $line (split /\s*$/m, $content ) { 
		$line =~ s/#.*$//; 
		$line =~ s/^\s+//;
		if ( $line =~ /^(\S+)\s+(\S+)$/ ) {
			my $dep = Deps->resolve( $1, $2 );
			say "$real_name $1 $2 -> $dep";
			push @{ $instance->$real_name }, $dep;
		} else {
			say "Not sure what <$line> means";
		}
	}
}

use Template::Alloy;
my $al = Template::Alloy->new(
    SYNTAX => 'tt3',
);
$al->process($res->section('template'), { arch => $instance }, $dest->openw )
    || die $al->error;

