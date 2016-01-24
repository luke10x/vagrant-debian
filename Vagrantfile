# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "debian/jessie"
  config.vm.box_url = "../packer-debian/debian-8.2.0-amd64_virtualbox.box"
  config.vm.network :private_network, ip: "192.168.111.10"
  config.vm.synced_folder "./", "/vagrant"
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end
  config.vm.provision:shell, :inline => "bash /vagrant/bootstrap.sh"
  config.ssh.private_key_path = ['~/.vagrant.d/insecure_private_key', '~/.ssh/id_rsa']
  config.ssh.insert_key = false
end
