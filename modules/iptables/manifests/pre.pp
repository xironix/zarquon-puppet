class iptables::pre {
  Firewall {
    require => undef,
  }

  # Default firewall rules
  firewall { '000 accept all icmp':
    proto  => 'icmp',
    action => 'accept',
    icmp   => 'echo-reply',
  }
  firewall { '001 accept all to lo interface':
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept',
  }
  firewall { '002 accept related established rules':
    state   => ['RELATED', 'ESTABLISHED'],
    action  => 'accept',
  }
  firewall { '003 disregard netbios':
    action => drop,
    proto  => 'udp',
    dport  => ['netbios-ns', 'netbios-dgm', 'netbios-ssn'],
  }
  firewall { '004 disregard CIFS':
    action => drop,
    dport  => 'microsoft-ds',
    proto  => 'tcp'
  }
  firewall { '099 INPUT drop invalid':
    action => drop,
    state  => 'INVALID',
  }
}

