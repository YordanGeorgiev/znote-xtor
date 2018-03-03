use strict ; use warnings ; 

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }
use Test::More tests => 4 ; 

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
my $objModel             = 'ZnoteXtor::App::Mdl::Model'->new ( \$appConfig ) ; 
my $objRdrCmdArgs 			= 'ZnoteXtor::App::IO::In::RdrCmdArgs'->new(\$appConfig , \$objModel ) ; 
push @ARGV , '--do run' ; 
push @ARGV , '--in-dir in' ; 
push @ARGV , '--out-dir out' ; 

$msg = 'ensure the objRdrCmdArgs can be created ' ; 
ok ( ref $objRdrCmdArgs eq 'ZnoteXtor::App::IO::In::RdrCmdArgs' , $msg ) ; 

$msg = 'ensure the actions are passed to the model' ; 
ok ( $objModel->get('ctrl.actions') eq 'run' , $msg ) ; 

$msg = 'ensure the in dir is passed to the model' ; 
ok ( $objModel->get('in.dir') eq 'in' , $msg ) ; 

$msg = 'ensure the out dir is passed to the model' ; 
ok ( $objModel->get('out.dir') eq 'out' , $msg ) ; 

# FILE-UUID 7bf7ee86-58f3-417a-8413-929131912912
