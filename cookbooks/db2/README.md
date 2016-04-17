db2 Cookbook
============


This cookbook installs IBM DB2 Enterprise Server version 10.1.1 at /opt/IBM/InstallationManager path.
This cookbook creates a DB2 instance with three databases in it. The names of the databases are specific to the WebSphere BPM requirements.

This cookbook can be used with my FTPlogin cookbook to scp binaries required to copy. I am not including the binaries in this cookbook.

The code also verifies the checksum of the files after copying to the node. The install will fail if the checksum fails.

Requirements
------------
Platforms: Ubuntu 15.04

Attributes
----------
default['db2']['package-name-1'] = 'DB2_ESE_10_Linux_x86-64.tar.gz'

default['db2']['binaryhost'] = 'Server where binaries are hosted'

default['db2']['ftploginuser'] = 'User to login to the binary host'

default['db2']['ftppath'] = 'Path where binaries are stored'

default['db2']['package1-sha256sum'] = 'b7b0e3902ffcfa4851e542e7ddb345623f2391635f212cc62113dee48e6b64f3'

default['db2']['db2-responsefile'] = 'db2_Response_File_Install.rsp'

default['db2']['db2inst1-INS'] = 'db2inst1.rsp'

default['db2']['db2_install_dir'] = '/opt/ibm/db2/10.1'

default['db2']['install_type'] = 'CUSTOM'

default['db2']['db2inst1-user'] = 'db2inst1'

default['db2']['db2fence1-user'] = 'db2fenc1'

default['db2']['db2inst1-group'] = 'db2iadm1'

default['db2']['db2fence1-group'] = 'db2fadm1'

default['db2']['db2_password'] = 'W1zplay11'

default['db2']['db2inst1-home'] = '/home/db2inst1'

default['db2']['db2fence1-home'] = '/home/db2fenc1'

default['db2']['db2user1-home'] = '/home/bpmuser'

default['db2']['db2user1-user'] = 'bpmuser'

default['db2']['db2user1-group'] = 'bpmuser'

default['db2']['packagefp1-name-1'] = 'v10.1fp1_linuxx64_server.tar.gz'

default['db2']['packagefp1-sha256sum'] = 'cc3d67599f19a3d9b6bcbd2cead27404564fc05ba8909da49891939ad7e0beff'


Usage
-----
Add to the node's run list

knife node run_list remove BPMNode 'recipe[db2::default]'

knife node run_list remove BPMNode 'recipe[db2::installfp]'

knife node run_list remove BPMNode 'recipe[db2::instance]'

knife node run_list remove BPMNode 'recipe[db2::createdb]'


recipe::default installs Db2 10.1

recipe::installfp installs Db2 10.1.1 fixpack

recipe::instance creates Db2 database instance

recipe::createdb creates three Db2 databases required for WebSphere BPM

License and Authors
-------------------
Rohit Gabriel, Auckland, New Zealand.

Profile: https://nz.linkedin.com/in/rohit-gabriel-22a76320
