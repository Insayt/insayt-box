# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.network "forwarded_port", guest: 80,    host: 8080
  config.vm.network "forwarded_port", guest: 3306,  host: 3306
  config.vm.synced_folder ".", "/var/www", :mount_options => ["dmode=777", "fmode=666"]
  config.vm.network "private_network", ip: "192.168.50.4"

  config.vm.hostname = 'insayt.vm'
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true

  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
  config.vm.provision :shell, :name => 'setup.sh', :path => 'Vagrant/setup.sh'
  config.vm.provision :hostmanager

end
