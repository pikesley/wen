# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "debian/jessie64"
  config.vm.network "public_network"
  config.vm.provision "shell" do |s|
    s.inline = "apt-get install build-essential zlib1g-dev"
    s.inline = "useradd pi -s /bin/bash -m"
    s.inline = "echo 'pi ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/pi"
  end
end
