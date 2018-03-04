use strict ; use warnings ; 
package TestWtrDirs ; 


use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../../../../../../lib" }
BEGIN { unshift @INC, "$FindBin::Bin/" }

use ZnoteXtor::App::Utils::Initiator ; 
use ZnoteXtor::App::IO::Out::WtrDirs ; 

use Test::More tests => 3 ; 
use Data::Printer ; 

my $objInitiator 				= 'ZnoteXtor::App::Utils::Initiator'->new(5) ; 
my $ProductInstanceDir 		= $objInitiator->doResolveMyProductInstanceDir();
my $appConfig				   = $objInitiator->get ('AppConfig'); 
# p $appConfig ; 
my $m = () ;            # the msg for each test 
my $objWtrDirs= 'ZnoteXtor::App::IO::Out::WtrDirs'->new();

$m = 'can create the WtrDirs obj' ; 
ok ( defined ( $objWtrDirs ) , "$m" );

my @methods = ('doMkDir' );
$m = 'an objWtrDirs has the following methods ' . @methods ; 
can_ok($objWtrDirs, @methods);

$objWtrDirs->doMkDir( "$ProductInstanceDir/dat/tmp/.$$" );
# p $arrRef ; 
my $str_cmd_output = `test -d "$ProductInstanceDir/dat/tmp/.$$" && echo ok` ; 
chomp ( $str_cmd_output ); 

$m = 'the objWtrDirs can create a dir' ; 
ok ( $str_cmd_output eq 'ok' , $m ); 

rmdir "$ProductInstanceDir/dat/tmp/.$$" ; 

1;
