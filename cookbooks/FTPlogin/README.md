FTPlogin Cookbook
=================
This cookbook creates a password-less SSH login on ubuntu. 

I use this cookbook to scp binaries for my other cookbooks WebSphere Application Server and WebSphere BPM

Requirements
------------
Platforms: Ubuntu 14.04, 15.04


Attributes
----------
default['FTPlogin']['binaryhost'] = 'Enter the IP you want to ssh/scp to'
default['FTPlogin']['ftploginuser'] = 'user name you want to ssh with'
default['FTPlogin']['binarydir'] = 'Location where you store your files'
default['FTPlogin']['ftploginpwd'] = 'Password for the user above'


Usage
-----
#### FTPlogin::default
Add to the node's run list

knife node run_list add <node name> 'recipe[FTPlogin::default]'
```

License and Authors
-------------------
Rohit Gabriel, Auckland, New Zealand 
Profile: https://nz.linkedin.com/in/rohit-gabriel-22a76320
