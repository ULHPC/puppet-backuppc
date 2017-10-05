################################################################################
# Time-stamp: <Thu 2017-09-07 15:52:35 hcartiaux>
#
# File::      <tt>user.pp</tt>
# Author::    Hyacinthe Cartiaux (hyacinthe.cartiaux@uni.lu)
# Copyright:: Copyright (c) 2017 Hyacinthe Cartiaux
# License::   Apache-2.0
#
# ------------------------------------------------------------------------------
# = Class: backuppc::user
#
# Base class to be inherited by the other backuppc classes, containing the user code.
#
# Note: respect the Naming standard provided here[http://projects.puppetlabs.com/projects/puppet/wiki/Module_Standards]
#
class backuppc::user(
    String $server_sshkey_type    = '',
    String $server_sshkey_comment = '',
    String $server_sshkey         = '',
    String $ensure                = $backuppc::params::ensure
) {

  # Load the variables used in this module. Check the params.pp file
  require ::backuppc::params

  # Create the user
  user {
    $backuppc::params::username:
      ensure  => $ensure,
      system  => true,
      shell   => $backuppc::params::shell,
      home    => $backuppc::params::home,
      comment => $backuppc::params::comment,
  }

  if (! defined(Class['::backuppc'])) {
    # If the server is not installed, we setup the sudo configuration for a remote server to be backed up
    sudo::directive {'backuppc':
      ensure  => $ensure,
      content => "${backuppc::params::username}  ALL=NOPASSWD: /usr/bin/rsync --server --sender *\n",
    }
    @@concat::fragment{ $::fqdn:
        target  => $backuppc::params::host_file,
        content => "${::fqdn} 0 ${backuppc::params::username}\n",
        tag     => ['backuppc'],
    }
  } else {
    @@concat::fragment{ 'localhost':
        target  => $backuppc::params::host_file,
        content => "localhost 0 ${backuppc::params::username}\n",
        tag     => ['backuppc'],
    }
  }

  if ($ensure == 'present')
  {
    file { $backuppc::params::home:
      ensure  => 'directory',
      owner   => $backuppc::params::username,
      group   => $backuppc::params::username,
      mode    => $backuppc::params::configdir_mode,
      require => User[$backuppc::params::username];
          "${backuppc::params::home}/.ssh":
      ensure  => 'directory',
      owner   => $backuppc::params::username,
      group   => $backuppc::params::username,
      require => User[$backuppc::params::username];
    }

    if (! empty("${server_sshkey}${server_sshkey_type}${server_sshkey_comment}"))
    {
      # Set up the public SSH key in authorized_keys
      ssh_authorized_key { $server_sshkey_comment:
        ensure  => $ensure,
        user    => $backuppc::params::username,
        type    => $server_sshkey_type,
        key     => $server_sshkey,
        require => File["${backuppc::params::home}/.ssh"],
      }
    }
    if (defined(Package[$backuppc::params::package])) {
      # Generate the private SSH key if public_key is not provided
      exec { "/bin/ssh-keygen -t rsa -f ${backuppc::params::home}/.ssh/id_rsa -q -N ''":
        user    => $backuppc::params::username,
        cwd     => $backuppc::params::home,
        creates => "${backuppc::params::home}/.ssh/id_rsa",
        require => File["${backuppc::params::home}/.ssh"],
      }
    }
  } else {
      exec { "/bin/rm -rf ${backuppc::params::home}":
        cwd    => $backuppc::params::home,
        onlyif => "/bin/test -d ${backuppc::params::home}",
      }
  }

}
