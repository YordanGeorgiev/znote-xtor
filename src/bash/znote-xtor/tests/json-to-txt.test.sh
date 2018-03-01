# src/bash/znote-xtor/funcs/json-to-txt.test.sh

# v1.0.9
# ---------------------------------------------------------
# doc/txt/znote-xtor/tests/json-to-txt.test.txt
# ---------------------------------------------------------
doTestJsonToTxt(){

	doLog "DEBUG START doTestJsonToTxt"
	
	cat doc/txt/znote-xtor/tests/json-to-txt.test.txt
	
	sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!
   bash src/bash/znote-xtor/znote-xtor.sh -a json-to-txt

	doLog "DEBUG STOP  doTestJsonToTxt"
}
# eof func doTestJsonToTxt


# eof file: src/bash/znote-xtor/funcs/json-to-txt.test.sh
