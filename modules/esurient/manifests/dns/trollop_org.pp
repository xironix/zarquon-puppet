class trollop::dns::trollop_org {
  # Forward Zone
  dns::zone { 'trollop.org':
    serial       => '2013041601',
    zone_ttl     => '600',
    zone_refresh => '10800',
    zone_retry   => '3600',
    zone_expire  => '604800',
    zone_minimum => '3600',
    soa          => 'esurient.trollop.org',
    soa_email    => 'steffen.trollop.org',
    nameservers  => [ 'esurient.trollop.org', 'hedonistic.trollop.org', ],
  }

  # A Records
  dns::record::a {
    '@_trollop':
      host => '@',
      zone => 'trollop.org',
      data => '96.53.91.26';
    'ns1_trollop':
      host => 'esurient',
      zone => 'trollop.org',
      data => '96.53.91.26';
    'ns2_trollop':
      host => 'hedonistic',
      zone => 'trollop.org',
      data => '96.53.91.26';
    'www_trollop':
      host => 'www',
      zone => 'trollop.org',
      data => '96.53.91.26';
    'mail_trollop':
      host => 'mail',
      zone => 'trollop.org',
      data => '96.53.91.26';
    'sql_trollop':
      host => 'sql',
      zone => 'trollop.org',
      data => '96.53.91.26';
    'postfix_trollop':
      host => 'postfix',
      zone => 'trollop.org',
      data => '96.53.91.26';
    'torrents_trollop':
      host => 'torrents',
      zone => 'trollop.org',
      data => '96.53.91.26';
   }

 dns::record::txt { 'spf_trollop':
    host => '@',
    zone => 'trollop.org',
    data => 'v=spf1 mx a a:trollop.org a:fate.ca a:virtual-void.org include:shaw.ca include:google.com ~all';
  }

  # MX Records
  dns::record::mx {
    'mx,0_trollop':
      preference => 0,
      host       => 'mx,0',
      zone       => 'trollop.org',
      data       => 'mail.trollop.org';
  }
}

