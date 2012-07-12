require 'spec_helper'

describe 'munin::plugins::openstack::nova' do

  it { should include_class('munin::plugins::openstack::package') }

  ['nova', 'keystone', 'glance'].collect do |f|
    it { should contain_file('/etc/munin/plugin-conf.d/nova').with(
      :ensure  => 'present',
      :mode    => '0644',
      :owner   => 'root',
      :group   => '0',
      :notify  => 'Service[munin-node]',
      :require => 'Package[munin-plugins-openstack]'
    ) }
  end

  [
    'glance_status',
    'keystone_stats',
    'nova_floating_ips',
    'nova_instance_launched',
    'nova_instance_timing',
    'nova_services',
  ].collect do |probe|
    it { should contain_munin__plugin(probe).with(
      :ensure         => 'present',
      :script_path_in => '/usr/share/munin-openstack/plugins',
      :require        => 'Class[Munin::Plugins::Openstack::Package]'
    ) }
  end

  [
    'ephemeral_gb',
    'instance_type_id',
    'memory_mb',
    'power_state',
    'root_gb',
    'task_state',
    'vcpus',
    'vm_state'
  ].collect do |probe|
    it { should contain_munin__plugin("nova_instance_#{probe}").with(
      :ensure         => 'nova_instance_',
      :script_path_in => '/usr/share/munin-openstack/plugins',
      :require        => 'Class[Munin::Plugins::Openstack::Package]'
    )}
  end

end
