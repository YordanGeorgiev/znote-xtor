# src/bash/znote-xtor/funcs/log-test-run-entry.test.sh

# 
# ---------------------------------------------------------
# todo: add doTestLogTestRunEntry comments ...
# ---------------------------------------------------------
doTestLogTestRunEntry(){

	doLog "DEBUG START doTestLogTestRunEntry"
	
	cat doc/txt/znote-xtor/tests/log-test-run-entry.test.txt
	
	sleep "$sleep_interval"

   action_n='some-action-name'

   # should initialize the test run report
   doLogTestRunEntry 'INIT'

   doLogTestRunEntry 'START'
   
   # should register the test line start time
   doLogTestRunEntry 'INFO' ' '$(date "+%H:%M:%S")
   
   # should register the test line stop time
   doLogTestRunEntry 'INFO' ' '$(date "+%H:%M:%S")
   
   # should addd the name of the action to test 
   doLogTestRunEntry 'INFO' ' '"$action_n"
   
   # should close the test run line
   doLogTestRunEntry 'STOP' 0
   
   # should close and print the test run report 
   doLogTestRunEntry 'STATUS'

	doLog "DEBUG STOP  doTestLogTestRunEntry"
}
# eof func doTestLogTestRunEntry


# eof file: src/bash/znote-xtor/funcs/log-test-run-entry.test.sh
