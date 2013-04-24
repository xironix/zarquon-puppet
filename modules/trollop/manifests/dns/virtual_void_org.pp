class trollop::dns::virtual_void_org {
  # Forward Zone
  dns::zone { 'virtual-void.org':
    serial       => '2013041605',
    zone_ttl     => '600',
    zone_refresh => '10800',
    zone_retry   => '3600',
    zone_expire  => '604800',
    zone_minimum => '3600',
    soa          => 'solipsistic.virtual-void.org',
    soa_email    => 'steffen.virtual-void.org',
    nameservers  => [ 'solipsistic.virtual-void.org', 'benevolent.virtual-void.org', ],
  }

  # A Records
  dns::record::a {
    '@_virtual-void':
      host => '@',
      zone => 'virtual-void.org',
      data => '50.112.151.217';
    'ns1_virtual-void':
      host => 'solipsistic',
      zone => 'virtual-void.org',
      data => '96.53.91.26';
    'ns2_virtual-void':
      host => 'benevolent',
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

  dns::record::txt { 'spf_virtual-void':
    host => '@',
    zone => 'virtual-void.org',
    data => 'v=spf1 mx a a:trollop.org a:fate.ca a:nein.ca include:shaw.ca include:google.com ~all';
  }

  dns::record::cname { 'verify':
    host => '4Q37O3LET6SY',
    zone => 'virtual-void.org',
    data => 'gv-67UVJFO2AYH5MF.dv.googlehosted.com';
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

