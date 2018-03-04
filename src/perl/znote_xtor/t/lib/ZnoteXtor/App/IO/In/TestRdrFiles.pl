use strict ; use warnings ; 
package TestRdrFiles ; 


use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../../../../../../lib" }
BEGIN { unshift @INC, "$FindBin::Bin/" }

use ZnoteXtor::App::Utils::Initiator ; 
use ZnoteXtor::App::IO::In::RdrFiles ; 

use Test::More tests => 3 ; 
use Data::Printer ; 

my $objInitiator 				= 'ZnoteXtor::App::Utils::Initiator'->new(5) ; 
my $ProductInstanceDir 		= $objInitiator->doResolveMyProductInstanceDir();
my $appConfig				   = $objInitiator->get ('AppConfig'); 
# p $appConfig ; 
my $m = () ;            # the msg for each test 
my $objRdrFiles= 'ZnoteXtor::App::IO::In::RdrFiles'->new();

$m = 'can create the RdrFiles obj' ; 
ok ( defined ( $objRdrFiles ) , "$m" );

my @methods = ('doReadFileReturnString' );
$m = 'an objRdrFiles has the following methods ' . @methods ; 
can_ok($objRdrFiles, @methods);

# how cool is that heh ?!
$m = 'the objRdrFiles can read a file into string' ; 
my $str_file = $objRdrFiles->doReadFileReturnString ( $0 ) ; 
my $str_file_cmd_out  = `cat $0` ; 

ok ( $str_file eq $str_file_cmd_out , $m ); 

1;

