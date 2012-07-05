class munin::plugins::openstack::nova {
  include munin::plugins::openstack::package

  munin::plugin {
    [ 'glance_status', 'keystone_stats', 'nova_floating_ips',
      'nova_instance_launched', 'nova_instance_timing', 'nova_services' ]:
            ensure      => present,
            script_path => '/usr/share/munin-openstack/plugins'
  }

  munin::plugin {
    [ 'nova_instance_ephemeral_gb', 'nova_instance_instance_type_id',
      'nova_instance_launched', 'nova_instance_memory_mb',
      'nova_instance_power_state', 'nova_instance_root_gb',
      'nova_instance_task_state', 'nova_instance_timing', 'nova_instance_vcpus',
      'nova_instance_vm_state' ]:
            ensure      => 'nova_instance_',
            script_path => '/usr/share/munin-openstack/plugins'


  }

}
