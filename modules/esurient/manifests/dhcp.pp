class esurient::dhcp {
  include esurient::dhcp::install
  include esurient::dhcp::config
  include esurient::dhcp::service
}
