use strict ; use warnings ; 

package SetGetableChild ; 
# package ZnoteXtor::App::Utils::OO::SetGetableChild ; 

	require Exporter;
	our @ISA = qw(Exporter  ZnoteXtor::App::Utils::OO::SetGetable);
	our $AUTOLOAD =();
	our $ModuleDebug = 0 ; 
	use AutoLoader;

# you can copy this 
use base qw(ZnoteXtor::App::Utils::OO::SetGetable);


=head2 new
	# -----------------------------------------------------------------------------
	# the constructor
=cut 

	# -----------------------------------------------------------------------------
	# the constructor 
	# -----------------------------------------------------------------------------
	sub new {

		my $class = shift;    # Class name is in the first parameter
		my $self = {};        # Anonymous hash reference holds instance attributes
		bless( $self, $class );    # Say: $self is a $class
		return $self;
	}  


1 ; 

__END__
