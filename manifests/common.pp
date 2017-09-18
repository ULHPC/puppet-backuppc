################################################################################
# Time-stamp: <Thu 2017-09-07 19:00:33 hcartiaux>
#
# File::      <tt>common.pp</tt>
# Author::    Hyacinthe Cartiaux (hyacinthe.cartiaux@uni.lu)
# Copyright:: Copyright (c) 2017 Hyacinthe Cartiaux
# License::   Apache-2.0
#
# ------------------------------------------------------------------------------
# = Class: backuppc::common
#
# Base class to be inherited by the other backuppc classes, containing the common code.
#
# Note: respect the Naming standard provided here[http://projects.puppetlabs.com/projects/puppet/wiki/Module_Standards]
#
class backuppc::common {

  # Load the variables used in this module. Check the params.pp file
  require ::backuppc::params

  if (!defined(Class['::sudo'])) {
    class { '::sudo':
        ensure => $backuppc::ensure,
    }
  }

  package { $backuppc::params::package:
    ensure => $backuppc::ensure,
  }


  if ($backuppc::ensure == 'present') {
    $service_ensure = true
  } else {
    $service_ensure = false
  }
  # Service
  service { $backuppc::params::service:
    ensure => $service_ensure,
    enable => $service_ensure,
  }

  # Main configuration file
  file {
    $backuppc::params::config_file:
      ensure  => $backuppc::ensure,
      mode    => $backuppc::params::configfile_mode,
      owner   => $backuppc::params::configfile_owner,
      group   => $backuppc::params::configfile_group,
      content => template('backuppc/backuppc.config.pl.erb'),
  }

  # Hostfile
  concat { $backuppc::params::host_file:
    ensure => $backuppc::ensure,
    mode   => $backuppc::params::configfile_mode,
    owner  => $backuppc::params::configfile_owner,
    group  => $backuppc::params::configfile_group,
  }

  concat::fragment{ 'host_file_header':
    target => $backuppc::params::host_file,
    source => 'puppet:///modules/backuppc/hosts',
  }

  Concat::Fragment <<| tag == 'backuppc' |>>

  # Apache configuration
  file {
    $backuppc::params::www_config_file:
      ensure  => $backuppc::ensure,
      mode    => $backuppc::params::configfile_mode,
      owner   => $backuppc::params::configfile_owner,
      group   => $backuppc::params::configfile_group,
      content => template('backuppc/httpd.BackupPC.conf.erb'),
  }

  # Admin password
  exec { 'set web password':
      command => "htpasswd -b -c ${backuppc::params::htpasswd_file} ${backuppc::params::username} ${backuppc::admin_password}",
      path    => '/bin:/sbin:/usr/bin:/usr/sbin',
      unless  => "test -f ${backuppc::params::htpasswd_file}",
  }

  # Call the user class
  class { '::backuppc::user':
    ensure => $backuppc::ensure,
  }

  sudo::directive {'backuppc':
    ensure  => $backuppc::ensure,
    content => "${backuppc::params::username} ALL = NOPASSWD: /bin/gtar\n",
  }

}