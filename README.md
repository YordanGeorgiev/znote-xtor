#  znote-xtor


Table of Contents

  * [1. WHAT IS THIS ?!](#1-what-is-this-)
  * [2. INSTALLATION AND CONFIGURATION](#2-installation-and-configuration)
    * [2.1. Prerequisites](#21-prerequisites)
    * [2.2. Fetch the source](#22-fetch-the-source)
    * [2.3. run the boot-strap script](#23-run-the-boot-strap-script)
    * [2.4. Install the required Perl modules](#24-install-the-required-perl-modules)
    * [2.5. Start hacking](#25-start-hacking)
  * [3. ADDITIONAL DOCS](#3-additional-docs)
  * [4. AND FINALLY THE PROJECT STATUS](#4-and-finally-the-project-status)


    

## 1. What is this ?!
A tool to export your zeppelin notes' paragraphs into files per note dir.

## 2. INSTALLATION AND CONFIGURATION


### 2.1. Prerequisites
The must have binaries are:
 bash, perl, zip


    # use your OS package manager … if you are not on Ubuntu 
    
    sudo apt-get autoclean
    sudo apt-get install --only-upgrade bash
    
    sudo apt-get install -y perl
    
    # optionally 
    sudo apt-get install -y excuberant-ctags
    
    sudo apt-get upgrade

### 2.2. Fetch the source
Fetch the source from git hub as follows:

    # got to a dir you have write permissions , for example:
    cd ~ 
    
    # fetch the source
    git clone git@github.com:YordanGeorgiev/znote-xtor.git

### 2.3. run the boot-strap script
The bootstrap script will interpolate change the git deployment dir to a "product_instance_dir" ( your instance of the znote-xtor, having the same version as this one, but running on a different host with different owner - you ! ). Why ?! Because every frog should stay in it's own swamp ...

    # defiine the latest and greates product_version
    export product_version=$(cd znote-xtor;git tag|sort -nr| head -n 1;cd ..)
    
    # run the bootstrap script : 
    bash znote-xtor/src/bash/znote-xtor/bootstrap-znote-xtor.sh
    
    # now go to your product instance dir , note it is a DEV environment
    cd /opt/csitea/znote-xtor/znote-xtor.$product_version.dev.$USER
    

### 2.4. Install the required Perl modules
Just run the prerequisites checker script which will provide you with copy pastable instructions

    sudo perl src/perl/znote_xtor/script/znote_xtor_preq_checker.pl
    
    # after installing all the modules check the perl syntax of the whole project:
    bash src/bash/znote-xtor/znote-xtor.sh -a check-perl-syntax

### 2.5. Start hacking
Start usage:

    # ensure your perl proj compiles ... it did on my machine just before publish ...
    bash src/bash/znote-xtor/znote-xtor.sh -a check-perl-syntax


    # The Bief !
    perl src/perl/znote_xtor/script/znote_xtor.pl \
         --do json-to-txt --in-dir <<the-input-dir-of-your-json-note-files>> \
         --out-dir <<the-output-dir-for-the-converted-paragraph-files>>

    # optional run all the perl unit tests
    bash src/bash/znote-xtor/znote-xtor.sh -a run-perl-tests

    # or even 
    bash src/bash/znote-xtor/test-znote-xtor.sh


## 3. ADDITIONAL DOCS
For now no additional docs are provided - in future they might appear in the docs/md and/or docs/pdf
dirs. 
