class bind9_dns {
  include dns::server
  include bind9_dns::trollop_org
  include bind9_dns::nein_ca
  include bind9_dns::fate_ca
  include bind9_dns::virtual_void_org

  # Reverse Zones
  dns::zone {
    '1.168.192.IN-ADDR.ARPA':
      serial      => '2012102401',
      soa         => 'ns.trollop.org',
      soa_email   => 'ironix.trollop.org',
      nameservers => [ 'ns1', 'ns2', ];
    '91.53.96.IN-ADDR.ARPA':
      serial      => '2012102402',
      soa         => 'ns.trollop.org',
      soa_email   => 'ironix.trollop.org',
      nameservers => [ 'ns1', 'ns2', ];
  }

  # This mess allows me to make use of views
  file {
    '/etc/default/bind9':
      ensure  => present,
      owner   => 'bind',
      group   => 'bind',
      source  => 'puppet:///modules/bind9_dns/bind9',
      notify  => Class['dns::server::service'],
      require => Class['dns::server'];
    '/etc/bind/named.conf':
      ensure  => present,
      owner   => 'bind',
      group   => 'bind',
      source  => 'puppet:///modules/bind9_dns/named.conf',
      notify  => Class['dns::server::service'],
      require => Class['dns::server'];
    '/etc/bind/named.conf.options':
      ensure  => present,
      owner   => 'bind',
      group   => 'bind',
      source  => 'puppet:///modules/bind9_dns/named.conf.options',
      notify  => Class['dns::server::service'],
      require => Class['dns::server'];
    '/etc/bind/named.conf.logging':
      ensure  => present,
      owner   => 'bind',
      group   => 'bind',
      source  => 'puppet:///modules/bind9_dns/named.conf.logging',
      notify  => Class['dns::server::service'],
      require => [ Class['dns::server'], File['/var/log/bind'], ];
    '/etc/bind/named.conf.default-zones':
      ensure  => present,
      owner   => 'bind',
      group   => 'bind',
      source  => 'puppet:///modules/bind9_dns/named.conf.default-zones',
      notify  => Class['dns::server::service'],
      require => Class['dns::server'];
    '/etc/bind/db.int.trollop.org':
      ensure  => present,
      owner   => 'bind',
      group   => 'bind',
      source  => 'puppet:///modules/bind9_dns/db.int.trollop.org',
      notify  => Class['dns::server::service'],
      require => Class['dns::server'];
  }

  file { '/var/log/bind':
    ensure => directory,
    owner  => 'bind',
    group  => 'bind';
  }
}

