package ZnoteXtor::App::Utils::IO::FileHandler ; 
	use strict; use warnings; use diagnostics ; 

	my $VERSION = '1.1.8';

	require Exporter;
	our @ISA = qw(Exporter ZnoteXtor::App::Utils::OO::SetGetable ZnoteXtor::App::Utils::OO::AutoLoadable) ;
	our $AUTOLOAD =();
	use AutoLoader;
   use Carp ;
   use Getopt::Long;
	use File::Path qw(make_path) ;
	use File::Compare;
	use IO::File;
	use File::Find;
	use Fcntl qw( :flock );
	use File::Copy;
	use File::Path ; 

   use parent 'ZnoteXtor::App::Utils::OO::SetGetable' ; 
   use parent 'ZnoteXtor::App::Utils::OO::AutoLoadable' ;

	my @EXPORT = qw(doReadFileReturnString doPrintToFile);


	#
	# -----------------------------------------------------------------------------
	# Reads a file returns a sting , if second param is utf8 returns utf8 string
	# usage:
   # ( $ret , $msg , $str_file ) 
   #         = $objFileHandler->doReadFileReturnString ( $file , 'utf8' ) ; 
   # or
   # ( $ret , $msg , $str_file ) 
   #         = $objFileHandler->doReadFileReturnString ( $file ) ; 
	# -----------------------------------------------------------------------------
	sub doReadFileReturnString {

      my $self      = shift;
      my $file      = shift;
      my $mode      = shift ; 

      my $msg        = {} ;     
      my $ret        = 1 ; 
      my $s          = q{} ; 

      $msg = " the file : $file does not exist !!!" ; 
      cluck ( $msg ) unless -e $file ; 

      $msg = " the file : $file is not actually a file !!!" ; 
      cluck ( $msg ) unless -f $file ; 

      $msg = " the file : $file is not readable !!!" ; 
      cluck ( $msg ) unless -r $file ; 

      $msg .= "can not read the file $file !!!";

      return ( $ret , "$msg ::: $! !!!" , undef ) 
         unless ((-e $file) && (-f $file) && (-r $file));

      $msg = '' ; 

	   $s = eval {	
          my $string = ();    #slurp the file	
          {
            local $/ = undef;

            if ( defined ( $mode ) && $mode eq 'utf8' ) {
               open FILE, "<:utf8", "$file"
                 or cluck("failed to open \$file $file : $!");
               $string = <FILE> ; 
               die "did not find utf8 string in file: $file" 
                  unless utf8::valid ( $string ) ; 
            }
            else {
               open FILE, "$file" 
                  or cluck ("failed to open the \$file $file : $!" ) ; 
               $string = <FILE> ; 
            }
            close FILE;

          }
         $string ; 
       };

       if ( $@ ) {
         $msg = $! . " " . $@ ; 
         cluck ( $msg ) ; 
         $ret = 1 ; 
         $s = undef ; 
       } else {
         $ret = 0 ; $msg = "ok for read file: $file" ;  
       }
		 return ( $ret , $msg , $s ) ; 
	}
	#eof sub doReadFileReturnString


	#
	# ^.* at (.+) line ([0-9]+)[.,]
	# -----------------------------------------------------------------------------
	# Prints the passed string to a file if the file exists it is overwritten
	# -----------------------------------------------------------------------------
	sub doPrintToFile {

		my $self             = shift;
		my $FileOutput       = shift
		   || cluck("FileHandler::doPrintToFile undef \$FileOutput  !!!");
		my $StringToPrint    = shift
		   || cluck("FileHandler::doPrintToFile undef \$StringToPrint  !!!");
		my $mode             = shift 
         || 'utf8' ; 


		#$FileOutput = $self->ToUnixDir($FileOutput);

		$FileOutput =~ m/(.*)(\\|\/)(.*)/g ;
		my $FileDir = "$1$2"  ;
		#print "\$FileDir : $FileDir " ; 

		chomp ( $FileDir ) ; 

		# try to create the dir path of the file path if it does not exist
		unless (-d $FileDir) {
		  $self->doMkDir( "$FileDir" );
		  carp "should create the file dir $FileDir" ; 
		}


      if ( $mode eq 'utf8' ) {

         binmode(STDIN,  ':utf8');
         binmode(STDOUT, ':utf8');
         binmode(STDERR, ':utf8');

         open(FILEOUTPUT, ">:utf8", "$FileOutput")
         || cluck("could not open the \$FileOutput $FileOutput! $! \n");

         binmode(FILEOUTPUT, ":utf8") ; 
         
      } else {
         open(FILEOUTPUT, ">$FileOutput")
         || cluck("could not open the \$FileOutput $FileOutput! $! \n");
      }
      

		print FILEOUTPUT $StringToPrint;
		close FILEOUTPUT;

		#debug $strToReturn .=  $StringToPrint;

	}  
	#eof sub doPrintToFile


	#
	# -----------------------------------------------------------------------------
	# Create a dir or cluck why it can't
	# use by if ( $self->doMkDir ( $dir_to_create ) ; 
	# -----------------------------------------------------------------------------
	sub doMkDir {

		my $self        	= shift;
		my $dir_to_create = shift;

		my $error_msg 		= '' ; 
		my $msg 				= '' ; 	

		no warnings 'experimental::smartmatch';

		# if there is !no directory!
		unless ( -d "$dir_to_create" ) {
			eval { 
				use autodie ; 
				my $error_msg = "FileHandler::failed to create directory $dir_to_create $! !!!"  ; 
				mkpath( "$dir_to_create" ) || cluck( "$error_msg" ) ;  
			};
		}    
		else {
			#dir exists alles gut !!!
			return 1;
		}
		
		use warnings 'experimental::smartmatch';

	}    
	#eof sub doMkDir



	#
	# -----------------------------------------------------------------------------
	# -----------------------------------------------------------------------------
	sub doReadFileReturnArrayRef {
		my $self = shift ; 
		my $path_to_file = shift ; 
		my $arr_ref = () ; 

		open my $handle, '<', $path_to_file;
		chomp(my @lines = <$handle>);
		close $handle;

		$arr_ref = \@lines ; 
		return $arr_ref ; 

	}
	#eof sub doReadFileReturnArrayRef




	# call by : $objFileHandler = new FileHandler ( ) ; 
	# source:http://www.netalive.org/tinkering/serious-perl/#oop_constructors¨
	# -----------------------------------------------------------------------------
	sub new {

		 my $class = shift;    # Class name is in the first parameter

		 my $self = {};        # Anonymous hash reference holds instance attributes

		 bless($self, $class); # Say: $self is a $class

		 return $self;
	}   
	#eof const




# STOP OO
# =============================================================================

1;

__END__


=head1 NAME

FileHandler

=head1 SYNOPSIS

use ZnoteXtor::App::Utils::IO::FileHandler ; 
my $objFileHandler= 'ZnoteXtor::App::Utils::IO::FileHandler'->new();
$objFileHandler = new FileHandler ( ) ; 
$objFileHandler->doPrintToFile($file,$strFile);
$objFileHandler->doMkDir($dir);
  

=head1 DESCRIPTION

Provide a simplistic OO wrapping interface handling of files

=head2 EXPORT


=head1 SEE ALSO

perldoc perlvars

No mailing list for this module


=head1 AUTHOR

yordan.georgiev@gmail.com

=head1 COPYRIGHT MOR LICENSE

Copyright (C) 2018 Yordan Georgiev

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.1 or,
at your option, any later version of Perl 5 you may have available.



=cut

