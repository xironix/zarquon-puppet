class dns_server::nein_ca {
  # Forward Zone
  dns::zone { 'nein.ca':
    serial       => '2012102404',
    zone_ttl     => '600',
    zone_refresh => '10800',
    zone_retry   => '3600',
    zone_expire  => '604800',
    zone_minimum => '300',
    soa          => 'ns1.nein.ca',
    soa_email    => 'ironix.nein.ca',
    nameservers  => [ 'ns1.nein.ca', 'ns2.nein.ca', ],
    zone_notify  => 'yes',
    also_notify  => [ '65.39.140.92', '64.85.60.137', '64.34.130.218', ];
  }

  # A Records
  dns::record::a {
    '@_nein':
      host => '@',
      zone => 'nein.ca',
      data => '96.53.91.26';
    'ns1_nein':
      host => 'ns1',
      zone => 'nein.ca',
      data => '96.53.91.26';
    'ns2_nein':
      host => 'ns2',
      zone => 'nein.ca',
      data => '96.53.91.26';
    'www_nein':
      host => 'www',
      zone => 'nein.ca',
      data => '96.53.91.26';
    'mail_nein':
      host => 'mail',
      zone => 'nein.ca',
      data => '96.53.91.26';
  }

  # MX Records
  dns::record::mx {
    'mx,0_nein':
      host       => 'mx,0',
      zone       => 'nein.ca',
      preference => 0,
      data       => 'mail.nein.ca';
  }
}

