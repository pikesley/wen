# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

$provision = <<PRV
  apt-get update
  apt-get upgrade
  apt-get -y install build-essential zlib1g-dev curl
  dpkg --purge nano
  apt-get -y install vim git ruby2.1 ruby2.1-dev redis-server nginx
  update-alternatives --install /usr/bin/ruby ruby `which ruby2.1` 1
  update-alternatives --install /usr/bin/gem gem `which gem2.1` 1
  gem install bundle
  useradd pi -s /bin/bash -m
  echo 'pi ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/pi
PRV

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "debian/jessie64"
  config.vm.network "public_network"
  config.vm.provision "shell", inline: $provision
end
