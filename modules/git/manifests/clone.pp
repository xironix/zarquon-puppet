define git::clone ($url, $destination, $user='root', $timeout=1200) {
  exec { "git::clone ${name}":
    command => "/usr/bin/git clone ${url} ${destination} && \
    chown -R ${user}:${user} ${destination}",
    creates => $destination,
    unless  => "/usr/bin/test -s ${destination}",
    timeout => $timeout,
    require => Package['git'];
  }
}
