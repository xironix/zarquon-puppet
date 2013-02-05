class trollop::dns::virtual_void_org {
  # Forward Zone
  dns::zone { 'virtual-void.org':
    serial       => '2012102406',
    zone_ttl     => '600',
    zone_refresh => '10800',
    zone_retry   => '3600',
    zone_expire  => '604800',
    zone_minimum => '3600',
    soa          => 'ns1.virtual-void.org',
    soa_email    => 'ironix.virtual-void.org',
    nameservers  => [ 'ns1.virtual-void.org', 'ns2.virtual-void.org', ],
    zone_notify  => 'yes',
    also_notify  => [ '65.39.140.92', '64.85.60.137', '64.34.130.218', ];
  }

  # A Records
  dns::record::a {
    '@_virtual-void':
      host => '@',
      zone => 'virtual-void.org',
      data => '96.53.91.26';
    'ns1_virtual-void':
      host => 'ns1',
      zone => 'virtual-void.org',
      data => '96.53.91.26';
    'ns2_virtual-void':
      host => 'ns2',
      zone => 'virtual-void.org',
      data => '96.53.91.26';
    'www_virtual-void':
      host => 'www',
      zone => 'virtual-void.org',
      data => '96.53.91.26';
    'mail_virtual-void':
      host => 'mail',
      zone => 'virtual-void.org',
      data => '96.53.91.26';
  }

  # MX Records
  dns::record::mx {
    'mx,0_virtual-void':
      host       => 'mx,0',
      zone       => 'virtual-void.org',
      preference => 0,
      data       => 'mail.virtual-void.org';
  }
}
