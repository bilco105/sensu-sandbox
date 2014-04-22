node 'server.sensu.local' {
  class { 'apt': } ->
  class { 'redis': } ->
  class { 'rabbitmq':
    admin_enable      => false,
    delete_guest_user => true,
  } ->

  rabbitmq_user { 'sensu':
    password => '',
  } ->
  rabbitmq_vhost { '/sensu':
    ensure => present,
  } ->
  rabbitmq_user_permissions { 'sensu@/sensu':
    configure_permission => '.*',
    read_permission      => '.*',
    write_permission     => '.*',
  } ->

  package { 'sensu-plugin':
    ensure   => latest,
    provider => 'gem',
  } ->

  class { 'sensu':
    client         => true,
    server         => true,
    dashboard      => true,
    api            => true,
    purge_config   => true,
    client_address => $::ipaddress_eth1,
    subscriptions  => ['sensu-system'],

  }

  sensu::plugin { 'puppet:///modules/sensu_plugins/system':
    type         => directory,
    install_path => '/etc/sensu/plugins/system',
  }

  sensu::handler { 'default':
    command => 'echo "sensu alert" >> /tmp/sensu.log',
  }

  sensu::check { 'cpu':
    command     => '/etc/sensu/plugins/system/check-cpu.rb',
    standalone  => false,
    handlers    => 'default',
    subscribers => 'sensu-system',
  }

  sensu::check { 'diskspace':
    command     => '/etc/sensu/plugins/system/check-disk.rb',
    standalone  => false,
    handlers    => 'default',
    subscribers => 'sensu-system',
  }

  sensu::check { 'memory':
    command     => '/etc/sensu/plugins/system/check-ram.rb',
    standalone  => false,
    handlers    => 'default',
    subscribers => 'sensu-system',
  }
}

node 'client.sensu.local' {
  class { 'apt': } ->
  package { 'sensu-plugin':
    ensure   => latest,
    provider => 'gem',
  } ->
  class { 'sensu':
    client         => true,
    purge_config   => true,
    client_address => $::ipaddress_eth1,
    rabbitmq_host  => '172.20.20.2',
    subscriptions  => 'sensu-system',
  }

  sensu::plugin { 'puppet:///modules/sensu_plugins/system':
    type         => directory,
    install_path => '/etc/sensu/plugins/system',
  }
}
