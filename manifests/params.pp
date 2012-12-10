# == Class: kibana::params
#
# The Kibana configuration settings.
#
# === Parameters
#
# [*ensure*]
#   Specifies if resources are present or absent
#
# [*address*]
#   The $address to bind to (default localhost)
#
# [*port*]
#   The $port to use (default 5601)
#
# [*home*]
#   The $home is the directory where is installed Kibana
#
# [*user*]
#   The $user to run daemon as
#
# [*group*]
#   The $group to run daemon as
#
# [*kibana_provider*]
#   The $kibana_provider is the way Kibana must be installed (default git)
#
# [*git_revision*]
#   Set $git_revision if you need a specific version of Kibana
#
# [*package_type*]
#   The type of packaging system
#
# [*elasticsearch_servers*]
#   An array of elastic search server
#
# [*elasticsearch_timeout*]
#   Set the Net::HTTP read/open timeouts for the connection to the ES backend
#
class kibana::params {
  $ensure                = present
  $address               = 'localhost'
  $port                  = '5601'
  $home                  = '/opt/kibana'
  $user                  = 'kibana'
  $group                 = 'kibana'
  $kibana_provider       = 'git'
  $git_revision          = 'latest'
  $package_type          = 'package'
  $elasticsearch_servers = ['localhost:9200']
  $elasticsearch_timeout = '500'
}
