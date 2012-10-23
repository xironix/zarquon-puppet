class hosts::trollop ($domain = 'trollop.org') {
  host { $::role:
    ensure       => present,
    name         => "${::role}.${domain}",
    host_aliases => [ "${::role}.${domain}", $domain, $::role, ],
  }
}
