class roles::zarquon {
  include roles::base
  include dns_server
  include dhcp
  include nginx
  include nfs
  include nfs::server
  include wget

  # Ubuntu 12.10 needs software-properties-common
  class { 'nodejs': require => Class['roles::base'] }

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

  # WordPress - trollop.org
  nginx::resource::vhost { 'trollop.org':
    ensure                 => present,
    rewrite_www_to_non_www => 'true',
    listen_options         => 'default',
    www_root               => '/var/www/trollop.org/blog',
    location_cfg_append    => {'try_files' => '$uri $uri/ /index.php?q=$uri&$args' };
  }
  nginx::resource::location { 'trollop.org':
    ensure              => present,
    location            => '~ \.php$',
    www_root            => '/var/www/trollop.org/blog',
    vhost               => 'trollop.org',
    location_cfg_append => $fastcgi;
  }

  # rutorrent - torrents.trollop.org
  nginx::resource::vhost { 'torrents.trollop.org':
    ensure   => present,
    www_root => '/var/www/trollop.org/torrents';
  }
  nginx::resource::location { 'RPC2':
    ensure              => present,
    location            => '/RPC2',
    www_root            => '/var/www/trollop.org/torrents',
    vhost               => 'torrents.trollop.org',
    location_cfg_append => {
      'include'   => 'scgi_params',
      'scgi_pass' => 'localhost:5001',
    };
  }
  nginx::resource::location { 'torrents.trollop.org':
    ensure               => present,
    location             => '~ \.php$',
    www_root             => '/var/www/trollop.org/torrents',
    vhost                => 'torrents.trollop.org',
    location_cfg_append  => $fastcgi,
    location_cfg_prepend => {
      'auth_basic'           => '"Restricted"',
      'auth_basic_user_file' => '/var/www/trollop.org/torrents.trollop.org.pass',
    };
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
    location            => '~ \.php$',
    www_root            => '/var/www/trollop.org/sql',
    vhost               => 'sql.trollop.org',
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
    location            => '~ \.php$',
    www_root            => '/var/www/trollop.org/postfix',
    vhost               => 'postfix.trollop.org',
    location_cfg_append => $fastcgi;
  }

  # graphite + statsd - stats.trollop.org
  nginx::resource::upstream { 'stats':
    ensure  => present,
    members => '127.0.0.1:8080 fail_timeout=0',
  }
  nginx::resource::vhost { 'stats.trollop.org':
    ensure      => present,
    proxy       => 'http://stats',
    server_opts => {
      'client_max_body_size' => '64M',
      'keepalive_timeout'    => '5',
      'root'                 => '/opt/graphite/webapp/content',
    };
  }
  nginx::resource::location { 'media':
    ensure   => present,
    location => '/media/',
    vhost    => 'stats.trollop.org',
    www_root => '/usr/local/lib/python2.7/dist-packages/django/contrib/admin';
  }
}
