#
# Cookbook Name:: profile_d
# Recipe:: default 
#
# Copyright (C) 2013 SendGrid
#
# All rights reserved - Do Not Redistribute
#

# create profile.d directory
directory node['profile_d']['root_path'] do
  owner node['profile_d']['owner']
  group node['profile_d']['group']
  mode 00755
  action :create
  not_if { ::File.directory?(node['profile_d']['root_path']) }
end

# bootstrap profile.d scripts into shell startup files
node['profile_d']['bootstraps'].each_pair do |file, line|
  profile_d_bootstrap file do
    append line
    only_if { node['platform'] == 'mac_os_x' }
  end
end
