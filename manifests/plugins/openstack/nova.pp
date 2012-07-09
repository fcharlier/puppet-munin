class munin::plugins::openstack::nova (
  $os_script_path = '/usr/share/munin-openstack/plugins'
) {
  include munin::plugins::openstack::package

  file { ['/etc/munin/plugin-conf.d/nova', '/etc/munin/plugin-conf.d/keystone', '/etc/munin/plugin-conf.d/glance']:
    ensure  => present,
    mode    => '0644',
    owner   => root,
    group   => 0,
    notify  => Service['munin-node'],
    require => Package['munin-plugins-openstack'],
  }

  munin::plugin { 'glance_status':
    ensure         => present,
    script_path_in => $os_script_path,
    require        => Class['munin::plugins::openstack::package'],
  }

  munin::plugin { 'keystone_stats':
    ensure         => present,
    script_path_in => $os_script_path,
    require        => Class['munin::plugins::openstack::package'],
  }

  munin::plugin {
    [ 'nova_floating_ips', 'nova_instance_launched',
      'nova_instance_timing', 'nova_services' ]:
    ensure         => present,
    script_path_in => $os_script_path,
    require        => Class['munin::plugins::openstack::package'],
  }

  munin::plugin {
    [ 'nova_instance_ephemeral_gb', 'nova_instance_instance_type_id',
      'nova_instance_memory_mb', 'nova_instance_power_state',
      'nova_instance_root_gb', 'nova_instance_task_state',
      'nova_instance_vcpus', 'nova_instance_vm_state' ]:
    ensure         => 'nova_instance_',
    script_path_in => $os_script_path,
    require        => Class['munin::plugins::openstack::package'],
  }

}
