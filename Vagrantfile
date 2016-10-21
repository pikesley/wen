# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box      = 'debian/jessie64'
  config.vm.hostname = 'wen-vagrant'
  config.vm.network    'public_network'

  config.vm.provision 'chef_solo' do |chef|
    chef.recipe_url = 'http://pikesley.org/cookbooks/wen-deploy.tgz'
    chef.add_recipe 'wen-deploy'
  end
end
