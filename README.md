# profile_d cookbook

This cookbook will create a profile.d directory if one does not already exist.
It will enable profile.d scirpts for OSX in bash/zsh startup files.

ATTRIBUTES

* default['profile_d']['root_path']
  - location of profile.d directory.
  - only created if missing
  - if existing owner,group are not modified
  - defualt value is '/etc/profile.d'

* default['profile_d']['owner']
  - owner of profile.d directory if it is created
  - default value is 'root'

* default['profile_d']['group']
  - group of profile.d directory if it is created
  - default value is 'wheel'

* default['profile_d']['startup_files']
  - array of files that edited to enable profile.d scripts
  - each will will be appended with startup_line
  - only for OSX (linux already has profile.d support) 
  - default value is ['/etc/profile', '/etc/zshrc']

* default['profile_d']['startup_line']
  - line appended to each startup file to enable profile.d scripts
  - if line already exists in startup file it is not twice
  - only for OSX (linux already has profile.d support) 
  - default value is 'for f in `ls ' + node['profile_d']['root_path']+ '/*.sh 2> /dev/null`; do if [ -r $f ]; then . $f; fi; done'
