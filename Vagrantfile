# -*- mode: ruby -*-
# vi: set ft=ruby :

def local_cache(basebox_name)
  cache_dir = Vagrant::Environment.new.home_path.join('cache', 'apt', basebox_name)
  partial_dir = cache_dir.join('partial')
  partial_dir.mkdir unless partial_dir.exist?
  cache_dir
end

VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "ubuntu/trusty64"
  config.vm.provider "virtualbox" do |v|
    v.memory = 1280
  end
  cache_dir = local_cache(config.vm.box)
  config.vm.share_folder "v-cache", "/var/cache/apt/archives/", cache_dir


  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "getroles.yml"
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "prep.yml"
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "deploy.yml"
    ansible.extra_vars = {
      mariadb_dockerized_deployment: true
    }
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "demo.yml"
  end

end
