class roles::base {
  include apt
  include git
  include wget
  include users
  include hosts
  include ntp
  include iptables

  class { 'vim': autoupgrade => true }

  Exec { path => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin' }

  # Default file owner, group, & perms
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  $ssh_key = 'AAAAB3NzaC1yc2EAAAADAQABAAACAQD43cF9h5l+VuJvL7Vz+tvqBORucca9S5w/RI0pPe7ie1Fv8eSMFfUHe2E89EgCuvRZgDT7v43bSyv5DBPA58wbc16iJzDhCo5FHb/Rbhbrbkgclgd8JjIbW9vb68eDSBLA7tO7nMb9/yyusvohbXHj0OJbtOR3YC1sKe6P7cS9h3Voq3b/ASpXIq1q5g1+IaAi8Grgaq+C3WXcaTZb7y5fUrfPGaoO05gZ9YjglWEVzcT3ljz2n/GurBd/RnFSaJOYqcdiQX1gVLSZ7noGFRIT3lt14A0fPfiEAmDme7JbYdjxVIOk+UH0o4h6Om0pM8a4a6EPn7QMxghYbuJD9ZaBcDi2oFAnyrnAGvqlPz3IBQIeTvRjQczhvg1qg2Sj0Q28BDZ+eOjVSBL81M731b4tMwdAfRL4FUo/3dtYrRdp9D/YZIQCupJYMmVVOgv2jHAba1z9H+cqvAtj5AqXO5lwzcu6i7C1URMu9LlE8X1nDE3ICPmiCeBMRR38uWfh/XK73qd9Vds9xfYh5ZkX6Z4Ele3x1glKjFEL51dnaeN2jdRegDYkQlJtg8/sMA/eMjv1GJiMVq0YpM//tR7rYZCyiSWD9kFmR9mDPkiRIHCQKMApdaWyBdpBVofZfTCw+mJrIHQtTk4n+hSZvobTvhIJK81VRDMdlLGirVWmOyLh9Q=='

  users::user {
    'root':
      fullname     => 'Steffen L. Norgren',
      email        => 'root@trollop.org',
      ssh_key      => $ssh_key,
      ssh_key_name => 'root@trollop.org';
    'ironix':
      fullname     => 'Steffen L. Norgren',
      email        => 'ironix@trollop.org',
      ssh_key      => $ssh_key,
      ssh_key_name => 'ironix@trollop.org';
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
    'openssh-server',
    'openssh-client',
  ]:
    ensure => present;
  }

  # Stuff we don't want from a default install
  package { [
    'ppp',
    'ed',
    'nano',
    'wireless-tools',
    'wireless-regdb',
    'wpasupplicant',
    'dosfstools',
    'ntfs-3g',
  ]:
    ensure => absent;
  }

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

