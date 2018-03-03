#!/usr/bin/env perl
package znote_xtor;

use strict;
use warnings;
use utf8;
use strict;
use autodie;
use warnings;
use warnings qw< FATAL  utf8     >;
use open qw< :std  :utf8     >;
use charnames qw< :full >;
use feature qw< unicode_strings >;


require Exporter;
our @ISA         = qw(Exporter);
our %EXPORT_TAGS = ('all' => [qw()]);
our @EXPORT_OK   = (@{$EXPORT_TAGS{'all'}});
our @EXPORT      = qw($appConfig);
our $AUTOLOAD    = ();

use Data::Printer;
use Cwd qw ( abs_path );
use Getopt::Long;
use File::Basename qw< basename >;
use Carp qw< carp croak confess cluck >;
use Encode qw< encode decode >;
use Unicode::Normalize qw< NFD NFC >;

$| = 1;


BEGIN {
  use Cwd qw (abs_path);
  my $my_inc_path = Cwd::abs_path($0);

  $my_inc_path =~ m/^(.*)(\\|\/)(.*?)(\\|\/)(.*)/;
  $my_inc_path = $1;

  unless (grep { $_ eq "$my_inc_path" } @INC) {
    push(@INC, "$my_inc_path");
    $ENV{'PERL5LIB'} .= "$my_inc_path";
  }

  unless (grep { $_ eq "$my_inc_path/lib" } @INC) {
    push(@INC, "$my_inc_path/lib");
    $ENV{'PERL5LIB'} .= ":$my_inc_path/lib";
  }
}

END { close STDOUT }


# use own modules ...
use ZnoteXtor::App::Utils::Initiator;
use ZnoteXtor::App::Utils::Configurator;
use ZnoteXtor::App::Utils::Logger;
use ZnoteXtor::App::Utils::Timer;
use ZnoteXtor::App::Ctrl::Dispatcher;
use ZnoteXtor::App::IO::In::RdrCmdArgs ; 


# give a full stack dump on any untrapped exceptions
local $SIG{__DIE__} = sub {
  $0 = basename($0);    # shorter messages
  confess "\n\n\n FATAL Uncaught exception: @_" unless $^S;
};

# now promote run-time warnings into stackdumped exceptions
#   *unless* we're in an try block, in which
#   case just generate a clucking stackdump instead
local $SIG{__WARN__} = sub {
  $0 = basename($0);    # shorter messages
  if   ($^S) { cluck "\n\n WARN Trapped warning: @_" }
  else       { confess "\n\n WARN Deadly warning: @_" }
};


our $appConfig            = {} ;
our $objLogger            = {} ;
our $objModel             = {} ;
my $module_trace          = 0 ;
my $objInitiator          = {} ;
my $objConfigurator       = {} ;
my $actions               = q{} ;
my $dir_in                = q{} ;
my $dir_out               = q{} ;


#
# the main shell entry point of the application
#
sub main {

  my $msg = 'error during initialization of the tool !!! ';
  my $ret = 1;

  print " znote_xtor.pl START  \n ";
  ($ret, $msg) = doInitialize();
  doExit($ret, $msg) unless ($ret == 0);

  my $objDispatcher = 'ZnoteXtor::App::Ctrl::Dispatcher'->new(\$appConfig , \$objModel );
  ($ret, $msg) = $objDispatcher->doRun($actions);


  doExit($ret, $msg);

}



sub doInitialize {

  my $msg          = 'error during initialization !!!';
  my $ret          = 1;
  $objInitiator    = 'ZnoteXtor::App::Utils::Initiator'->new();
  $appConfig       = $objInitiator->get('AppConfig');

  $objConfigurator = 'ZnoteXtor::App::Utils::Configurator'->new(
      $objInitiator->{'ConfFile'}, \$appConfig);
  $appConfig       = $objConfigurator->getConfHolder()  ;

  $objModel        = 'ZnoteXtor::App::Mdl::Model'->new ( \$appConfig ) ; 
  my $objRdrCmdArgs 			= 'ZnoteXtor::App::IO::In::RdrCmdArgs'->new(\$appConfig , \$objModel ) ; 
  $objLogger = 'ZnoteXtor::App::Utils::Logger'->new(\$appConfig);
  my $m = "START MAIN";
  $objLogger->doLogInfoMsg($m);


  p($appConfig)  ; 

  $ret = 0;
  return ($ret, $msg);
}

# eof sub doInitialize


#
# pass the exit msg and the exit to the calling process
#
sub doExit {

  my $exit_code = shift;
  my $exit_msg = shift || 'exit znote_xtor.pl';

  if ($exit_code == 0) {
    $objLogger->doLogInfoMsg($exit_msg);
  }
  else {
    $objLogger->doLogErrorMsg($exit_msg);
    $objLogger->doLogFatalMsg($exit_msg);
  }

  my $msg = "STOP MAIN";
  $objLogger->doLogInfoMsg($msg);
  $msg = "19d94b2c-096c-4bf9-b6ba-780c3f90bf70";
  $objLogger->doRunLogMsg($msg);
  exit($exit_code);
}


# Action !!!
main();

