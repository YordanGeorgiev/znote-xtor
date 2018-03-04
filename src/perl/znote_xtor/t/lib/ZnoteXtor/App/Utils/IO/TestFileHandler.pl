use strict ; use warnings ; 
package TestFileHandler ; 


use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../../../../../../lib" }
BEGIN { unshift @INC, "$FindBin::Bin/" }

use ZnoteXtor::App::Utils::Initiator ; 
use ZnoteXtor::App::Utils::IO::FileHandler ; 
use Test::More tests => 3 ; 
use Data::Printer ; 

my $objInitiator 				= 'ZnoteXtor::App::Utils::Initiator'->new(5) ; 
my $ProductInstanceDir 		= $objInitiator->doResolveMyProductInstanceDir();
my $appConfig				   = $objInitiator->get ('AppConfig'); 
p $appConfig ; 
my $m = () ;            # the msg for each test 
my $objFileHandler= 'ZnoteXtor::App::Utils::IO::FileHandler'->new();

$m = 'can create the FileHandler obj' ; 
ok ( defined ( $objFileHandler ) , "$m" );

my @methods = ('doMkDir', 'doPrintToFile' , 'doReadFileReturnString' , 'doReadFileReturnArrayRef' );
$m = 'an objFileHandler has the following methods ' . @methods ; 
can_ok($objFileHandler, @methods);

my $arrRef = $objFileHandler->doReadDirGetFilesByExtension ( $ProductInstanceDir , 'pm|pl' ); 
# p $arrRef ; 
my @sorted_arr = sort @$arrRef ; 
my $str_cmd_output = `find $ProductInstanceDir -name '*.pl' -o -name '*.pm'` ; 
my @cmd_arr = sort(split '\n' , $str_cmd_output );

$m = 'the objFileHandler can return the files by extenstion from a dir' ; 
ok ( @sorted_arr == @cmd_arr , $m ); 



1;

