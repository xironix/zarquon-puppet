class roles::zarquon {
  include roles::base
  include dns_server
  include dhcp
  include nginx
  include nfs
  include nfs::server

  # Ensure puppet runs at boot
  service { [ 'puppet', 'puppetmaster' ]:
    ensure  => 'running',
    enable  => true,
  }

  # Network interfaces
  class { 'network::interfaces':
    interfaces => {
      'eth0'   => {
        'method'    => 'static',
        'address'   => '96.53.91.26',
        'netmask'   => '255.255.255.252',
        'broadcast' => '96.53.91.27',
        'gateway'   => '96.53.91.25',
      },
      'eth1'   => {
        'method'    => 'static',
        'address'   => '192.168.1.1',
        'netmask'   => '255.255.255.0',
        'broadcast' => '192.168.1.255',
      }
    },
    auto       => [ 'eth0', 'eth1', ],
  }

  # NFS server for zarniwoop
  nfs::export { '/home/ironix':
    export            => {
      'zarniwoop'     => 'rw,async,no_root_squash,no_subtree_check',
      'zarniwoop-cat' => 'rw,async,no_root_squash,no_subtree_check',
    },
    require           => Users::User['ironix'];
  }

  # fastcgi settings for nginx
  $fastcgi = {
    'fastcgi_split_path_info' => '^(.+\.php)(/.+)$',
    'fastcgi_pass'            => 'unix:/var/run/php5-fpm.sock',
    'fastcgi_index'           => 'index.php',
    'include'                 => 'fastcgi_params',
  }

  # Nice perma-links with WordPress
  $permalinks = {
    'try_files'               => '$uri $uri/ /index.php?q=$uri&$args',
  }
  # fate.ca
  nginx::resource::vhost { 'fate.ca':
    ensure                 => present,
    rewrite_www_to_non_www => 'true',
    www_root               => '/var/www/fate.ca';
  }

  # virtual-void.org
  nginx::resource::vhost { 'virtual-void.org':
    ensure                 => present,
    rewrite_www_to_non_www => 'true',
    www_root               => '/var/www/virtual-void.org';
  }

  # phpmyadmin - sql.trollop.org
  nginx::resource::vhost { 'sql.trollop.org':
    ensure   => present,
    ssl      => 'true',
    ssl_cert => '/etc/ssl/private/trollop.org.crt',
    ssl_key  => '/etc/ssl/private/trollop.org.key',
    www_root => '/var/www/trollop.org/sql';
  }
  nginx::resource::location { 'sql.trollop.org':
    ensure              => present,
    ssl                 => 'true',
    www_root            => '/var/www/trollop.org/sql',
    location            => '~ \.php$',
    vhost               => 'sql.trollop.org',
    location_cfg_append => $fastcgi;
  }

  # WordPress - trollop.org
  nginx::resource::vhost { 'trollop.org':
    ensure                 => present,
    rewrite_www_to_non_www => 'true',
    listen_options         => 'default',
    www_root               => '/var/www/trollop.org/blog',
    location_cfg_append    => $permalinks;
  }
  nginx::resource::location { 'trollop.org':
    ensure              => present,
    www_root            => '/var/www/trollop.org/blog',
    location            => '~ \.php$',
    vhost               => 'trollop.org',
    location_cfg_append => $fastcgi;
  }

  # postfix admin - postfix.trollop.org
  nginx::resource::vhost { 'postfix.trollop.org':
    ensure              => present,
    ssl                 => 'true',
    ssl_cert            => '/etc/ssl/private/trollop.org.crt',
    ssl_key             => '/etc/ssl/private/trollop.org.key',
    www_root            => '/var/www/trollop.org/postfix';
  }
  nginx::resource::location { 'postfix.trollop.org':
    ensure              => present,
    ssl                 => 'true',
    www_root            => '/var/www/trollop.org/postfix',
    location            => '~ \.php$',
    vhost               => 'postfix.trollop.org',
    location_cfg_append => $fastcgi;
  }
}
