#
# Cookbook Name:: profile_d
# Recipe:: default 
#
# Copyright (C) 2013 SendGrid
#
# All rights reserved - Do Not Redistribute
#

directory node['profile_d']['root_path'] do
  owner default['profile_d']['owner']
  group default['profile_d']['group']
  mode 00755
  action :create
  not_if { ::File.directory?(node['profile_d']['root_path']) }
end

startup_line = node['profile_d]['startup_line']
startup_files = node['profile_d']['startup_files']
existing_startup_files = startup_files.select{ |startup_file| ::File.exist?(startup_file) }
existing_startup_files.each do |startup_file|
  execute "echo '#{startup_line}' >> #{startup_file}" do
    not_if { File.read(startup_file).include?(startup_line) }
    only_if { node['platform'] == 'mac_os_x' }
  end
end
