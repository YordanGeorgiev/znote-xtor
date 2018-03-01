package ZnoteXtor::App::IO::Out::WtrTextFactory ; 

   use strict; use warnings;
	
	use Data::Printer ; 

	our $appConfig 		= {} ; 
	our $term			   = $ENV{'period'} || 'daily' ; 
	our $table			   = $ENV{'tables'} || 'daily_issues' ; 
	our $objItem			= {} ; 
	our $objController 	= {} ; 
   our $objLogger       = {} ; 

	# use ZnoteXtor::App::Db::WtrTextWeekly  ; 
   use ZnoteXtor::App::IO::Out::WtrText ;  

	#
	# -----------------------------------------------------------------------------
	# fabricates different WtrText object 
	# -----------------------------------------------------------------------------
	sub doInstantiate {

		my $self 			= shift ; 	
		my $table			= shift // $table ; # the default is 'daily'

		my @args 			= ( @_ ) ; 
		my $WtrText 		= {}   ; 
	   $WtrText 				= 'WtrText' ; 

		my $package_file     	= "ZnoteXtor/App/IO/Out/$WtrText.pm";
		my $objWtrText   		= "ZnoteXtor::App::IO::Out::$WtrText";

		require $package_file;

		return $objWtrText->new( \$appConfig , $table , @args);

	}
	# eof sub doInstantiate
	

   #
	# -----------------------------------------------------------------------------
	# the constructor 
	# -----------------------------------------------------------------------------
	sub new {

		my $invocant 			= shift ;    
		$appConfig           = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
		
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