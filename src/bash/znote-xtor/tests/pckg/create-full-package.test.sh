#!/bin/bash 

#v1.1.0
#------------------------------------------------------------------------------
# tests the full package creation
#------------------------------------------------------------------------------
doTestCreateFullPackage(){
	cd $product_instance_dir
	doLog " INFO START : create-full-package.test"
	
	cat doc/txt/znote-xtor/tests/pckg/create-full-package.test.txt

	doSpecCreateFullPackage

	doHelpCreateFullPackage

   export exit_code=0
	bash src/bash/znote-xtor/znote-xtor.sh -a create-full-package
   export exit_code=$?
	doLog " create-relative-package.test-1 exit_code: $exit_code "
   sleep "$sleep_interval"
   test $exit_code -ne 0 && return

	bash src/bash/znote-xtor/znote-xtor.sh -a create-full-package -i $product_instance_dir/met/.tst.znote-xtor
   export exit_code=$?
	doLog " create-relative-package.test-1 exit_code: $exit_code "
   sleep "$sleep_interval"
   test $exit_code -ne 0 && return
	
	bash src/bash/znote-xtor/znote-xtor.sh -a create-full-package -i $product_instance_dir/met/.prd.znote-xtor
   export exit_code=$?
	doLog " create-relative-package.test-1 exit_code: $exit_code "
   sleep "$sleep_interval"
   test $exit_code -ne 0 && return
	
	bash src/bash/znote-xtor/znote-xtor.sh -a create-full-package -i $product_instance_dir/met/.git.znote-xtor
   export exit_code=$?
	doLog " create-relative-package.test-1 exit_code: $exit_code "
   sleep "$sleep_interval"
   test $exit_code -ne 0 && return
	

	doLog " INFO STOP  : create-full-package.test"
}
#eof test doCreateFullPackage
