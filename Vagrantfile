# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'hashicorp/precise64'

  config.vm.define 'server' do |server|
    server.vm.hostname = 'server.sensu.local'
    server.vm.network 'private_network', ip: '172.20.20.2'
  end

  config.vm.define 'client' do |client|
    client.vm.hostname = 'client.sensu.local'
    client.vm.network 'private_network', ip: '172.20.20.3'
  end

  config.vm.provision 'puppet' do |puppet|
    puppet.module_path = ['modules', 'dist']
  end
end
