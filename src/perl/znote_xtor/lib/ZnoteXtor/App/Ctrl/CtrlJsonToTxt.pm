package ZnoteXtor::App::Ctrl::CtrlJsonToTxt ; 

	use strict; use warnings; use utf8 ; 

	my $VERSION = '1.0.0';    

	require Exporter;
	our @ISA = qw(Exporter ZnoteXtor::App::Utils::OO::SetGetable ZnoteXtor::App::Utils::OO::AutoLoadable) ;
	our $AUTOLOAD =();
	use AutoLoader;
   use utf8 ;
   use Carp ;
   use Data::Printer ; 

   use parent 'ZnoteXtor::App::Utils::OO::SetGetable' ;
   use parent 'ZnoteXtor::App::Utils::OO::AutoLoadable' ;
   use ZnoteXtor::App::Utils::Logger ; 
   use ZnoteXtor::App::IO::In::RdrDirs ; 
   use ZnoteXtor::App::IO::In::RdrFiles ; 
   use ZnoteXtor::App::IO::Out::WtrDirs ; 
   use ZnoteXtor::App::IO::Out::WtrFiles ; 
   use ZnoteXtor::App::IO::Cnvr::CnvrZeppelinNoteToSrc ; 

	our $module_trace                = 0 ; 
	our $appConfig						   = {} ; 
	our $objModel                    = {} ; 
	our $ProductInstanceDir 			= ''; 
	our $objLogger						   = {} ; 


=head1 SYNOPSIS
      my $objCtrlJsonToTxt = 
         'ZnoteXtor::App::Ctrl::CtrlJsonToTxt'->new ( \$appConfig ) ; 
      ( $ret , $msg ) = $objCtrlJsonToTxt->doRun ( $issues_file ) ; 
=cut 

=head1 EXPORT

	A list of functions that can be exported.  You can delete this section
	if you don't export anything, such as for a purely object-oriented module.
=cut 

=head1 SUBROUTINES/METHODS

	# -----------------------------------------------------------------------------
	START SUBS 
=cut


   # 
	# -----------------------------------------------------------------------------
   # read the input dir passed by the cmd args from the objModel
   # foreach json file beneath the input dir
   # convert it into txt file by extractin the src code from the note
   # and print the result into the outdir 
	# -----------------------------------------------------------------------------
   sub doRun {

      my $self = shift  ;
      my $ret  = 1 ; 
      my $ret_msg  = 'unknown error in CtrlJsonToTxt component !!!' ; 

      my $file_type_exts = {
         '%spark' => 'scala' , 
         '%sql' => 'sql' ,
         '%sh' => 'sh' ,
         '%bash' => 'sh'
      };
      my $msg  = 'START conversion ' ; 
      $objLogger->doLogDebugMsg ( $msg ) ; 
      my $ProductInstanceDir = $appConfig->{'$ProductInstanceDir'} ; 

      my $objRdrDirs     = 'ZnoteXtor::App::IO::In::RdrDirs'->new();
      my $objRdrFiles    = 'ZnoteXtor::App::IO::In::RdrFiles'->new();
      my $objWtrFiles    = 'ZnoteXtor::App::IO::Out::WtrFiles'->new();
      my $objWtrDirs     = 'ZnoteXtor::App::IO::Out::WtrDirs'->new();
      my $objCnvrZeppelinNoteToSrc = 'ZnoteXtor::App::IO::Cnvr::CnvrZeppelinNoteToSrc'->new ( \$appConfig ) ; 

      my $in_dir = $objModel->get('in.dir') ; 
      my $out_dir = $objModel->get('out.dir') ; 

      $in_dir = "$ProductInstanceDir/$in_dir" unless ( $in_dir =~ m/^[\/\\]/ ) ; 
      $out_dir = "$ProductInstanceDir/$out_dir" unless ( $out_dir =~ m/^[\/\\]/ ) ; 
      $objWtrDirs->doMkDir ( $out_dir ) ; 
      
      my $arrRef = $objRdrDirs->doReadDirGetFilesByExtension ( $in_dir , 'json' ); 
      
      foreach my $json_file ( sort @$arrRef ) {
         $msg = "converting the following json file: \n" ; 
         $msg .= $json_file . "\n" ; 
         $objLogger->doLogInfoMsg ( $msg ) ; 
         my $str_json_file = $objRdrFiles->doReadFileReturnString ( $json_file ) ; 
         my ( $ret , $msg , $arr_ref_files ) = $objCnvrZeppelinNoteToSrc->doConvert( $str_json_file ) ;
         my $note_dir = $json_file ; 
         $note_dir =~ s/(.*)[\\|\/](.*?)[\\|\/](.*)/$2/g ; 
         foreach my $src_file ( @$arr_ref_files ) {
            my $str_txt_file = $src_file->{ 'src_code' } ; 
            my $file_type = ( split /\n/, $str_txt_file )[0] ; 
            #debug print "file_type : $file_type \n" ; 
            my $file_ext = $file_type_exts->{ "$file_type" } || '.txt' ; 
            my $txt_file = "$out_dir" . $note_dir . "/" . $src_file->{ 'file_name' } . '.' . $file_ext ; 
            $msg = 'print paragraph to the following file: ' . "\n" . "$txt_file" ; 
            $objLogger->doLogInfoMsg ( $msg ) ; 
            $objWtrFiles->doPrintToFile ( $txt_file , $str_txt_file ) ; 
         }
      }
      $msg = 'STOP  conversion' ; 
      $objLogger->doLogDebugMsg ( $msg ) ; 
      
      $ret_msg = "OK for CtrlJsonToTxt component run" ; 
      $ret = 0 ; 
      return ( $ret , $ret_msg ) ; 
   }


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
		$objModel      = ${ shift @_ } || croak 'objModel not passed !!!' ; 

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


	# STOP functions
	# =============================================================================

	


1;

__END__

=head1 NAME

UrlSniper 

=head1 SYNOPSIS

use CtrlJsonToTxt ; 


=head1 DESCRIPTION
the main purpose is to initiate minimum needed environment for the operation 
of the whole application - man app cnfig hash 

=head2 EXPORT


=head1 SEE ALSO

perldoc perlvars

No mailing list for this module


=head1 AUTHOR

yordan.georgiev@gmail.com

=head1 



=cut 

