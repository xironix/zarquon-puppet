class trollop::dns::nein_ca {
  # Forward Zone
  dns::zone { 'nein.ca':
    serial       => '2013041603',
    zone_ttl     => '600',
    zone_refresh => '10800',
    zone_retry   => '3600',
    zone_expire  => '604800',
    zone_minimum => '3600',
    soa          => 'schadenfreude.nein.ca',
    soa_email    => 'steffen.nein.ca',
    nameservers  => [ 'schadenfreude.nein.ca', 'verboten.nein.ca', ],
  }

  # A Records
  dns::record::a {
    '@_nein':
      host => '@',
      zone => 'nein.ca',
      data => '96.53.91.26';
    'ns1_nein':
      host => 'schadenfreude',
      zone => 'nein.ca',
      data => '96.53.91.26';
    'ns2_nein':
      host => 'verboten',
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

 dns::record::txt { 'spf_nein':
    host => '@',
    zone => 'nein.ca',
    data => 'v=spf1 mx a a:trollop.org a:fate.ca a:virtual-void.org include:shaw.ca include:google.com ~all';
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

