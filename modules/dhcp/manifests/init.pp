class dhcp {
  include dhcp::install
  include dhcp::config
  include dhcp::service
}
