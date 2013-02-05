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

  # Role specific rules
  case $::role {
    'zarquon': {
      firewall { '200 snat for internal network':
        chain    => 'POSTROUTING',
        jump     => 'MASQUERADE',
        proto    => 'all',
        outiface => 'eth0',
        source   => '192.168.1.0/24',
        table    => 'nat',
      }
      firewall { '201 allow all on private net':
        proto   => 'all',
        iniface => 'eth1',
        action  => 'accept',
      }
      firewall { '202 allow smtp':
        action => accept,
        proto  => 'tcp',
        dport  => '25',
      }
      firewall { '203 allow tcp DNS':
        action => accept,
        proto  => 'tcp',
        port   => 'domain',
      }
      firewall { '204 allow udp DNS':
        action => accept,
        proto  => 'udp',
        port   => 'domain',
      }
      firewall { '205 allow http':
        action => accept,
        proto  => 'tcp',
        dport  => '80',
      }
      firewall { '206 allow https':
        action => accept,
        proto  => 'tcp',
        dport  => '443',
      }
      firewall { '207 allow imaps':
        action => accept,
        proto  => 'tcp',
        dport  => '993',
      }
      firewall { '208 allow 1925 (alt smtp port)':
        action => accept,
        proto  => 'tcp',
        dport  => '1925',
      }
      firewall { '209 allow 7442 (alt ssh port)':
        action => accept,
        proto  => 'tcp',
        dport  => '7442',
      }
      firewall { '290 allow tcp bitTorrent traffic':
        action => accept,
        proto  => 'tcp',
        dport  => '49152-65535',
      }
      firewall { '291 allow udp bitTorrent traffic':
        action => accept,
        proto  => 'udp',
        dport  => '49152-65535',
      }
    }
    'zaphod': {
      firewall { '301 allow all on private net':
        proto   => 'all',
        iniface => 'eth0',
        action  => 'accept',
      }
    }
    default: { }
  }
}

