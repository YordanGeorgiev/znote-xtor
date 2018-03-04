# src/bash/znote-xtor/funcs/json-to-txt.func.sh

# v1.0.0
# ---------------------------------------------------------
# cat doc/txt/znote-xtor/funcs/json-to-txt.func.txt
# ---------------------------------------------------------
doJsonToTxt(){

	doLog "DEBUG START doJsonToTxt"
   export exit_code=1 # assume error 
   export exit_msg='failed to run the json-to-txt action' 
	
	sleep "$sleep_interval"
	# Action !!!
   perl src/perl/znote_xtor/script/znote_xtor.pl \
      --do json-to-txt --in-dir /tmp/zeppelin-542/ --out-dir /tmp/zeppelin-542-out/
  export exit_code=$? ;  doExit "$msg" ;

	doLog "DEBUG STOP  doJsonToTxt"
}
# eof func doJsonToTxt


# eof file: src/bash/znote-xtor/funcs/json-to-txt.func.sh
