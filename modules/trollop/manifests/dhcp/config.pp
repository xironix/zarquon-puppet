class trollop::dhcp::config {
  file { '/etc/dhcp':
    ensure => directory,
    mode   => '0755',
  }

  file {
    '/etc/default/isc-dhcp-server':
      ensure  => present,
      source  => 'puppet:///modules/dhcp/isc-dhcp-server',
      require => Class['dhcp::install'],
      notify  => Class['dhcp::service'];
    '/etc/dhcp/dhcpd.conf':
      ensure  => present,
      source  => 'puppet:///modules/dhcp/dhcpd.conf',
      require => [ File['/etc/dhcp'], Class['dhcp::install'], ],
      notify  => Class['dhcp::service'];
    '/etc/dhcp/dhcpd.conf.options':
      ensure  => present,
      source  => 'puppet:///modules/dhcp/dhcpd.conf.options',
      require => File['/etc/dhcp/dhcpd.conf'],
      notify  => Class['dhcp::service'];
    '/etc/dhcp/dhcpd.conf.pools':
      ensure  => present,
      source  => 'puppet:///modules/dhcp/dhcpd.conf.pools',
      require => File['/etc/dhcp/dhcpd.conf'],
      notify  => Class['dhcp::service'];
    '/etc/dhcp/dhcpd.conf.reserved':
      ensure  => present,
      source  => 'puppet:///modules/dhcp/dhcpd.conf.reserved',
      require => File['/etc/dhcp/dhcpd.conf'],
      notify  => Class['dhcp::service'];
  }
}
