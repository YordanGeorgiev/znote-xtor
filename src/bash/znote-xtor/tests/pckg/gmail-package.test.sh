# src/bash/znote-xtor/funcs/gmail-package.test.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doTestGmailPackage comments ...
# ---------------------------------------------------------
doTestGmailPackage(){

	doLog "DEBUG START doTestGmailPackage"
	
   cat doc/txt/znote-xtor/tests/pckg/gmail-package.test.txt
	sleep "$sleep_interval"

	bash src/bash/znote-xtor/znote-xtor.sh -a create-full-package -a gmail-package
	sleep "$sleep_interval"
   printf "\033[2J";printf "\033[0;0H"

	doLog "DEBUG STOP  doTestGmailPackage"
}
# eof func doTestGmailPackage


# eof file: src/bash/znote-xtor/funcs/gmail-package.test.sh
