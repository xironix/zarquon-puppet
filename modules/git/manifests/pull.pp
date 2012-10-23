define git::pull ($local_repo, $user='root', $timeout=1200) {
  exec { "git::pull ${name}":
    command => "/usr/bin/git pull && \
    chown -R ${user}:${user} ${local_repo}",
    cwd     => $local_repo,
    timeout => $timeout,
    require => Package['git'];
  }
}
