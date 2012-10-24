class bind9_dns::trollop_org {
  # Forward Zone
  dns::zone { 'trollop.org':
    serial      => '2012102403',
    soa         => 'ns.trollop.org',
    soa_email   => 'ironix.trollop.org',
    nameservers => [ 'ns1.trollop.org', 'ns2.trollop.org', ],
  }

  # A Records
  dns::record::a {
    '@_trollop':
      host => '@',
      zone => 'trollop.org',
      ptr  => true,
      data => '96.53.91.26';
    'ns1_trollop':
      host => 'ns1',
      zone => 'trollop.org',
      ptr  => true,
      data => '96.53.91.26';
    'ns2_trollop':
      host => 'ns2',
      zone => 'trollop.org',
      ptr  => true,
      data => '96.53.91.26';
    'www_trollop':
      host => 'www',
      zone => 'trollop.org',
      ptr  => true,
      data => '96.53.91.26';
    'mail_trollop':
      host => 'mail',
      zone => 'trollop.org',
      ptr  => true,
      data => '96.53.91.26';
    'torrents_trollop':
      host => 'torrents',
      zone => 'trollop.org',
      ptr  => true,
      data => '96.53.91.26';
  }

  # MX Records
  dns::record::mx {
    'mx,0_trollop':
      host       => 'mx,0',
      zone       => 'trollop.org',
      preference => 0,
      data       => 'mail.trollop.org';
  }
}

