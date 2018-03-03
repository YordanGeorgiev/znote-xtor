use strict ; use warnings ; 

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }
use Test::More tests => 1 ; 

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

my $actions               		= 'json-to-txt' ; 
my $objModel               = 'ZnoteXtor::App::Mdl::Model'->new ( \$appConfig ) ; 
my $objLogger					= 'ZnoteXtor::App::Utils::Logger'->new(\$appConfig);
$objModel->set('ctrl.actions' , $actions ) ; 
my $objDispatcher 			= 'ZnoteXtor::App::Ctrl::Dispatcher'->new(\$appConfig , \$objModel , 1 ) ; 
my $functions              = $objDispatcher->doRun();
ok ( $functions eq 'doJsonToTxt' , "test-01 ensure the json-to-txt action calls the doJsonToTxt func" );


# FILE-UUID edc52a88-7521-4685-b010-d031e33aab07
