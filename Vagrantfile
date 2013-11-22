# -*- mode: ruby -*-
# vi: set ft=ruby :

require "vagrant"

if Vagrant::VERSION < "1.2.1"
  raise "This is only compatible with Vagrant 1.2.1+"
end

project_name = File.basename(Dir.getwd)
python_version = File.exist?('.python-version') ? File.read('.python-version') : '2.6.5'

Vagrant.configure("2") do |config|

  config.vm.hostname = "#{project_name}-build"
  config.ssh.forward_agent = true
  config.berkshelf.enabled = true

  config.vm.define 'centos-6', primary: true do |c|
    c.berkshelf.berksfile_path = "./Berksfile"
    # TODO Should we randomize or increment IP address?  Does it make a diff
    # to parallel runs?
    c.vm.network "private_network", ip: "192.168.100.2"
    c.vm.box = "sendgrid_centos-6.4_chef-11.8.0"
    c.vm.box_url = "http://repo.sendgrid.net/sendgrid_centos-6.4_chef-11.8.0.box"
  end

  config.vm.provider :virtualbox do |vb|
    vb.customize [
      "modifyvm", :id,
      "--memory", "1536",
      "--cpus", "2"
    ]
  end

  host_project_path = File.expand_path("..", __FILE__)
  guest_project_path = "/home/vagrant/#{project_name}"
  config.vm.synced_folder host_project_path, guest_project_path, nfs: true

  # *** If you want to pull in newer upstream packages, dump them in ci-repo
  # in this repos folder and the package manager will be able to see them.
  # NOTE You may still need to update dependencies to grab newer versions
  config.vm.synced_folder "./ci-repo", "/tmp/ci-repo" if File.exist?("./ci-repo")

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.add_recipe "ci_dependencies" if ::File.directory?("cookbooks/ci_dependencies")
    chef.add_recipe "sendgrid::workstation"
    chef.add_recipe "rbenv::"
    chef.json = {
        :sendgrid => {
            :workstation => {
                :ruby => {
                    :env_tool => "rbenv"
                }
            }
        }
    }
  end
end
