class roles::zaphod {
  include roles::base
  include nfs
  include nfs::server
  include wget

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
