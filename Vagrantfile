# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.
 
  config.ssh.username = "danielb"
  config.ssh.private_key_path = "~/.ssh/vagrant"

  config.vm.box = "archlinux/archlinux"

  config.vm.provision :shell, path: "bootstrap.sh"
 
  config.vm.synced_folder "dotfiles/", "/mnt/dotfiles"

  # config.ssh.forward_x11 = false
end
