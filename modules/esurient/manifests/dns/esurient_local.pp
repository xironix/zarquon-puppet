class esurient::dns::esurient_local {
  # Forward Zone
  dns::zone { 'esurient.local':
    serial       => '2013042401',
    zone_ttl     => '600',
    zone_refresh => '10800',
    zone_retry   => '3600',
    zone_expire  => '604800',
    zone_minimum => '3600',
    soa          => 'ns.esurient.local',
    soa_email    => 'steffen.esurient.local',
    nameservers  => 'ns.esurient.local';
  }

  # Reverse Zone
  dns::zone { '1.168.192.IN-ADDR.ARPA':
    soa         => 'ns.esurient.local',
    soa_email   => 'steffen.esurient.local',
    nameservers => 'ns.esurient.local';
  }

  dns::record::a {
    'zarquon':
      zone => 'esurient.local',
      data => '192.168.1.1',
      ptr  => true;
    'ns':
      zone => 'esurient.local',
      data => '192.168.1.1';
    'share-and-enjoy':
      zone => 'esurient.local',
      data => '192.168.1.2',
      ptr  => true;
    'crisis-inducer':
      zone => 'esurient.local',
      data => '192.168.1.3',
      ptr  => true;
    'zarniwoop-cat':
      zone => 'esurient.local',
      data => '192.168.1.100',
      ptr  => true;
    'lintilla':
      zone => 'esurient.local',
      data => '192.168.1.101',
      ptr  => true;
    'zaphod':
      zone => 'esurient.local',
      data => '192.168.1.102',
      ptr  => true;
    'agrajag':
      zone => 'esurient.local',
      data => '192.168.1.103',
      ptr  => true;
    'zarniwoop':
      zone => 'esurient.local',
      data => '192.168.1.110',
      ptr  => true;
    'lintilla-cat':
      zone => 'esurient.local',
      data => '192.168.1.111',
      ptr  => true;
  }

  dns::record::cname {
    'torrents':
      zone => 'esurient.local',
      data => 'torrents.esurient.local';
  }
}

