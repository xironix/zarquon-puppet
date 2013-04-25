class trollop::firewall::post {
  firewall { '999 drop all':
    proto   => 'all',
    action  => 'drop',
    iniface => 'eth0',
    before  => undef,
  }
}

