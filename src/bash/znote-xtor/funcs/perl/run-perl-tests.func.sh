# src/bash/znote-xtor/funcs/run-perl-tests.func.sh

# v1.1.3
# ---------------------------------------------------------
# implement the calls to all the perl unit testing 
# ---------------------------------------------------------
doRunPerlTests(){
	
	doLog "DEBUG START : doRunPerlTests"

	doLog "INFO Component testing Initiator.pm with TestInitiator "
	perl src/perl/znote_xtor/t/TestInitiator.pl
	test -z "$sleep_interval" || sleep $sleep_interval

	doLog "INFO Component testing Configurator.pm with TestInitiator "
	perl src/perl/znote_xtor/t/TestConfigurator.pl
	test -z "$sleep_interval" || sleep $sleep_interval

	doLog "INFO Component testing Dispatcher.pm with TestDispatcher.pl"
   perl src/perl/znote_xtor/t/TestDispatcher.pl	
	test -z "$sleep_interval" || sleep $sleep_interval
	
   doLog "INFO Component testing Model.pm with TestModel.pl"
   # perl src/perl/znote_xtor/t/TestModel.pl	
	test -z "$sleep_interval" || sleep $sleep_interval

   doLog "INFO Unit testing or the SetGetable base module " 
   perl src/perl/znote_xtor/t/lib/ZnoteXtor/App/Utils/OO/TestSetGetable.pl
	test -z "$sleep_interval" || sleep $sleep_interval
   
   doLog "INFO Unit testing or the AutoLoadable  base module" 
   perl src/perl/znote_xtor/t/lib/ZnoteXtor/App/Utils/OO/TestAutoLoadable.pl
	test -z "$sleep_interval" || sleep $sleep_interval


}
# eof func doRunPerlTests


# eof file: src/bash/znote-xtor/funcs/run-perl-tests.func.sh
