use v5.18;
use warnings;

package Dep {
	
	use Moo 1.000008;

	has module => ( is => ro =>, required => 1 );
	has version => ( is => ro =>, required => 1 );
	has dependency => ( is => ro =>, required => 1 );


	sub inflate {
		my ($self, $module,$version,$dep ) = @_;
		return $self->new({ module => $module, version => $version, dependency => $dep });
	}
	sub dep {
		return $_[0]->module . ' ' . $_[0]->version;
	}
};

package Deps;

use Moo 1.000008;

has deps => ( is => ro =>, lazy => 1, builder => sub { {} });

my $instance = __PACKAGE__->new();

sub add_dep {
	my ( $module, $version, $package ) = @_; 
	if ( not defined $package ) {
		$package = $module;
		$package =~ s/::/-/g;
		$package = lc($package);
		$package = 'perl-' . $package;
		if ( $version ) {
			$package .= '>=' . $version;
		}
	}
	my $dep = Dep->inflate($module,$version, $package);
	$instance->deps->{ $dep->dep } = $dep;
}
sub resolve {
	my ( $self, $wanted, $wanted_version ) = @_;
	if ( defined $wanted_version ) {
		$wanted .= ' ' . $wanted_version;
	}
	if ( not exists $instance->deps->{ $wanted } ) {
		die "no dependency mapping for $wanted";
	}
	return $instance->deps->{ $wanted }->dependency;
}
add_dep('B::Hooks::OP::Check', '0');
add_dep('Class::Load', '0.17' );
add_dep('ExtUtils::Depends', 0);
add_dep('ExtUtils::MakeMaker', '6.30');
add_dep('ExtUtils::MakeMaker', '6.31');
add_dep('File::Find', 0, 'perl');
add_dep('File::Spec', 0, 'perl');
add_dep('File::Temp', 0 );
add_dep('Lexical::SealRequireHints', 0 );
add_dep('Module::Build', '0.40');
add_dep('Module::Pluggable::Object', 0, 'perl-module-pluggable');
add_dep('Moose','0.91' );
add_dep('Moose::Role', 0, 'perl-moose');
add_dep('Moose::Util::TypeConstraints', 0, 'perl-moose');
add_dep('MooseX::OneArgNew', 0 );
add_dep('Params::Util', 0 );
add_dep('Role::HasMessage', 0 );
add_dep('Role::Identifiable', 0 );
add_dep('Role::Identifiable::HasIdent', 0, 'perl-role-identifiable');
add_dep('StackTrace::Auto','0','perl-throwable');
add_dep('Test::Fatal', 0 );
add_dep('Test::More', '0', 'perl-test-simple');
add_dep('Test::More', '0.88', 'perl-test-simple>=0.88');
add_dep('Test::More', '0.96', 'perl-test-simple>=0.96');
add_dep('Throwable', 0 );
add_dep('Tie::IxHash', 0 );
add_dep('Try::Tiny', 0 );
add_dep('XSLoader', 0);
add_dep('overload',0,'perl');
add_dep('strict',0,'perl');
add_dep('warnings','0','perl');
1;
