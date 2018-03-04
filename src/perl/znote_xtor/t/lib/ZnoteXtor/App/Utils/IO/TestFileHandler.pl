use strict ; use warnings ; 
package TestFileHandler ; 


use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../../../../../../lib" }
BEGIN { unshift @INC, "$FindBin::Bin/" }

use ZnoteXtor::App::Utils::Initiator ; 
use ZnoteXtor::App::Utils::IO::FileHandler ; 
use Test::More tests => 2 ; 
use Data::Printer ; 


my $m = () ;            # the msg for each test 
my $objFileHandler= 'ZnoteXtor::App::Utils::IO::FileHandler'->new();

$m = 'can create the FileHandler obj' ; 
ok ( defined ( $objFileHandler ) , "$m" );


my @methods = ('doMkDir', 'doPrintToFile' , 'doReadFileReturnString' );
$m = 'an objFileHandler has the following methods ' . @methods ; 
can_ok($objFileHandler, @methods);

1;

