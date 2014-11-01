# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'fileutils'

def local_cache(basebox_name)
  cache_dir = Vagrant::Environment.new.home_path.join('cache',  basebox_name)
  FileUtils.mkpath cache_dir unless cache_dir.exist?
  cache_dir
end

ENV['VAGRANT_DEFAULT_PROVIDER'] = 'docker'

VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.synced_folder local_cache('ubuntu/trusty64'), 
                          "/var/cache/apt/archives/"

  config.vm.provider "docker" do |d|
    d.image      = "marklee77/baseimage-python-docker"
    d.cmd        = ["/sbin/my_init", "--enable-insecure-key"]
    d.has_ssh    = true
    d.privileged = true
  end

  config.ssh.username = "root"
  config.ssh.private_key_path = "keys/phusion.key"

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "provisioning/prep.yml"
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "provisioning/deploy.yml"
    ansible.extra_vars = {
      mariadb_dockerized_deployment: true
    }
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "provisioning/test.yml"
  end

end
