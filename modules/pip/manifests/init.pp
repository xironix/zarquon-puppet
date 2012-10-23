class pip {
  package { 'python-pip':
    ensure  => present,
    require => [ Package['python'], Package['python-setuptools'], ];
  }

  Package['python-pip'] -> Package <| provider == 'pip' and ensure != absent |>
}
