class esurient::dhcp::install {
  package { 'isc-dhcp-server':
    ensure => installed,
  }
}
