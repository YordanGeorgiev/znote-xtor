package ZnoteXtor::App::IO::In::RdrTextFactory ; 

   use strict; use warnings;
	
	use Data::Printer ; 

	our $appConfig 		= {} ; 
	our $term			   = $ENV{'period'} || 'daily' ; 
	our $objItem			= {} ; 
	our $objController 	= {} ; 
   our $objLogger       = {} ; 

   use ZnoteXtor::App::IO::In::RdrJson ; 

	#
	# -----------------------------------------------------------------------------
	# fabricates different RdrText object 
	# -----------------------------------------------------------------------------
	sub doInstantiate {

		my $self 	      = shift ; 	
		my $table			= shift // 'daily_issues' ; 

		my @args 			= ( @_ ) ; 
		my $RdrText 		= {}   ; 

		# get the application cnfiguration hash
		# global app cnfig hash

		if ( $term eq 'daily' ) {
			$RdrText 				= 'RdrText' ; 
		}
		elsif ( $term eq 'weekly' ) {
			$RdrText 				= 'RdrText' ; 
		}
		elsif ( $term eq 'monthly' ) {
			$RdrText 				= 'RdrText' ; 
		}
		elsif ( $term eq 'yearly' ) {
			$RdrText 				= 'RdrText' ; 
		}
		else {
			# future support for different RDBMS 's should be added here ...
			$RdrText 				= 'RdrText' ; 
		}

		my $package_file     	= "ZnoteXtor/App/IO/In/$RdrText.pm";
		my $objRdrText   		= "ZnoteXtor::App::IO::In::$RdrText";

		require $package_file;

		return $objRdrText->new( \$appConfig , $objController , $term , @args);

	}
	# eof sub doInstantiate
	

   #
	# -----------------------------------------------------------------------------
	# the constructor 
	# -----------------------------------------------------------------------------
	sub new {

		my $invocant 			= shift ;    
		$appConfig     = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
      $objController       = shift ; 
		
      # might be class or object, but in both cases invocant
		my $class = ref ( $invocant ) || $invocant ; 

		my $self = {};        # Anonymous hash reference holds instance attributes
		bless( $self, $class );    # Say: $self is a $class
      $self = $self->doInitialize() ; 
		return $self;
	}  
	#eof const
	
   #
	# --------------------------------------------------------
	# intializes this object 
	# --------------------------------------------------------
   sub doInitialize {
      my $self = shift ; 

      %$self = (
           appConfig => $appConfig
      );

	   $objLogger 			= 'ZnoteXtor::App::Utils::Logger'->new( \$appConfig ) ;


      return $self ; 
	}	
	#eof sub doInitialize

1;


__END__
