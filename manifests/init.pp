# == Class: kibana
#
# This class installs Kibana
#
class kibana (
  $ensure                = $kibana::params::ensure,
  $address               = $kibana::params::host,
  $port                  = $kibana::params::port,
  $home                  = $kibana::params::home,
  $user                  = $kibana::params::user,
  $group                 = $kibana::params::group,
  $kibana_provider       = $kibana::params::kibana_provider,
  $package_type          = $kibana::params::package_type,
  $git_revision          = $kibana::params::git_revision,
  $elasticsearch_servers = $kibana::params::elasticsearch_servers,
  $elasticsearch_timeout = $kibana::params::elasticsearch_timeout,
) inherits kibana::params {

  include thin::params

  case $package_type {

    'gem': {
      include ruby::gem::json
      include ruby::gem::sinatra
      include ruby::gem::tzinfo
      include ruby::gem::fastercsv
    }

    'package': {
      include ruby::package::json
      include ruby::package::sinatra
      include ruby::package::tzinfo
      include ruby::package::fastercsv
    }

    default: { fail "Unsupported package type ${package_type}" }

  }

  # resource alias is only usable for require
  # e.g. realize Package[tzinfo] doesn't work if 'tzinfo'
  # is an alias, see http://projects.puppetlabs.com/issues/4459
  Package <| alias == 'ruby-json'      |>
  Package <| alias == 'ruby-sinatra'   |>
  Package <| alias == 'ruby-tzinfo'    |>
  Package <| alias == 'ruby-fastercsv' |>

  user {$user:
    ensure => $ensure,
    home   => $home,
    system => true,
  }

  case $kibana_provider {

    'git': {
      vcsrepo {$home:
        ensure   => $git_revision,
        provider => 'git',
        source   => 'git://github.com/rashidkpc/Kibana.git',
      }
    }

    'package': {
      package{'kibana':
        ensure => $ensure,
      }
    }

    'gem': {
      package{'kibana':
        ensure   => $ensure,
        provider => 'gem',
      }
    }

    default: { fail "Unsupported kibana provider ${kibana_provider}" }
  }

  file {"${home}/KibanaConfig.rb":
    ensure          => $ensure,
    owner           => 'root',
    group           => 'root',
    content         => template('kibana/KibanaConfig.rb.erb'),
    notify          => Service[$thin::params::service],
    require         => $kibana_provider ? {
      'git'         => Vcsrepo[$home],
      /package|gem/ => Package['kibana'],
    },
  }

  thin::app {'kibana':
    ensure  => $ensure,
    chdir   => $home,
    address => $address,
    port    => $port,
    user    => $user,
    group   => $group,
    rackup  => "${home}/config.ru",
    require => [
      Vcsrepo[$home], User[$user], File["${home}/KibanaConfig.rb"],
      Package['json','sinatra','tzinfo','fastercsv'],
    ],
  }

}
