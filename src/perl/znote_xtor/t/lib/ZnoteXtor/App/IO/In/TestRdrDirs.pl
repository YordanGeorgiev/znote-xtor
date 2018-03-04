use strict ; use warnings ; 
package TestRdrDirs ; 


use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../../../../../../lib" }
BEGIN { unshift @INC, "$FindBin::Bin/" }

use ZnoteXtor::App::Utils::Initiator ; 
use ZnoteXtor::App::IO::In::RdrDirs ; 

use Test::More tests => 3 ; 
use Data::Printer ; 

my $objInitiator 				= 'ZnoteXtor::App::Utils::Initiator'->new(5) ; 
my $ProductInstanceDir 		= $objInitiator->doResolveMyProductInstanceDir();
my $appConfig				   = $objInitiator->get ('AppConfig'); 
# p $appConfig ; 
my $m = () ;            # the msg for each test 
my $objRdrDirs= 'ZnoteXtor::App::IO::In::RdrDirs'->new();

$m = 'can create the RdrDirs obj' ; 
ok ( defined ( $objRdrDirs ) , "$m" );

my @methods = ('doReadDirGetFilesByExtension' );
$m = 'an objRdrDirs has the following methods ' . @methods ; 
can_ok($objRdrDirs, @methods);

my $arrRef = $objRdrDirs->doReadDirGetFilesByExtension ( $ProductInstanceDir , 'pm|pl' ); 
# p $arrRef ; 
my @sorted_arr = sort @$arrRef ; 
my $str_cmd_output = `find $ProductInstanceDir -name '*.pl' -o -name '*.pm'` ; 
my @cmd_arr = sort(split '\n' , $str_cmd_output );

$m = 'the objRdrDirs can return the files by extenstion from a dir' ; 
ok ( @sorted_arr == @cmd_arr , $m ); 

1;
