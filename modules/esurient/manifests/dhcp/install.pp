class trollop::dhcp::install {
  package { 'isc-dhcp-server':
    ensure => installed,
  }
}
