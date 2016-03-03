# -*- mode: ruby -*-
# vi: set ft=ruby :

## This configuration works

Vagrant.configure(2) do |config|
  config.vm.define "app", primary: true do |server|
    server.vm.box = "puppetlabs/centos-7.2-64-nocm"
    server.vm.network "forwarded_port", guest: 8000, host: 8000
    server.vm.hostname = "sdp-exercise.vagrant"
    server.vm.provision :pe_bootstrap do |pe|
      pe.version = '2015.3.2'
      pe.download_root = "https://s3.amazonaws.com/pe-builds/released/:version"
      pe.role = 'agent'
      pe.answer_extras = ['q_fail_on_unsuccessful_master_lookup=n']
    end
    server.vm.provision :puppet do |puppet|
      puppet.environment = "vagrant"
      puppet.environment_path = "puppet/environments"
      #puppet.module_path = "puppet/modules"
      #puppet.options = "--test --evaltrace"
    end
  end

end
