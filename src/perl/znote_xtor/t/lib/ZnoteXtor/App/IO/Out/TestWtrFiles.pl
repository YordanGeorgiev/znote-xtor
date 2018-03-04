use strict ; use warnings ; 
package TestWtrFiles ; 


use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../../../../../../lib" }
BEGIN { unshift @INC, "$FindBin::Bin/" }

use ZnoteXtor::App::Utils::Initiator ; 
use ZnoteXtor::App::IO::Out::WtrFiles ; 

use Test::More tests => 3 ; 
use Data::Printer ; 

my $objInitiator 				= 'ZnoteXtor::App::Utils::Initiator'->new(5) ; 
my $ProductInstanceDir 		= $objInitiator->doResolveMyProductInstanceDir();
my $appConfig				   = $objInitiator->get ('AppConfig'); 
# p $appConfig ; 
my $m = () ;            # the msg for each test 
my $objWtrFiles= 'ZnoteXtor::App::IO::Out::WtrFiles'->new();

$m = 'can create the WtrFiles obj' ; 
ok ( defined ( $objWtrFiles ) , "$m" );

my @methods = ('doPrintToFile' );
$m = 'an objWtrFiles has the following methods ' . @methods ; 
can_ok($objWtrFiles, @methods);

# how cool is that heh ?!
$m = 'the objWtrFiles can write a string to a file' ; 
$objWtrFiles->doPrintToFile( "$ProductInstanceDir/dat/tmp/.$$" , 'ok' ) ; 
my $str_file_cmd_out  = `cat "$ProductInstanceDir/dat/tmp/.$$"` ; 
chomp ( $str_file_cmd_out );

ok ( $str_file_cmd_out eq 'ok' , $m ); 
unlink "$ProductInstanceDir/dat/tmp/.$$" ; 

1;

