#default['WebSphereAS85']['version'] = '1.8.3'
default['WebSphereAS85']['name'] = 'WebSphereAS85'
default['WebSphereAS85']['message'] = 'Installing WebSphere Application Server version 8.5.5 to /opt/IBM/WebSphere'
default['WebSphereAS85']['package-name-1'] = 'WASND_v8.5.5_1of3.zip'
default['WebSphereAS85']['package-name-2'] = 'WASND_v8.5.5_2of3.zip'
default['WebSphereAS85']['package-name-3'] = 'WASND_v8.5.5_3of3.zip'
#default['WebSphereAS85']['webserver'] = 'http://9.191.4.209'
default['WebSphereAS85']['webserver'] = 'http://9.191.4.227'
default['WebSphereAS85']['was_version'] = '1.8.3000.20150606_0047'
default['WebSphereAS85']['was_install_dir'] = '/opt/IBM/WebSphere'
default['WebSphereAS85']['imshared_install_dir'] = 'opt/IBM/IMShared'
default['WebSphereAS85']['imagentdata_install_dir'] = '/opt/IBM/IMAgentData'
default['WebSphereAS85']['imcl_install_dir'] = '/opt/IBM/IMAgentData'
default['WebSphereAS85']['was-responsefile'] = 'WAS85Install.xml'
default['WebSphereAS85']['was-id'] = 'IBM WebSphere Application Server'
default['WebSphereAS85']['package1-sha256sum'] = 'b1333962ba4b25c8632c7e4c82b472350337e99febac8f70ffbd551ca3905e83'
default['WebSphereAS85']['package2-sha256sum'] = '440b7ed82089d43b1d45c1e908bf0a1951fed98f2542b6d37c8b5e7274c6b1c9'
default['WebSphereAS85']['package3-sha256sum'] = 'b73ae070656bed6399a113c2db9fb0abaf5505b0d41c564bf2a58ce0b1e0dcd2'
#default['WebSphereAS85']['package1-sha256sum'] = '6b6e92180c1debd50fb74b83f836474bcc72ed387441408a42f14d3fffcb5292'
#default['WebSphereAS85']['package2-sha256sum'] = '287179676db4a8b647a4b586d1bc8695d44a68c983b5719508c2e5631a044d65'
#default['WebSphereAS85']['package3-sha256sum'] = '2f811a8a1b0973c68c2f8220a6cb6f1a1bd374cad2ade204e74f61b096a7ffd5'
default['WebSphereAS85']['imcl-path'] = '/opt/IBM/InstallationManager/eclipse/tools/imcl'
default['WebSphereAS85']['was85-packageid'] = 'com.ibm.websphere.ND.v85'
default['WebSphereAS85']['was85-profiledesc'] = 'IBM WebSphere Application Server V8.5'
default['WebSphereAS85']['was85-features'] = 'core.feature,com.ibm.sdk.6_64bit'
default['WebSphereAS85']['was85-installpath'] = '/opt/IBM/WebSphere/AppServer'
default['WebSphereAS85']['was85-binpath'] = '/opt/IBM/WebSphere/AppServer/bin'
default['WebSphereAS85']['was85-dmgrname'] = 'Dmgr01'
default['WebSphereAS85']['was85-appsrvname'] = 'ManagedAppServers'
default['WebSphereAS85']['was85-user'] = 'wasuser'
default['WebSphereAS85']['was85-group'] = 'wasgrp'
default['WebSphereAS85']['was85-home'] = '/home/wasuser'