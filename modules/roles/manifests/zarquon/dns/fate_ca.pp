class zarquon::dns::fate_ca {
  # Forward Zone
  dns::zone { 'fate.ca':
    serial      => '2012102405',
    soa         => 'ns1.fate.ca',
    soa_email   => 'ironix.fate.ca',
    nameservers => [ 'ns1.fate.ca', 'ns2.fate.ca', ],
    zone_notify => 'yes',
    also_notify => [ '65.39.140.92', '64.85.60.137', '64.34.130.218', ];
  }

  # A Records
  dns::record::a {
    '@_fate':
      host => '@',
      zone => 'fate.ca',
      data => '96.53.91.26';
    'ns1_fate':
      host => 'ns1',
      zone => 'fate.ca',
      data => '96.53.91.26';
    'ns2_fate':
      host => 'ns2',
      zone => 'fate.ca',
      data => '96.53.91.26';
    'www_fate':
      host => 'www',
      zone => 'fate.ca',
      data => '96.53.91.26';
    'mail_fate':
      host => 'mail',
      zone => 'fate.ca',
      data => '96.53.91.26';
    'ftp_fate':
      host => 'ftp',
      zone => 'fate.ca',
      data => '96.53.91.26';
  }

  # MX Records
  dns::record::mx {
    'mx,0_fate':
      host       => 'mx,0',
      zone       => 'fate.ca',
      preference => 0,
      data       => 'mail.fate.ca';
  }
}

