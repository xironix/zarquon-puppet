class roles::zaphod {
  include trollop::base
  include nfs
  include nfs::server
  include wget

  host { 'zaphod':
    ensure       => present,
    ip           => '127.0.0.1',
    name         => 'zaphod.trollop.org',
    host_aliases => [ 'zaphod.trollop.org', 'trollop.org', 'zaphod', ],
  }

  # Firewall rules
  firewall { '201 allow all on private net':
    proto   => 'all',
    iniface => 'eth0',
    action  => 'accept',
  }

  # VirtualBox
  apt::source { 'virtualbox':
    location    => 'http://download.virtualbox.org/virtualbox/debian',
    release     => 'quantal',
    repos       => 'contrib',
    include_src => false;
  }
  apt::key { 'virtualbox':
    ensure     => present,
    key        => '98AB5139',
    key_source => 'http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc';
  }
  package { [
    'virtualbox-4.2',
    'dkms',
  ]:
    ensure => present,
    require => Apt::Source['virtualbox'];
  }

  # NFS server for zarniwoop
  nfs::export { '/home/ironix':
    export  => {
      '192.168.1.0/24' => 'rw,async,no_root_squash,no_subtree_check',
    },
    require => Class['trollop::base'];
  }

  # gem packages we want installed
  package { [
    'vagrant',
  ]:
    ensure   => present,
    provider => 'gem';
  }

  # stuff we want
  package { [
    'chromium-browser',
    'vim-gnome',
  ]:
    ensure  => present;
  }

  # useless stuff
  package { [
    'firefox',
    'libreoffice-common',
  ]:
    ensure  => absent;
  }
}
