default['profile_d']['root_path'] = '/etc/profile.d'
default['profile_d']['owner'] = 'root'
default['profile_d']['group'] = 'wheel'
default['profile_d']['startup_files'] = w%{ /etc/profile /etc/zshenv }
default['profile_d']['startup_line'] = 'for f in `ls ' + node['profile_d']['root_path']+ '/*.sh 2> /dev/null`; do if [ -r $f ]; then . $f; fi; done'
