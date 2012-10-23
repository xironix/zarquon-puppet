class iptables {
  include iptables::pre
  include iptables::post

  package { 'iptables-persistent': ensure => present }

  service { 'iptables-persistent':
    require    => Package['iptables-persistent'],

    # Because there is no running process for this service, the normal status
    # checks fail.  Because puppet then thinks the service has been manually
    # stopped, it won't restart it.  This fake status command will trick puppet
    # into thinking the service is *always* running (which in a way it is, as
    # iptables is part of the kernel.)
    hasstatus  => true,
    status     => 'true',

    # Under Debian, the 'restart' parameter does not reload the rules, so tell
    # Puppet to fall back to stop/start, which does work.
    hasrestart => false,
  }

  # Common rules to all servers
  firewall { '100 allow ssh':
    proto  => 'tcp',
    port   => '22',
    action => 'accept',
  }
  firewall { '101 allow all on private net':
    proto   => 'all',
    iniface => 'eth0',
    action  => 'accept',
  }

  # Role specific rules
  case $::role {
    'zarquon': { }
    default: { }
  }
}

