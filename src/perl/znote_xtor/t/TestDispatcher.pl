use strict ; use warnings ; 

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }
use Test::More tests => 3 ; 

use Getopt::Long;
use ZnoteXtor::App::Utils::Initiator ; 
use ZnoteXtor::App::Utils::Logger ; 
use Data::Printer ; 
use ZnoteXtor::App::Utils::Configurator ; 
use ZnoteXtor::App::Ctrl::Dispatcher ; 


my $objInitiator 				= 'ZnoteXtor::App::Utils::Initiator'->new();	
my $appConfig					= {} ;

$appConfig                 = $objInitiator->get('AppConfig');

my  $objConfigurator
    = 'ZnoteXtor::App::Utils::Configurator'->new($objInitiator->{'ConfFile'},
    \$appConfig);

$appConfig                 = $objConfigurator->getConfHolder()  ;

my $actions               	= 'db-to-xls' ; 
my $objLogger					= 'ZnoteXtor::App::Utils::Logger'->new(\$appConfig);
my $objDispatcher 			= 'ZnoteXtor::App::Ctrl::Dispatcher'->new(\$appConfig , 1);
my $functions              = $objDispatcher->doRun($actions);
ok ( $functions eq 'doDbToXls' , "test-01 ensure the db-to-xls action calls the doDbToXls func" );

$actions               		= 'xls-to-db' ; 
$functions              	= $objDispatcher->doRun($actions);
ok ( $functions eq 'doXlsToDb' , "test-02 ensure the db-to-xls action calls the doDbToXls func" );
 
$actions               		= 'txt-to-db' ; 
$functions              	= $objDispatcher->doRun($actions);
ok ( $functions eq 'doTxtToDb' , "test-03 ensure the txt-to-db action calls the doTxtToDb func" );

# FILE-UUID edc52a88-7521-4685-b010-d031e33aab07
