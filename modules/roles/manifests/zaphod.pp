class roles::zaphod {
  include roles::base
  include nfs
  include nfs::server
  include wget

  # Puppet will be run manually
  service { 'puppet':
    ensure  => stopped,
    enable  => false;
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

  # VirtualBox
  apt::source { 'virtualbox':
    location    => 'http://download.virtualbox.org/virtualbox/debian',
    release     => 'quantal',
    repos       => 'contrib non-free',
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
    require => Users::User['ironix'];
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
    'synaptic',
    'vim-gnome',
  ]:
    ensure => present;
  }

  # useless stuff
  package { [
    'firefox',
    'thunderbird',
    'libreoffice-core',
    'libreoffice-common',
    'deja-dup',
    'gwibber-service',
    'simple-scan',
    'transmission-common',
    'unity-webapps-common',
    'brasero-common',
    'ubuntuone-client',
    'ubuntuone-couch',
  ]:
    ensure => absent;
  }
}
