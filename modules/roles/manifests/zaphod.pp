class roles::zaphod {
  include roles::base
  include nfs
  include nfs::server
  include wget

  # Ensure puppet runs at boot
  service { [ 'puppet':
    ensure  => 'running',
    enable  => true,
  }

  # I likes me some bleeding edge
  apt::source {
    'ubuntu_proposed':
      location          => 'http://archive.ubuntu.com/ubuntu/',
      release           => 'quantal-proposed',
      repos             => 'main restricted universe multiverse',
      include_src       => true;
    'ubuntu_backports':
      location          => 'http://archive.ubuntu.com/ubuntu',
      release           => 'quantal-backports',
      repos             => 'main restricted universe multiverse',
      include_src       => true;
  }

  # NFS server for zarniwoop
  nfs::export { '/home/ironix':
    export  => {
      '192.168.1.0/24' => 'rw,async,no_root_squash,no_subtree_check',
    },
    require => Users::User['ironix'];
  }

  # Useless desktop install stuff
  package { [
    'something',
  ]:
    ensure => absent;
  }
}
