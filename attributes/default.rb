default['profile_d']['root_path'] = '/etc/profile.d'
default['profile_d']['owner'] = 'root'
default['profile_d']['group'] = 'wheel'

default['profile_d']['bootstraps'] = {
    '/etc/profile' => 'for f in `ls ' + node['profile_d']['root_path'] + '/* 2> /dev/null`; do if [ -r $f ]; then . $f; fi; done',
    '/etc/zshenv' => 'for f in ' + node['profile_d']['root_path'] + '/*(N); do if [ -r $f ]; then . $f; fi; done'
}
