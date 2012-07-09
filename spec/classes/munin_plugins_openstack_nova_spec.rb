require 'spec_helper'

describe 'munin::plugins::openstack::nova' do

  it { should include_class('munin::plugins::openstack::package') }

end
