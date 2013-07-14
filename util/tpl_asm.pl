#!/usr/bin/env perl 

use strict;
use warnings;
use utf8;

use FindBin;
use lib "$FindBin::Bin/lib";

use Path::Tiny;
use String::Sections;
use ArchIntel;


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

use Template::Alloy;
my $al = Template::Alloy->new(
    SYNTAX => 'tt3',
);
$al->process($res->section('template'), { arch => $instance }, $dest->openw )
    || die $al->error;

