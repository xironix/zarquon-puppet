class trollop::dns::zarniwoop_ca {
  # Forward Zone
  dns::zone { 'zarniwoop.ca':
    serial       => '2013041604',
    zone_ttl     => '600',
    zone_refresh => '10800',
    zone_retry   => '3600',
    zone_expire  => '604800',
    zone_minimum => '3600',
    soa          => 'peril-sensitive.zarniwoop.ca',
    soa_email    => 'steffen.zarniwoop.ca',
    nameservers  => [ 'peril-sensitive.zarniwoop.ca', 'panic-inducer.zarniwoop.ca', ],
  }

  # A Records
  dns::record::a {
    '@_zarniwoop':
      host => '@',
      zone => 'zarniwoop.ca',
      data => [
        '216.239.32.21',
        '216.239.34.21',
        '216.239.36.21',
        '216.239.38.21',
      ];
    '@_home':
      host => 'www',
      zone => 'zarniwoop.ca',
      data => [
        '216.239.32.21',
        '216.239.34.21',
        '216.239.36.21',
        '216.239.38.21',
      ];
    'ns1_zarniwoop':
      host => 'peril-sensitive',
      zone => 'zarniwoop.ca',
      data => '96.53.91.26';
    'ns2_zarniwoop':
      host => 'panic-inducer',
      zone => 'zarniwoop.ca',
      data => '96.53.91.26';
  }

  dns::record::cname {
    'mail_cname':
      host => 'mail',
      zone => 'zarniwoop.ca',
      data => 'ghs.googlehosted.com';
    'sites_cname':
      host => 'sites',
      zone => 'zarniwoop.ca',
      data => 'ghs.google.com';
    'docs_cname':
      host => 'docs',
      zone => 'zarniwoop.ca',
      data => 'ghs.googlehosted.com';
     'calendar_cname':
      host => 'calendar',
      zone => 'zarniwoop.ca',
      data => 'ghs.googlehosted.com';
    'contacts_cname':
      host => 'contacts',
      zone => 'zarniwoop.ca',
      data => 'ghs.googlehosted.com';
    'video_cname':
      host => 'video',
      zone => 'zarniwoop.ca',
      data => 'ghs.googlehosted.com';
    'admin_cname':
      host => 'admin',
      zone => 'zarniwoop.ca',
      data => 'admin.google.com';
    }

  dns::record::txt {
    'spf_zarniwoop':
      host => '@',
      zone => 'zarniwoop.ca',
      data => 'v=spf1 include:_spf.google.com ~all';
    'zarniwoop._domainkey':
      host => 'zarniwoop._domainkey',
      zone => 'zarniwoop.ca',
      data => 'v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnYYyeqGskrVbOIP2r+i7SPA3hnpRST9EEmIQx2fECrUdlnKDic3hHx/TrAEfUFgegOJZYRwAmMYqL6Q/ogp4WO/X4VYzA8OKdUYFTkMEjGpRqP94WfnoAi8yaYtC4c690bRaHnOHEaZqeaxVHGqiTlB96oX7NxGvPWc4w3vNrVwIDAQAB';
  }

  # MX Records
  dns::record::mx {
    'mx,10_zarniwoop':
      preference => 10,
      host       => 'mx,10,@',
      zone       => 'zarniwoop.ca',
      data       => 'ASPMX.L.GOOGLE.COM';
    'mx,20_zarniwoop':
      preference => 20,
      host       => 'mx,20,@',
      zone       => 'zarniwoop.ca',
      data       => [ 'ALT1.ASPMX.L.GOOGLE.COM', 'ALT2.ASPMX.L.GOOGLE.COM', ];
    'mx,30_zarniwoop':
      preference => 30,
      host       => 'mx,30,@',
      zone       => 'zarniwoop.ca',
      data       => [ 'ASPMX2.GOOGLEMAIL.COM', 'ASPMX3.GOOGLEMAIL.COM', ];
  }
}

