# src/bash/znote-xtor/funcs/json-to-txt.test.sh

# v1.0.9
# ---------------------------------------------------------
# cat doc/txt/znote-xtor/tests/json-to-txt.test.txt
# ---------------------------------------------------------
doTestJsonToTxt(){

	doLog "DEBUG START doTestJsonToTxt"
	
	sleep "$sleep_interval"
	
   # Action !!!
   bash src/bash/znote-xtor/znote-xtor.sh -a json-to-txt
   exit_code=$?
	doLog " json-to-txt exit_code: $exit_code "

   sleep "$sleep_interval"
   test $exit_code -ne 0 && return

	doLog "DEBUG STOP  doTestJsonToTxt"
}
# eof func doTestJsonToTxt


# eof file: src/bash/znote-xtor/funcs/json-to-txt.test.sh
