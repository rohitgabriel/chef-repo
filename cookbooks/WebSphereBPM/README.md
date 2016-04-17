WebSphereBPM Cookbook
======================

This cookbook installs WebSphere Business Process Manager version 8.5.5 and configures a cell.
Creates Deployment Manager, creates BPM Application Server Node and federates the node to create a cell with three cluster topology.

Assumptions:
This cookbook assumes that Installation Manager is  installed at /opt/IBM/InstallationManager path. You can use my 'InstallationManager' cookbook to achieve this with chef.
This cookbook assumes that IBM DB2 v 10.1.1 is installed at /opt/ibm/db2 path and the necessary BPM databases are created. You can use my 'db2' cookbook to achieve this with chef.

I did not make this a dependency for various reasons, but I have tested that including as a dependency works just fine.
This cookbook can be used with my FTPlogin cookbook to scp binaries required to copy. I am not including the binaries in this cookbook.

The code also verifies the checksum of the files after copying to the node. The install will fail if the checksum fails.

Requirements
------------
Platforms: Ubuntu 15.04

Attributes
----------
default['WebSphereBPM']['was_install_dir'] = '/opt/IBM/WebSphere'

default['WebSphereBPM']['imshared_install_dir'] = 'opt/IBM/IMShared'

default['WebSphereBPM']['imcl_install_dir'] = '/opt/IBM/InstallationManager'

default['WebSphereBPM']['imagentdata_install_dir'] = '/opt/IBM/IMAgentData'

default['WebSphereBPM']['package-name-1'] = 'BPM_Adv_V855_Linux_x86_1_of_3.tar.gz'

default['WebSphereBPM']['package-name-2'] = 'BPM_Adv_V855_Linux_x86_2_of_3.tar.gz'

default['WebSphereBPM']['package-name-3'] = 'BPM_Adv_V855_Linux_x86_3_of_3.tar.gz'

default['WebSphereBPM']['package1-sha256sum'] = 'd065493340e830ded1eb1f7e29a851292447d234348c50da9d37017473ef71ed'

default['WebSphereBPM']['package2-sha256sum'] = '049a774ff4704ca06001185875307f2eba3bb97e4082d16c871e89dddaa05abe'

default['WebSphereBPM']['package3-sha256sum'] = '778d5d9ef80b0aac20e928be8f2858ce6478cc2da2e31ee2686b2ea5a204aba9'

default['WebSphereBPM']['binaryhost'] = 'Host where you keep the above binaries'

default['WebSphereBPM']['bpmuser'] = 'bpmuser'

default['WebSphereBPM']['bpmgroup'] = 'wasgrp'

default['WebSphereBPM']['bpmuserhome'] = '/home/bpmuser'

default['WebSphereBPM']['ftploginuser'] = 'User to login to the binary host with'
default['WebSphereBPM']['ftppath'] = 'Path where you store the binaries'

default['WebSphereBPM']['bpm-responsefile'] = 'BPM-responsefile.xml'

default['WebSphereBPM']['bpm-installpath'] = '/opt/IBM/WebSphere/BPM/v8.5'

default['WebSphereBPM']['imcl-path'] = '/opt/IBM/InstallationManager/eclipse/tools/imcl'

default['WebSphereBPM']['bpm-path'] = '/opt/IBM/WebSphere/BPM/v8.5/bin'

default['WebSphereBPM']['bpmdmgrbin'] = '/opt/IBM/WebSphere/BPM/v8.5/profiles/Dmgr/bin'

default['WebSphereBPM']['db2password'] = 'W1zplay11'

default['WebSphereBPM']['bpmuser'] = 'bpmadmin'

default['WebSphereBPM']['bpmpassword'] = 'W1zplay11'

default['WebSphereBPM']['Advanced-PS-ThreeClusters-DB2-props'] = 'Advanced-PS-ThreeClusters-DB2.properties'

default['WebSphereBPM']['bpmdmgrnodename'] = 'DMGRNode'

default['WebSphereBPM']['bpmcellname'] = 'BPMCell'

default['WebSphereBPM']['bpmdmgrpath'] = '/opt/IBM/WebSphere/BPM/v8.5/profiles/Dmgr'

default['WebSphereBPM']['bpmdmgrname'] = 'Dmgr'

default['WebSphereBPM']['bpmdmgrsoapport'] = '8879'

default['WebSphereBPM']['bpmnodename'] = 'ManagedAppServers'



Usage
-----
Add to the node's run list

knife node run_list remove BPMNode 'recipe[FTPlogin::default]'
knife node run_list remove BPMNode 'recipe[InstallationManager::default]'
knife node run_list remove BPMNode 'recipe[db2::default]'
knife node run_list remove BPMNode 'recipe[db2::installfp]'
knife node run_list remove BPMNode 'recipe[db2::instance]'
knife node run_list remove BPMNode 'recipe[db2::createdb]'
knife node run_list remove BPMNode 'recipe[WebSphereBPM::default]'
knife node run_list remove BPMNode 'recipe[WebSphereBPM::createDE]'
knife node run_list remove BPMNode 'recipe[WebSphereBPM::bootstrap]'
knife node run_list remove BPMNode 'recipe[WebSphereBPM::startDE]'

License and Authors
-------------------
Rohit Gabriel, Auckland, New Zealand.

Profile: https://nz.linkedin.com/in/rohit-gabriel-22a76320
