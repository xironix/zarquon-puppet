class trollop::dns {
  include dns::server
  include trollop::dns::trollop_org
  include trollop::dns::nein_ca
  include trollop::dns::fate_ca
  include trollop::dns::virtual_void_org

  # This mess allows me to make use of views
  file {
    '/etc/default/bind9':
      ensure  => present,
      owner   => 'bind',
      group   => 'bind',
      source  => 'puppet:///modules/trollop/dns/bind9',
      notify  => Class['dns::server::service'],
      require => Class['dns::server'];
    '/etc/bind/named.conf':
      ensure  => present,
      owner   => 'bind',
      group   => 'bind',
      source  => 'puppet:///modules/trollop/dns/named.conf',
      notify  => Class['dns::server::service'],
      require => Class['dns::server'];
    '/etc/bind/named.conf.options':
      ensure  => present,
      owner   => 'bind',
      group   => 'bind',
      source  => 'puppet:///modules/trollop/dns/named.conf.options',
      notify  => Class['dns::server::service'],
      require => Class['dns::server'];
    '/etc/bind/named.conf.logging':
      ensure  => present,
      owner   => 'bind',
      group   => 'bind',
      source  => 'puppet:///modules/trollop/dns/named.conf.logging',
      notify  => Class['dns::server::service'],
      require => [ Class['dns::server'], File['/var/log/bind'], ];
    '/etc/bind/named.conf.default-zones':
      ensure  => present,
      owner   => 'bind',
      group   => 'bind',
      source  => 'puppet:///modules/trollop/dns/named.conf.default-zones',
      notify  => Class['dns::server::service'],
      require => Class['dns::server'];
    '/etc/bind/db.192.in-addr.arpa':
      ensure  => present,
      owner   => 'bind',
      group   => 'bind',
      source  => 'puppet:///modules/trollop/dns/db.192.in-addr.arpa',
      notify  => Class['dns::server::service'],
      require => Class['dns::server'];
    '/etc/bind/db.int.trollop.org':
      ensure  => present,
      owner   => 'bind',
      group   => 'bind',
      source  => 'puppet:///modules/trollop/dns/db.int.trollop.org',
      notify  => Class['dns::server::service'],
      require => Class['dns::server'];
  }

  file { '/var/log/bind':
    ensure => directory,
    owner  => 'bind',
    group  => 'bind';
  }
}

