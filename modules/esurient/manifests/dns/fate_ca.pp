class trollop::dns::fate_ca {
  # Forward Zone
  dns::zone { 'fate.ca':
    serial       => '2013041602',
    zone_ttl     => '600',
    zone_refresh => '10800',
    zone_retry   => '3600',
    zone_expire  => '604800',
    zone_minimum => '3600',
    soa          => 'inevitable.fate.ca',
    soa_email    => 'steffen.fate.ca',
    nameservers  => [ 'inevitable.fate.ca', 'existential.fate.ca', ],
  }

  # A Records
  dns::record::a {
    '@_fate':
      host => '@',
      zone => 'fate.ca',
      data => '96.53.91.26';
    'ns1_fate':
      host => 'inevitable',
      zone => 'fate.ca',
      data => '96.53.91.26';
    'ns2_fate':
      host => 'existential',
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

 dns::record::txt { 'spf_fate':
    host => '@',
    zone => 'fate.ca',
    data => 'v=spf1 mx a a:trollop.org a:nein.ca a:virtual-void.org include:shaw.ca include:google.com ~all';
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

