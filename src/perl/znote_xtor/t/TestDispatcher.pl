use strict ; use warnings ; 

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }
use Test::More tests => 3 ; 

use Data::Printer ; 
use ZnoteXtor::App::Utils::Initiator ; 
use ZnoteXtor::App::Utils::Configurator ; 
use ZnoteXtor::App::Ctrl::Dispatcher ; 


my $m                      = 'the msg for each test run' ; 
my $objInitiator 				= 'ZnoteXtor::App::Utils::Initiator'->new();	
my $appConfig					= {} ;
$appConfig                 = $objInitiator->get('AppConfig');

my  $objConfigurator
    = 'ZnoteXtor::App::Utils::Configurator'->new($objInitiator->{'ConfFile'},
    \$appConfig);
$appConfig                 = $objConfigurator->getConfHolder()  ;

$m = 'can create the Dispatcher obj' ; 
my $actions                = 'json-to-txt' ; 
my $objModel               = 'ZnoteXtor::App::Mdl::Model'->new ( \$appConfig ) ; 
$objModel->set('ctrl.actions' , $actions ) ; 
my $objDispatcher 			= 'ZnoteXtor::App::Ctrl::Dispatcher'->new(\$appConfig , \$objModel , 1 ) ; 
ok ( defined ( $objDispatcher ) , "$m" );

$m = "test-01 ensure the json-to-txt action calls the doJsonToTxt func" ;
my $functions              = $objDispatcher->doRun();
ok ( $functions eq 'doJsonToTxt' , $m ) ;  

my @methods = ('doRun' );
$m = 'an objDispatcher has the following methods ' . @methods ; 
can_ok($objDispatcher, @methods);

# FILE-UUID edc52a88-7521-4685-b010-d031e33aab07
