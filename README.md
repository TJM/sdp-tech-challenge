 Puppet Labs SDP Tech Challenge Solution
------------------------------------------------

## Demo Environment
For the demo, we are using Vagrant and VirtualBox. This provides the cleanest, quickest and most "compatible" way of reproducing this environment across a multitude of different platforms. Please ensure that you have an up to date version of the following components installed locally on the demo workstation:

* Virtual Box (tested on 5.0.14) - https://www.virtualbox.org/wiki/Downloads
* Vagrant Up (tested on 1.8.1) - https://www.vagrantup.com/downloads.html

### How to bring up the demo environment
NOTE: These steps assume and OSX/Linux type environment, but it should work on windows as well.

* `git clone https://github.com/TJM/sdp-tech-challenge.git`
* `cd sdp-tech-challenge`
* `vagrant up --provider=virtualbox`
* Wait ...
   * If you have never downloaded the `puppetlabs/centos-7.0-64-puppet-enterprise` box file, it will download automatically
   * It will startup the Virtual Machine, which comes *pre-installed* with puppet-enterprise (albeit, considerably out of date).
   * It will then automatically kick off a puppet run and apply the changes from [default.pp](puppet/manifests/default.pp).
* Visit [the demo site](http://localhost:8000/) and see the example page.

### Updating ...
As this was intended to be the most simple demo possible, it will *not* automatically re-apply changes. If you wish to apply changes (updates to the repo) or just test the idemptoency, please run the following from the "sdp-tech-challenge" directory:
* `vagrant provision`


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
* Create a basic roles/profiles configuration so that the PE Console can "apply" a module rather than having to define all the content from default.pp manually.
* Test on a Puppet Enterprise Server (2015.3.1)
