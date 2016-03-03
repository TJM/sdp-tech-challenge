node default {
  include git
  include nginx

  # Open firewall port for 8000/tcp
  firewall { '500 Allow port 8000/tcp for SDP Tech Challenge':
    chain  => 'INPUT',
    dport  => 8000,
    action => 'accept',
  }

  # Setup VHOST on port 8000 per requirements
  nginx::resource::vhost {'static-vhost':
    ensure      => present,
    server_name => ['localhost'],
    listen_port => 8000,
    www_root    => '/var/www/sdp-tech-challenge',
  }

  # Static VCS Repo Configuration for PupppetLabs SDP Tech Challenge
  vcsrepo { '/var/www/sdp-tech-challenge':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/puppetlabs/exercise-webpage.git',
  }

}
