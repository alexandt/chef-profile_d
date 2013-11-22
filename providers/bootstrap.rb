action :create do
  file = new_resource.name
  line = new_resource.append

  execute "echo '#{line}' >> #{file}" do
    not_if { ::File.read(file).include?(line) }
  end

end

#TODO: implement delete action