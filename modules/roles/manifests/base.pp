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

  $ssh_key = 'AAAAB3NzaC1yc2EAAAADAQABAAAEAQCRmSg5oa4ae+PHceGfK+4QTsRUx0kEfsoUPfu/ueb8C+ZAqZpo+wP5rHQo5Qt1EHk/Mq80GmnNl6jB/VolliIDSkvWg01ibjc6nvD37HuA96hek10LArih0IMEor//ybJ+5yx0XQK8IoW70dvqmhmyK9hBSSPWU2yWhO1qZxpHaMaTELrd63l8fu2ESbT1rtesxVylgw7fM3MeGRQW7hOi/RnV3Yj2VIN4IqJK8Dsmr7A3pcCLzeJ+jL04N6x/hw7Y4DAI9zu+Gt50VWixasY10sIKsit69zJuH2LZs/ICxm6zrseGPER4jPxwhIvJeQvEKZocbNTI+fvtoTdxD2ArGnzhJ+SPY6uYxoYOpjCUtF6FKUzuMwkevcRG6Dq1UMUfiIV9thr3oPKfWXAV0U+WOnl06+3AdfN4BRB3OWNZgvC7NbRe8PX0uXDwxJ+VbXB9OTBl+8guPuBdJ+CO2KlprstpwDsMUnEQWmUXakEDPK/7HjB4FjzzJHNg/N+yU9mvb7ctj0HNDFvg0/ggUJ8uxUQPxHSNB5bf/tWog2NDAVbSv+jiY0jouONkPU9S+yTS3N8uIvcShYWilMYh+Zlo4tvh/cZBZ3/rb5+VK5TvaSfltF09iaS2kOUmkmmlhhf8BAsjHEUrbLB25bR2Su+N7W0OUPAOOictImvFXKxm3HMJwBnOx0FdXdpt2I/oLxI7fuleQxElB49ET3yAE0iMedaoBZMJ99ljWmH/OyqIfq0I8TWsdQe0B2LhE66MVh/nowvG8/SXV/WKvfDC9Pqy4ZegHehDiKernFkPT9JI1bQ1E1+SkIewHCSIHVKhf2/6hWXkkhb5YQB7w+hrNnpmt8zHD4kXjUni+WV9f+AUO/J+L4nsnaxE6XMrrFXqr3pEXx/zTGM2nlEHunTkrcmbBsPzdQF+Jk0/aFBpi2t8zHrnCibveQ6vbEW2XcP3Pjbr4mNtrwNYvEOXFrQU+fmRXDnUdXdiUWrxySBMFprfkRKPSYs941Zi0RmNxykQGsG+PXJz133D+EylyJ0Oc9crb8Md+OXgNsqTfDqmFPaBR+3nyobs7RJLRTpLRToDj1CwNXexXOd9wleS8WzBNUL1WgSfTILdr1kYXTB3Uaae+I2tZTJfQZeg3WT1eAj9CMamUCb1mDDBipUTExobJUvAbgf5Otzy4XtrckpMDIr8STVqx/+JGrc+O2ViQVTasj2m4bvVJ+mdmj8an8dEAlnDT7F1evppImRwoG0NAY5IJjrJGijKav0UIEAXqy/MF9W9OIE+VquJYrpAiCWIPVFdhg0jxcNa7MMe+ayM8UnOJAxFmSrRdz5bZRb4gmLYpw2dm+pvJRjhK1TAMjfypOGX'

  # For NFS we want uid/gid mapping.
  # gid for 'dialout' conflicts with OS X group 'staff'
  group { 'dialout':
    ensure => absent,
  }

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
      ssh_key_name => 'ironix@trollop.org',
      uid          => '501',
      gid          => '20',
      require      => Group['dialout'];
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

