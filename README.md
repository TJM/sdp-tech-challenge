 Puppet Labs SDP Tech Challenge Solution
------------------------------------------------

## Original Solution
NOTE: This has been updated in the "spirit" of iteration of puppet code, none of the actual puppet coded solution has changed, just the Vagrant implementation. If you want to access the originally submitted solution, please choose the [original_solution](https://github.com/TJM/sdp-tech-challenge/tree/original_solution) branch.

## Demo Environment
For the demo, we are using Vagrant and VirtualBox. This provides the cleanest, quickest and most "compatible" way of reproducing this environment across a multitude of different platforms. Please ensure that you have an up to date version of the following components installed locally on the demo workstation:

* Virtual Box (tested on 5.0.14) - https://www.virtualbox.org/wiki/Downloads
* Vagrant Up (tested on 1.8.1) - https://www.vagrantup.com/downloads.html
   * Oscar plugin (tested on 0.4.3) for Vagrant: `vagrant plugin install oscar`
   * (optional) vagrant-vbguest plugin (tested on 0.11.0) for Vagrant: `vagrant plugin install vagrant-vbguest`
      * NOTE: this updates the out of date Virtual Box Guest Additions in the Vagrant VMs automatically.

### How to bring up the demo environment
NOTE: These steps assume and OSX/Linux type environment, but it should work on windows as well.

* `git clone https://github.com/TJM/sdp-tech-challenge.git`
* `cd sdp-tech-challenge`
* `vagrant up --provider=virtualbox`
* Wait ...
   * If you have never downloaded the `puppetlabs/centos-7.2-64-nocm` box file, it will download automatically
   * It will startup the Virtual Machine, and configure it.
   * It will then use pe-build to install a Puppet Enterprise Agent.
   * It will then automatically kick off a puppet run and apply the changes from [default.pp](puppet/environments/vagrant/manifests/default.pp).
* Visit [the demo site](http://localhost:8000/) and see the example page.

### Updating ...
As this was intended to be the most simple demo possible, it will *not* automatically re-apply changes. If you wish to apply changes (updates to the repo) or just test the idemptoency, please run the following from the "sdp-tech-challenge" directory:
* `vagrant provision`

### Known Issues
There are a couple instances of "yellow text" WARNINGS, but they do not affect the overall outcome.
* `==> app: Warning: Scope(Concat::Fragment[static-vhost-500-6666cd76f96956469e7be39d750cc7d9]): The $ensure parameter to concat::fragment is deprecated and has no effect.`
   * This appears to be an issue with the `jfryman-nginx` module when using `puppetlabs-concat` > 2.0. https://github.com/jfryman/puppet-nginx/issues/776
* `==> app: Warning: Firewall[500 Allow port 8000/tcp for SDP Tech Challenge](provider=iptables): Unable to persist firewall rules: Execution of '/usr/libexec/iptables/iptables.init save' returned 1:`
   * Known issue with `puppetlabs-firewall`: https://tickets.puppetlabs.com/browse/MODULES-1029
* Unable to use puppet provisioner with Oscar style configuration.
   * This has already been fixed in the [vagrant-config_builder](https://github.com/oscar-stack/vagrant-config_builder/commit/a9ab96afcfa5142ccc70794df3ae8d352e799f54), but it has not yet been released (as of this writing). As such, I had to work around the issue by reverting to a more "standard" Vagrantfile, but I still kept the pe-build magic.


## Tech Challenge Requirements
Automate the installation and configuration of a nginx web server using Puppet
The nginx server should:

- serve requests over port 8000
- serve a page with the content of the following repository: https://github.com/puppetlabs/exercise-webpage (NOTE: The web page should be served locally from your nginx installation, not directly from the repository shown here)

## Assumptions
* OS: CentOS 7.x x86_64 - https://atlas.hashicorp.com/puppetlabs/boxes/centos-7.0-64-puppet-enterprise
   * NOTE: This should work on any OS that is compatible with the modules listed below. The puppet code produced for this exercise was designed to work on a Linux OS, and should not really be distribution dependent.
* SELINUX: DISABLED (to keep things simple) - as per the default configuration on the provided Vagrant VM
* Puppet Version: Any should be fine? Tested on PE 3.8.1 that came with the Vagrant VM

### Puppet Modules used (included in this repo)
- jfryman-nginx (v0.3.0)
- puppetlabs-apt (v2.2.2)
- puppetlabs-concat (v2.1.0)
- puppetlabs-firewall (v1.8.0)
- puppetlabs-git (v0.4.0)
- puppetlabs-stdlib (v4.11.0)
- puppetlabs-vcsrepo (v1.3.2)

## Puppet Server (Enterprise) usage
It has not been tested yet (stay tuned for future revisions), but this repository should be able to be checked out into a puppet environment, and a "node" assigned to that environment to have this configuration applied. This is unrealistic in reality, as the "default.pp" applies these changes to all nodes assigned to this environment. In reality, the contents would probably be parameterized into a profile and role and the PE console would be used to assign that role to the node so that other nodes could be assigned as well.

## Next Steps
* Create a basic roles/profiles configuration so that the PE Console can "apply" a module rather than having to define all the content from default.pp manually. Using the "node default" is fine for a demo though.
* ~~Test on a Puppet Enterprise Server (2015.3.1)~~ -- this works fine when the `puppet/environments/vagrant` folder is placed in `/etc/puppetlabs/code/environ,ments/ENVNAME` and nodes are assigned to it.

## Questions
There were a set of questions at the bottom of the challenge, but to keep this document focused, I have moved them to [questions.md](questions.md).
