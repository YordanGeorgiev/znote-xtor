use strict ; use warnings ; 

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }
use Test::More tests => 1 ; 

use Getopt::Long;
use ZnoteXtor::App::Utils::Initiator ; 
use ZnoteXtor::App::Utils::Logger ; 
use Data::Printer ; 
use ZnoteXtor::App::Utils::Configurator ; 
use ZnoteXtor::App::IO::In::RdrCmdArgs ; 


my $objInitiator 				= 'ZnoteXtor::App::Utils::Initiator'->new();	
my $appConfig					= {} ;
my $msg                    = q{} ; 

$appConfig                 = $objInitiator->get('AppConfig');

my  $objConfigurator
    = 'ZnoteXtor::App::Utils::Configurator'->new($objInitiator->{'ConfFile'},
    \$appConfig);

$appConfig                 = $objConfigurator->getConfHolder()  ;

my $objLogger					= 'ZnoteXtor::App::Utils::Logger'->new(\$appConfig);
my $objRdrCmdArgs 			= 'ZnoteXtor::App::IO::In::RdrCmdArgs'->new(\$appConfig ) ; 

$msg = 'ensure the objRdrCmdArgs can be created ' ; 
ok ( ref $objRdrCmdArgs eq 'ZnoteXtor::App::IO::In::RdrCmdArgs' , $msg ) ; 


# FILE-UUID 7bf7ee86-58f3-417a-8413-929131912912
