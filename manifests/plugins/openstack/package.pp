class munin::plugins::openstack::package {
  package { 'munin-plugins-openstack':
    ensure => present,
  }
}
