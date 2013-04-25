class trollop::base {
  include apt
  include git
  include wget
  include ntp
  include trollop::firewall

  class { 'vim': autoupgrade  => true }
  class { 'sudo': autoupgrade => true, source => 'puppet:///modules/trollop/sudo/sudoers.deb'}

  Exec { path => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin' }

  # Default file owner, group, & perms
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  # For NFS we want uid/gid mapping.
  # gid for 'dialout' conflicts with OS X group 'staff'
  group { 'dialout':
    ensure => absent,
  }

   # Default packages
  package { [
    'ack-grep',
    'bash',
    'build-essential',
    'curl',
    'gettext',
    'less',
    'tree',
    'whois',
    'screen',
    'subversion',
    'openssh-server',
    'openssh-client',
    'dstat',
    'software-properties-common',
  ]:
    ensure => present;
  }

  # some stuff requires rake
  package { 'rake': ensure => present, provider => 'gem' }

  # We're going to manage the sshd_config, as the default setup
  # allows password authentication.
  service { 'ssh':
    ensure  => 'running',
    enable  => true,
    require => Package['openssh-server'];
  }

  # add a notify to the file resource
  file { '/etc/ssh/sshd_config':
    notify  => Service['ssh'],
    source  => 'puppet:///modules/roles/ssh/sshd_config',
  }
}

