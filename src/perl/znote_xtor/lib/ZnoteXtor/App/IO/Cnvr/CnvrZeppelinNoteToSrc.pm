package ZnoteXtor::App::IO::Cnvr::CnvrZeppelinNoteToSrc ; 

	use strict; use warnings; use utf8 ; 

	my $VERSION = '1.0.0';    

	require Exporter;
	our @ISA = qw(Exporter ZnoteXtor::App::Utils::OO::SetGetable ZnoteXtor::App::Utils::OO::AutoLoadable) ;
	our $AUTOLOAD =();
	use AutoLoader;
   use Carp ;
   use Data::Printer ; 
   use Getopt::Long;
   use JSON ; 

   use parent 'ZnoteXtor::App::Utils::OO::SetGetable' ; 
   use parent 'ZnoteXtor::App::Utils::OO::AutoLoadable' ;

   use ZnoteXtor::App::Utils::Logger ; 
   use ZnoteXtor::App::Mdl::Model ; 

	our $module_trace                = 0 ; 
	our $appConfig						   = {} ; 
	our $objLogger						   = {} ; 

   # 
   # read the cmd args and set them into the global app config 
   sub doConvert {
      my $self = shift ;   
      my $str_json = shift ; 
      
      
      my @arr_codes = () ; 
      my $ret = 1 ; 
      my $msg = 'error, while converting the str_json ' ; 

      my $out_file_name = 'todo' ; 
      my $str_src = 'todo' ; 

      my $json_dat = JSON->new->utf8->decode($str_json);
         my $note_dir = $json_dat->{'name' } || 'untitled' ; 
    	$note_dir =~ s/\s+/_/g ; 
    	$note_dir =~ s/\-+/-/g ; 
    	$note_dir =~ s/\.+/./g ; 
      foreach my $paragraph ( $json_dat->{ 'paragraphs' } ) {
         # debug print "START paragraph \n" ; 
         # debug p $paragraph ; 
         # debug print "STOP  paragraph \n" ; 
         my $i = 0 ; 
         foreach my $paragraph_unit ( @$paragraph ) {
            my $hr_file = {} ; 
            # print "START paragraph_unit \n" ; 
            # p $paragraph_unit ; 
            # print "STOP  paragraph_unit  \n" ; 
            # print "START paragraph title \n" ; 
            # debug p $paragraph_unit->{'title' }  ;  
            my $file_name = $paragraph_unit->{'title' } || 'untitled' ; 
            my $src_code = $paragraph_unit->{'text' } || 'empty' ; 
            $src_code =~ s/\\n/\n/g ; 
            $hr_file->{ 'src_code' } = $src_code ; 

            $file_name = lc ( $file_name ) ; 
            $file_name =~ s/\s+/_/g ; 
            $file_name =~ s/\-+/-/g ; 
            $file_name =~ s/\.+/./g ; 
            $file_name =~ s/[\.\.+]/./g ; 
            $file_name =~ s/[\<\>\*]+//g ; 

            $i++ ;  
            my $si = $i ; 
            $si = "0$i" if $i < 10 ; 
            $hr_file->{ 'file_name' } = "$note_dir" . '/' . "$si" . '.' . $file_name ; 
            push @arr_codes , $hr_file ; 
            # print "STOP  paragraph \n" ; 
            # print "START paragraph text \n" ; 
            # p $paragraph_unit->{'text'}  ;  
            # print "STOP  paragraph text \n" ; 
         }
      }


      $ret = 0 ; 
      $msg = 'convert ok' ; 
      return ( $ret , $msg , \@arr_codes ) ; 
   }
   # eof sub doRead


=head1 SYNOPSIS
      my $objCnvrZeppelinNoteToSrc = 
         'ZnoteXtor::App::IO::In::CnvrZeppelinNoteToSrc'->new ( \$appConfig ) ; 
      ( $ret , $msg ) = $objCnvrZeppelinNoteToSrc->doRun ( $actions ) ; 
=cut 

=head1 EXPORT

	A list of functions that can be exported.  You can delete this section
	if you don't export anything, such as for a purely object-oriented module.
=cut 

=head1 SUBROUTINES/METHODS

	# -----------------------------------------------------------------------------
	START SUBS 
=cut




	

=head1 WIP

	
=cut

=head1 SUBROUTINES/METHODS

	STOP  SUBS 
	# -----------------------------------------------------------------------------
=cut


=head2 new
	# -----------------------------------------------------------------------------
	# the constructor
=cut 

	# -----------------------------------------------------------------------------
	# the constructor 
	# -----------------------------------------------------------------------------
	sub new {

		my $class      = shift;    # Class name is in the first parameter
		$appConfig     = ${ shift @_ } || croak 'appConfig not passed !!!' ; 
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

=head2
	# -----------------------------------------------------------------------------
	# overrided autoloader prints - a run-time error - perldoc AutoLoader
	# -----------------------------------------------------------------------------
=cut



	


1;

__END__

