################################################################################
# Time-stamp: <Mon 2017-09-18 10:40:46 hcartiaux>
#
# File::      <tt>params.pp</tt>
# Author::    Hyacinthe Cartiaux (hyacinthe.cartiaux@uni.lu)
# Copyright:: Copyright (c) 2017 Hyacinthe Cartiaux
# License::   Apache-2.0
#
# ------------------------------------------------------------------------------
# == Class: backuppc::params
#
# In this class are defined as variables values that are used in other
# backuppc classes and definitions.
# This class should be included, where necessary, and eventually be enhanced
# with support for more Operating Systems.
#
# == Warnings
#
# /!\ Always respect the style guide available
# here[http://docs.puppetlabs.com/guides/style_guide]
#
# [Remember: No empty lines between comments and class definition]
#
class backuppc::params {

  $allowed_hosts          = []

  $wakeupschedule         = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
  $maxbackups             = 4
  $maxuserbackups         = 4
  $maxpendingcmds         = 15
  $cmdqueuenice           = 10
  $maxbackuppcnightlyjobs = 2
  $backuppcnightlyperiod  = 1
  $poolsizenightlyperiod  = 16
  $refcntfsck             = 1
  $maxoldlogfiles         = 14
  $dfmaxusagepct          = 95
  $fullperiod             = 6.97
  $incrperiod             = 0.97
  $fillcycle              = 0
  $fullkeepcnt            = 1
  $fullkeepcntmin         = 1
  $fullagemax             = 180
  $incrkeepcnt            = 6
  $incrkeepcntmin         = 1
  $incragemax             = 30
  $backupsdisable         = 0
  $restoreinfokeepcnt     = 10
  $archiveinfokeepcnt     = 10
  $backupfilesonly        = 'undef'
  $backupfilesexclude     = 'undef'
  $backupzerofilesisfatal = 1
  $xfermethod             = 'rsync'
  $xferloglevel           = 1
  $clientcharset          = ''
  $clientcharsetlegacy    = 'iso-8859-15'
  $smbsharename           = 'C$'
  $smbshareusername       = ''
  $smbsharepasswd         = ''
  $smbclientpath          = '/usr/bin/smbclient'
  $smbclientfullcmd       = '$smbClientPath \\\\$host\\$shareName $I_option -U $userName -E -d 1 -c tarmode\\ full -Tc$X_option - $fileList'
  $smbclientincrcmd       = '$smbClientPath \\\\$host\\$shareName $I_option -U $userName -E -d 1 -c tarmode\\ full -TcN$X_option $timeStampFile - $fileList'
  $smbclientrestorecmd    = '$smbClientPath \\\\$host\\$shareName $I_option -U $userName -E -d 1 -c tarmode\\ full -Tx -'
  $tarsharename           = '/'
  $tarclientcmd           = '$sshPath -q -x -n -l root $host env LC_ALL=C $tarPath -c -v -f - -C $shareName+ --totals'
  $tarfullargs            = '$fileList+'
  $tarincrargs            = '--newer=$incrDate+ $fileList+'
  $tarclientrestorecmd    = '$sshPath -q -x -l root $host env LC_ALL=C $tarPath -x -p --numeric-owner --same-owner -v -f - -C $shareName+'
  $tarclientpath          = '/usr/bin/gtar'
  $rsyncclientpath        = '/usr/bin/rsync'
  $rsyncbackuppcpath      = '/usr/bin/rsync_bpc'
  $rsyncsshargs           = ['-e', '$sshPath -l root']
  $rsyncsharename         = '/'
  $rsyncdclientport       = 873
  $rsyncdusername         = ''
  $rsyncdpasswd           = ''
  $rsyncfullargsextra     = [ '--checksum' ]
  $rsyncargs              = [
    '--super',
    '--recursive',
    '--protect-args',
    '--numeric-ids',
    '--perms',
    '--owner',
    '--group',
    '-D',
    '--times',
    '--links',
    '--hard-links',
    '--delete',
    '--delete-excluded',
    '--one-file-system',
    '--partial',
    '--log-format=log: %o %i %B %8U,%8G %9l %f%L',
    '--stats',
  ]
  $rsyncargsextra         = []
  $rsyncrestoreargs       = [
    '--recursive',
    '--super',
    '--protect-args',
    '--numeric-ids',
    '--perms',
    '--owner',
    '--group',
    '-D',
    '--times',
    '--links',
    '--hard-links',
    '--delete',
    '--partial',
    '--log-format=log: %o %i %B %8U,%8G %9l %f%L',
    '--stats',
  ]
  $ftpsharename              = ''
  $ftpusername               = ''
  $ftppasswd                 = ''
  $ftppassive                = 1
  $ftpblocksize              = 10240
  $ftpport                   = 21
  $ftptimeout                = 120
  $ftpfollowsymlinks         = 0
  $archivedest               = '/tmp'
  $archivecomp               = 'gzip'
  $archivepar                = 0
  $archivesplit              = 0
  $archiveclientcmd          = '$Installdir/bin/BackupPC_archiveHost $tarCreatePath $splitpath $parpath $host $backupnumber $compression $compext $splitsize $archiveloc $parfile *'
  $sshpath                   = '/usr/bin/ssh'
  $nmblookuppath             = '/usr/bin/nmblookup'
  $nmblookupcmd              = '$nmbLookupPath -A'
  $nmblookupfindhostcmd      = '$nmbLookupPath $host'
  $fixedipnetbiosnamecheck   = 0
  $pingpath                  = '/usr/bin/ping'
  $ping6path                 = '/usr/sbin/ping6'
  $pingcmd                   = '$pingPath -c 1 $host'
  $pingmaxmsec               = 20
  $compresslevel             = 3
  $clienttimeout             = 72000
  $maxoldperpclogfiles       = 12
  $dumppreusercmd            = 'undef'
  $dumppostusercmd           = 'undef'
  $dumppresharecmd           = 'undef'
  $dumppostsharecmd          = 'undef'
  $restorepreusercmd         = 'undef'
  $restorepostusercmd        = 'undef'
  $archivepreusercmd         = 'undef'
  $archivepostusercmd        = 'undef'
  $usercmdcheckstatus        = 0
  $clientnamealias           = 'undef'
  $sendmailpath              = '/usr/sbin/sendmail'
  $emailnotifymindays        = 2.5
  $emailfromusername         = 'backuppc'
  $emailadminusername        = 'backuppc'
  $emailuserdestdomain       = ''
  $emailnobackupeversubj     = 'undef'
  $emailnobackupevermesg     = 'undef'
  $emailnotifyoldbackupdays  = 7.0
  $emailnobackuprecentsubj   = 'undef'
  $emailnobackuprecentmesg   = 'undef'
  $emailnotifyoldoutlookdays = 5.0
  $emailoutlookbackupsubj    = 'undef'
  $emailoutlookbackupmesg    = 'undef'
  $emailheaders              = '
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
'
  $cgiadminusergroup         = ''
  $cgiadminusers             = ''
  $scgiserverport            = -1
  $cgiurl                    = 'http://localhost/BackupPC'
  $rrdtoolpath               = '/usr/bin/rrdtool'
  $language                  = 'en'
  $cgiuserhomepagecheck      = ''
  $cgiuserurlcreate          = 'mailto:%s'
  $cgidateformatmmdd         = 1
  $cginavbaradminallhosts    = 1
  $cgisearchboxenable        = 1
  $cgiheaders                = '<meta http-equiv="pragma" content="no-cache">'
  $cgiimagedir               = '/usr/share/BackupPC/html/'
  $cgiimagedirurl            = '/BackupPC/images'
  $cgicssfile                = 'BackupPC_stnd.css'
  $cgiuserconfigeditenable   = 1

  #### MODULE INTERNAL VARIABLES  #########
  # (Modify to adapt to unsupported OSes)
  #########################################

  # ensure the presence (or absence) of backuppc
  $ensure = 'present'

  ###########################################
  # backuppc system configs
  ###########################################

  case $::operatingsystem {
    /(Ubuntu|Debian)/: {
      $package          = 'backuppc'
      $service          = 'backuppc'
      $config_directory = '/etc/backuppc'
      $www_config_file  = '/etc/apache2/conf.d/backuppc.conf'
      $username         = 'backuppc'
      $home             = '/var/lib/backuppc'
      $comment          = 'BackupPC User'
      $shell            = '/sbin/nologin'
    }
    /(RedHat|CentOS)/: {
      $package           = 'backuppc'
      $service           = 'backuppc'
      $config_directory  = '/etc/BackupPC'
      $www_config_file   = '/etc/httpd/conf.d/BackupPC.conf'
      $username          = 'backuppc'
      $home              = '/var/lib/BackupPC'
      $comment           = 'BackupPC User'
      $shell             = '/sbin/nologin'
    }
    default: {
      $package           = 'backuppc'
      $service           = 'backuppc'
      $config_directory  = '/etc/BackupPC'
      $www_config_file   = '/etc/httpd/conf.d/BackupPC.conf'
      $username          = 'backuppc'
      $home              = '/var/lib/BackupPC'
      $comment           = 'BackupPC User'
      $shell             = '/sbin/nologin'
    }
  }

  # Config file
  $config_file = "${config_directory}/config.pl"

  # Host file
  $host_file = "${config_directory}/hosts"

  # Password file
  $htpasswd_file = "${config_directory}/apache.users"
  # backuppc associated services
  $servicename = $::operatingsystem ? {
    default => 'backuppc'
  }

  # backuppc packages
  $packagename = $::operatingsystem ? {
    default => 'backuppc',
  }

  # Configuration directory & file
  $configdir_mode = $::operatingsystem ? {
    default => '0755',
  }
  $configdir_owner = $::operatingsystem ? {
    default => 'root',
  }
  $configdir_group = $::operatingsystem ? {
    default => 'root',
  }

  $configfile_mode = $::operatingsystem ? {
    default => '0640',
  }
  $configfile_owner = $::operatingsystem ? {
    default => 'root',
  }
  $configfile_group = $::operatingsystem ? {
    default => 'root',
  }

}
