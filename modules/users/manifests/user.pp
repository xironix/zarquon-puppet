define users::user (
  $fullname     = 'Another Nameless Trollop',
  $email        = 'nameless.user@trollop.org',
  $ensure       = present,
  $shell        = '/bin/bash',
  $has_sudo     = true,
  $sudo_files   = undef,
  $ssh_key      = undef,
  $ssh_key_name = undef,
  $ssh_key_type = 'ssh-rsa',
) {
  if $title == 'root' {
    $home_dir = ''
  }
  else {
    $home_dir = '/home'
  }

  user { $title:
    ensure     => $ensure,
    comment    => "${fullname} <${email}>",
    home       => "${home_dir}/${title}",
    managehome => true,
    shell      => $shell;
  }
  ssh_authorized_key { $ssh_key_name:
    ensure  => $ensure,
    key     => $ssh_key,
    type    => $ssh_key_type,
    user    => $title,
    require => User[$title];
  }

  if (($has_sudo == true) and ($sudo_files == undef)) {
    sudo::conf { $title:
      content  => "%${title} ALL=(ALL) NOPASSWD: ALL\n",
      require  => User[$title];
    }
  }
  elsif (($has_sudo == true) and ($sudo_files != undef)) {
    sudo::conf { $title:
      content  => "%${title} ALL=NOPASSWD:${sudo_files}\n",
      require  => User[$title];
    }
  }
  elsif (($ensure == absent) or ($has_sudo == false)) {
    sudo::conf { $title:
      ensure => absent,
    }
  }

  # Bash environment files
  file {
    "${home_dir}/${title}/.profile":
      ensure  => $ensure,
      owner   => $title,
      group   => $title,
      source  => 'puppet:///modules/users/bash/.profile',
      require => User[$title];
    "${home_dir}/${title}/.bashrc":
      ensure  => $ensure,
      owner   => $title,
      group   => $title,
      source  => 'puppet:///modules/users/bash/.bashrc',
      require => User[$title];
    "${home_dir}/${title}/.bash_aliases":
      ensure  => $ensure,
      owner   => $title,
      group   => $title,
      source  => 'puppet:///modules/users/bash/.bash_aliases',
      require => User[$title];
    "${home_dir}/${title}/.bash_logout":
      ensure  => $ensure,
      owner   => $title,
      group   => $title,
      source  => 'puppet:///modules/users/bash/.bash_logout',
      require => User[$title];
  }
}
