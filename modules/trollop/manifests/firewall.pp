class trollop::firewall {
  include trollop::firewall::pre
  include trollop::firewall::post

  # Always persist firewall rules
  exec { 'persist-firewall':
    command     => '/sbin/iptables-save > /etc/iptables/rules.v4',
    refreshonly => true,
  }

  # These defaults ensure that the persistence command is executed after
  # every change to the firewall, and that pre & post classes are run in the
  # right order to avoid potentially locking you out of your box during the
  # first puppet run.
  Firewall {
    notify  => Exec['persist-firewall'],
    before  => Class['trollop::firewall::post'],
    require => Class['trollop::firewall::pre'],
  }
  Firewallchain {
    notify  => Exec['persist-firewall'],
  }

  # Purge unmanaged firewall resources
  #
  # This will clear any existing rules, and make sure that only rules
  # defined in puppet exist on the machine
  resources { 'firewall':
    purge => false # we don't want to clear peerguardian rules
  }

  package { 'iptables-persistent': ensure => present }

  service { 'iptables-persistent':
    require    => Package['iptables-persistent'],

    # Because there is no running process for this service, the normal status
    # checks fail.  Because puppet then thinks the service has been manually
    # stopped, it won't restart it.  This fake status command will trick puppet
    # into thinking the service is *always* running (which in a way it is, as
    # iptables is part of the kernel.)
    hasstatus  => true,
    status     => true,

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
}

