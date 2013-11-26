# chef-profile_d cookbook

* This cookbook will create a profile.d directory if one does not already exist.
* It will bootstrap profile.d scripts for OSX in bash/zsh startup files.

# Attributes

* default['profile_d']['root_path']
  - location of profile.d directory.
  - only created if missing
  - if pre-existing then owner and group are not modified
  - default value is '/etc/profile.d'

* default['profile_d']['owner']
  - owner of profile.d directory if it is created
  - default value is 'root'

* default['profile_d']['group']
  - group of profile.d directory if it is created
  - default value is 'wheel'

* default['profile_d']['bootstrap']
  - hash of { file => line }
  - file: shell startup file to be edit
  - line: line to enable profile.d scripts
  - only for OSX (linux already has profile.d support)

