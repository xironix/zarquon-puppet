class roles::zarquon {
  include esurient::base
  include esurient::dns
  include esurient::dhcp

  $zarniwoop_key = 'AAAAB3NzaC1yc2EAAAADAQABAAAEAQCkiwRpT1gat9G9EnTUrGirWtpB598Sz51+dflMaVdsRuCTRkufA9C3hA4HLhb9c+opJ+Dwg+gBQoHDyIGcNWwW1C8QWkSRvlS5peKrXpMm7WfVxx+mtT4okJ+9sFo15dAba+gFkTaYsjo4UbYPBGYOCxhFtnVxrbbSfO8qVHhHn3zuZ0oj+WDuuIkDNWvUtsFwqasi6GnzzJb3KYdrLdpeUDoR8BI1tZzsK+v2V0RI8I93rMDKQ3g3wcO4S8qVBcn+YwrmzkyfYVo3DZdBAlBaDOIoCdVkJHtSn7rY2afCQvuhJXGa78Xm4rD/GDDe3AJsmWGDWYz7ZzP6uuDAtU5mCt+R0/zZprGSs/pH1zYmaxiGOedN6eRnxRxj7Ej8Bt2q1XbngNneVco9sEdivPU8kylUnHbAZmGOVSrYKJUjEoC19jrANa49y2mr938GIFlMDhQ108CR8zhaHnb0xzC/B+U4hF378MkXFRrHfFf7FCG6Zv6LkIJrhJUFAIrUhnRuFOPqEhWEgj1Sg1zsrY+V8H8AI42OWPJkS/c8qAK2SJovHvTAHG4c5eHvzgR0tHf5bqhDPkPpJCRQKlZNtsqE/5SmCDI9QHCjkD5qDyakm0CEAavp2JcE87v/T7dNd6MW0eaWW0mvqN0yk5IBZlR23UDo4GrGId2GJFB06916dDF1SXCbW+/ZyytgWs9gr/7Lf+4Z40uEBScJNmQi8fiOV3ZpL0Dd7xX4o06rHlG4vjHMphogcMco3xILqyKDaKL3g5AQZ75DsCtc2S0k2OmDJ3vugWG9mvGc27Y+JIw6ooDCjhg1qgsifmho/3L+WJNQggO98J2jGOkid8xLMp1qAZ2fgsRAG1tkXIatF7g2W7PDGWDMSGfPmIKWN9R4x6KfqaVCZX3UoYQBNifIFBChWQyI7CXwXO2wL9XEWJ9jhcSNzVT1fDXEwkKXOXSTSaLuHS2mob021BuwtyaTaCfg8FhvUuEsOW5ykhguuxEM1kCgom1AMvJvFS3g1Ch0mHYcfzw5r0EKo2oaS6JuaFSdYlTzGssQsz2ZrrfzYV3osnQR+8RZS3SFe+up5w1Y2xbWCk96WvQHxwWESbtVPS5D71GMtS1BMJh4diThCVmbpccSzNkYc6DNBlErHGr67dXHjQOqPLDOdiqU6dCtz051tTzssQ7jTWbcbpGUfP2s2Adk54/lHet24FFTU75/yv4jrNWkRKRSL95KTZjFkz+Yaft8y+idYSOC6gXT/Y8GEcdaijuFB5+B4KCKCrBQi5ItGLK9PPz/9iRhLFqYRJrFwefQ002jJFLCTBXGgoOT/DK3AR6EymAtWh7LNOXAL2URmPjIcjOrGluTREdfJHqJ'
  $zaphod_key = 'AAAAB3NzaC1yc2EAAAADAQABAAAEAQCyomgaKIli+gKQiJmiRMtH7vM/2tfxGWUFuRoM7raj+fChiG9N4NLVR3/MqcSs/mOub1rSRbvB9DaMRRyFD3RpvcjrhtC7iJoN3kD2whounqmnTWH9ErJxgq4l4L13W3d5+8yvKYUY9ID12aESBf0Gy0XRgfnRYVKIfyRUVcg+GsaDZgezDQcmPHy3mc1zdtTDjOMPd6ZkoCXl8UHlgY9mCkzZ6RSNzajg1Y/F0J2eFGplcm8MKqsj8dPbyd1QLXDIRY0RWaDJOwgtb59CueCDIgzhZOsSFalXHXW0e4O0Y3bq4D40HeSBB76X8lOYRxtzC30fil4LZ7apYXAMrNJhccHEpZl5l44tBglZvHatr0LzsG3iY+46befrNDIzYRIDjA/6kSgD/1rc9gKCjwKC+sPIBrqYdmkgUXK8FKJ76aEv8RXntirzQn9ollkpgzDf8G5XIcjzgmmWkr8R22k0fPgYeHEs1ivbgUyfnFyojvvYAiQrq5NcskzR5Rx+yN8YXQJU1P0raYChcrGrpmuCC8eNEOvrshpYwDj1zN+qvqohUTEoPJVmUm419+x3L+TMVbX2xsA10JOb1m48SPYOVjjBOVBMQXQa56cbblQvfZs6tqnskLqB8vNbY6cQ9OExiJc7Tec1o7JX66KsW+TDmQb0e6fXeOLxkgM1YCLyg7y3/l/6QYc2bCWF3rv/9rYBIlA6q/PB3HRfQIEGrJ1JXTWGhXPk6xcl0ngnct359fKkDTp2ixylSzGy/5C/zO5VAU52gkfZ1/BLsRZmWbGYKeus2ICs6oX5owGFNVc+yApIBOrUJq2zCjoAlLbifWz2kiYelcaUdEeKhMcPXPKXXaM148D8gBtJz6HXzsuUNatKtwgP8iMqYgrmZYRFwDoA2emEpN1HLF5O2ZOClefluoHFroUK6FoE/anPWNqMJpze3sW48YIrdMdiouVbL5nD4VmalJGstDMqA4LMPW21NqgwpqvUhFTC5Yza2iOWNcvtsfsdclnWmhHvZX0lDbTuCmY2f2WKgx9k9e8NeHXg3UeZ+hvtbz0o3RIxsRqEZ3BMUfdT5Ul1aIpQdnjcmEYx1AVzO3R7Zsnrl/q0UCgQeEgHOqmHjQAIaHk2mcT6ZoyBjUlfKOQ8RVoIqSAe0EArMgOuv9enWHE7MDwCeUqcy9Upq3vg4TFglejIoSK+8dhmiR2uvBJr9AJr9+Hvvlq2V3crWlhmK4Xq4U0a0EhKCEqf2sKsO0pTFUED2LER40cVGAtYUwT5wkhe+Z3tp1kitwzVMvwORlOZQGQEWjq/0IgmZBo8txoy+rzjC/hJavqyMhZAnHItFKCtpUxqGmGCLaGReajoUelpKA4nA5tb'

  esurient::user {
    'root':
      fullname     => 'Steffen L. Norgren',
      email        => 'steffen@esurient-systems.ca',
      ssh_key      => $zarniwoop_key,
      ssh_key_name => 'root@zarniwoop.esurient.local';
    'ironix':
      fullname     => 'Steffen L. Norgren',
      email        => 'steffen@esurient-systems.ca',
      ssh_key      => $zarniwoop_key,
      ssh_key_name => 'ironix@zarniwoop.esurient.local',
      uid          => '501',
      gid          => '20',
      require      => [ Group['dialout'], Class['esurient::base'], ];
  }

  # Additional SSH keys
  ssh_authorized_key {
    'root@zaphod.esurient.local':
      ensure => present,
      name => 'root@zaphod.esurient.local',
      user => 'root',
      type => 'ssh-rsa',
      key =>  $zaphod_key;
    'ironix@zaphod.esurient.local':
      ensure => present,
      name => 'ironix@zaphod.esurient.local',
      user => 'ironix',
      type => 'ssh-rsa',
      key =>  $zaphod_key;
  }

  host { 'zarquon':
    ensure       => present,
    ip           => '127.0.0.1',
    name         => 'zarquon.esurient.local',
    host_aliases => [ 'zarquon.esurient.local', 'esurient.local', 'zarquon', 'localhost', ],
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

  # Firewall rules
  firewall { '200 snat for internal network':
    chain    => 'POSTROUTING',
    jump     => 'MASQUERADE',
    proto    => 'all',
    outiface => 'eth0',
    source   => '192.168.1.0/24',
    table    => 'nat',
  }
  firewall { '201 allow all on private net':
    proto   => 'all',
    iniface => 'eth1',
    action  => 'accept',
  }
 firewall { '202 allow 7442 (alt ssh port)':
    action => accept,
    proto  => 'tcp',
    dport  => '7442',
  }
  firewall { '290 allow tcp bitTorrent traffic':
    action => accept,
    proto  => 'tcp',
    dport  => '49152-65535',
  }
  firewall { '291 allow udp bitTorrent traffic':
    action => accept,
    proto  => 'udp',
    dport  => '49152-65535',
  }
}
