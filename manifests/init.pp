################################################################################
# Time-stamp: <Thu 2017-09-07 19:00:40 hcartiaux>
#
# File::      <tt>init.pp</tt>
# Author::    Hyacinthe Cartiaux (hyacinthe.cartiaux@uni.lu)
# Copyright:: Copyright (c) 2017 Hyacinthe Cartiaux
# License::   Apache-2.0
#
# ------------------------------------------------------------------------------
# == Class: backuppc
#
# Configure and manage BackupPC server and clients
#
#
# @param ensure [String] Default: 'present'.
#          Ensure the presence (or absence) of backuppc
#
# @param admin_password [String]
#          Administrator password on the web interface
#
# @param allowed_hosts [Array] Default: [].
#          List of IP / hostname allowed on the web interface
#
# @param home [String] Default: '/var/lib/BackupPC'.
#          Location of the backuppc home directory
#
# === Requires
#
# n/a
#
# @example Basic instanciation
#
#     include '::backuppc'
#
# You can then specialize the various aspects of the configuration,
# for instance:
#
#         class { '::backuppc':
#             ensure => 'present'
#         }
#
# === Authors
#
# The UL HPC Team <hpc-sysadmins@uni.lu> of the University of Luxembourg, in
# particular
# * Sebastien Varrette <Sebastien.Varrette@uni.lu>
# * Valentin Plugaru   <Valentin.Plugaru@uni.lu>
# * Sarah Peter        <Sarah.Peter@uni.lu>
# * Hyacinthe Cartiaux <Hyacinthe.Cartiaux@uni.lu>
# * Clement Parisot    <Clement.Parisot@uni.lu>
# See AUTHORS for more details
#
# === Warnings
#
# /!\ Always respect the style guide available here[http://docs.puppetlabs.com/guides/style_guide]
#
# [Remember: No empty lines between comments and class definition]
#
class backuppc(
    String  $admin_password,
    String  $ensure                    = $backuppc::params::ensure,
    String  $home                      = $backuppc::params::home,
    Array   $allowed_hosts             = $backuppc::params::allowed_hosts,
    Array   $wakeupschedule            = $backuppc::params::wakeupschedule,
    Integer $maxbackups                = $backuppc::params::maxbackups,
    Integer $maxuserbackups            = $backuppc::params::maxuserbackups,
    Integer $maxpendingcmds            = $backuppc::params::maxpendingcmds,
    Integer $cmdqueuenice              = $backuppc::params::cmdqueuenice,
    Integer $maxbackuppcnightlyjobs    = $backuppc::params::maxbackuppcnightlyjobs,
    Integer $backuppcnightlyperiod     = $backuppc::params::backuppcnightlyperiod,
    Integer $poolsizenightlyperiod     = $backuppc::params::poolsizenightlyperiod,
    Integer $refcntfsck                = $backuppc::params::refcntfsck,
    Integer $maxoldlogfiles            = $backuppc::params::maxoldlogfiles,
    Integer $dfmaxusagepct             = $backuppc::params::dfmaxusagepct,
    Float   $fullperiod                = $backuppc::params::fullperiod,
    Float   $incrperiod                = $backuppc::params::incrperiod,
    Integer $fillcycle                 = $backuppc::params::fillcycle,
    Integer $fullkeepcnt               = $backuppc::params::fullkeepcnt,
    Integer $fullkeepcntmin            = $backuppc::params::fullkeepcntmin,
    Integer $fullagemax                = $backuppc::params::fullagemax,
    Integer $incrkeepcnt               = $backuppc::params::incrkeepcnt,
    Integer $incrkeepcntmin            = $backuppc::params::incrkeepcntmin,
    Integer $incragemax                = $backuppc::params::incragemax,
    Integer $backupsdisable            = $backuppc::params::backupsdisable,
    Integer $restoreinfokeepcnt        = $backuppc::params::restoreinfokeepcnt,
    Integer $archiveinfokeepcnt        = $backuppc::params::archiveinfokeepcnt,
    String  $backupfilesonly           = $backuppc::params::backupfilesonly,
    String  $backupfilesexclude        = $backuppc::params::backupfilesexclude,
    Integer $backupzerofilesisfatal    = $backuppc::params::backupzerofilesisfatal,
    String  $xfermethod                = $backuppc::params::xfermethod,
    Integer $xferloglevel              = $backuppc::params::xferloglevel,
    String  $clientcharset             = $backuppc::params::clientcharset,
    String  $clientcharsetlegacy       = $backuppc::params::clientcharsetlegacy,
    String  $smbsharename              = $backuppc::params::smbsharename,
    String  $smbshareusername          = $backuppc::params::smbshareusername,
    String  $smbsharepasswd            = $backuppc::params::smbsharepasswd,
    String  $smbclientpath             = $backuppc::params::smbclientpath,
    String  $smbclientfullcmd          = $backuppc::params::smbclientfullcmd,
    String  $smbclientincrcmd          = $backuppc::params::smbclientincrcmd,
    String  $smbclientrestorecmd       = $backuppc::params::smbclientrestorecmd,
    String  $tarsharename              = $backuppc::params::tarsharename,
    String  $tarclientcmd              = $backuppc::params::tarclientcmd,
    String  $tarfullargs               = $backuppc::params::tarfullargs,
    String  $tarincrargs               = $backuppc::params::tarincrargs,
    String  $tarclientrestorecmd       = $backuppc::params::tarclientrestorecmd,
    String  $tarclientpath             = $backuppc::params::tarclientpath,
    String  $rsyncclientpath           = $backuppc::params::rsyncclientpath,
    String  $rsyncbackuppcpath         = $backuppc::params::rsyncbackuppcpath,
    Array   $rsyncsshargs              = $backuppc::params::rsyncsshargs,
    String  $rsyncsharename            = $backuppc::params::rsyncsharename,
    Integer $rsyncdclientport          = $backuppc::params::rsyncdclientport,
    String  $rsyncdusername            = $backuppc::params::rsyncdusername,
    String  $rsyncdpasswd              = $backuppc::params::rsyncdpasswd,
    Array   $rsyncfullargsextra        = $backuppc::params::rsyncfullargsextra,
    Array   $rsyncargs                 = $backuppc::params::rsyncargs,
    Array   $rsyncargsextra            = $backuppc::params::rsyncargsextra,
    Array   $rsyncrestoreargs          = $backuppc::params::rsyncrestoreargs,
    String  $ftpsharename              = $backuppc::params::ftpsharename,
    String  $ftpusername               = $backuppc::params::ftpusername,
    String  $ftppasswd                 = $backuppc::params::ftppasswd,
    Integer $ftppassive                = $backuppc::params::ftppassive,
    Integer $ftpblocksize              = $backuppc::params::ftpblocksize,
    Integer $ftpport                   = $backuppc::params::ftpport,
    Integer $ftptimeout                = $backuppc::params::ftptimeout,
    Integer $ftpfollowsymlinks         = $backuppc::params::ftpfollowsymlinks,
    String  $archivedest               = $backuppc::params::archivedest,
    String  $archivecomp               = $backuppc::params::archivecomp,
    Integer $archivepar                = $backuppc::params::archivepar,
    Integer $archivesplit              = $backuppc::params::archivesplit,
    String  $archiveclientcmd          = $backuppc::params::archiveclientcmd,
    String  $sshpath                   = $backuppc::params::sshpath,
    String  $nmblookuppath             = $backuppc::params::nmblookuppath,
    String  $nmblookupcmd              = $backuppc::params::nmblookupcmd,
    String  $nmblookupfindhostcmd      = $backuppc::params::nmblookupfindhostcmd,
    Integer $fixedipnetbiosnamecheck   = $backuppc::params::fixedipnetbiosnamecheck,
    String  $pingpath                  = $backuppc::params::pingpath,
    String  $ping6path                 = $backuppc::params::ping6path,
    String  $pingcmd                   = $backuppc::params::pingcmd,
    Integer $pingmaxmsec               = $backuppc::params::pingmaxmsec,
    Integer $compresslevel             = $backuppc::params::compresslevel,
    Integer $clienttimeout             = $backuppc::params::clienttimeout,
    Integer $maxoldperpclogfiles       = $backuppc::params::maxoldperpclogfiles,
    String  $dumppreusercmd            = $backuppc::params::dumppreusercmd,
    String  $dumppostusercmd           = $backuppc::params::dumppostusercmd,
    String  $dumppresharecmd           = $backuppc::params::dumppresharecmd,
    String  $dumppostsharecmd          = $backuppc::params::dumppostsharecmd,
    String  $restorepreusercmd         = $backuppc::params::restorepreusercmd,
    String  $restorepostusercmd        = $backuppc::params::restorepostusercmd,
    String  $archivepreusercmd         = $backuppc::params::archivepreusercmd,
    String  $archivepostusercmd        = $backuppc::params::archivepostusercmd,
    Integer $usercmdcheckstatus        = $backuppc::params::usercmdcheckstatus,
    String  $clientnamealias           = $backuppc::params::clientnamealias,
    String  $sendmailpath              = $backuppc::params::sendmailpath,
    Float   $emailnotifymindays        = $backuppc::params::emailnotifymindays,
    String  $emailfromusername         = $backuppc::params::emailfromusername,
    String  $emailadminusername        = $backuppc::params::emailadminusername,
    String  $emailuserdestdomain       = $backuppc::params::emailuserdestdomain,
    String  $emailnobackupeversubj     = $backuppc::params::emailnobackupeversubj,
    String  $emailnobackupevermesg     = $backuppc::params::emailnobackupevermesg,
    Float   $emailnotifyoldbackupdays  = $backuppc::params::emailnotifyoldbackupdays,
    String  $emailnobackuprecentsubj   = $backuppc::params::emailnobackuprecentsubj,
    String  $emailnobackuprecentmesg   = $backuppc::params::emailnobackuprecentmesg,
    Float   $emailnotifyoldoutlookdays = $backuppc::params::emailnotifyoldoutlookdays,
    String  $emailoutlookbackupsubj    = $backuppc::params::emailoutlookbackupsubj,
    String  $emailoutlookbackupmesg    = $backuppc::params::emailoutlookbackupmesg,
    String  $emailheaders              = $backuppc::params::emailheaders,
    String  $cgiadminusergroup         = $backuppc::params::cgiadminusergroup,
    String  $cgiadminusers             = $backuppc::params::cgiadminusers,
    Integer $scgiserverport            = $backuppc::params::scgiserverport,
    String  $cgiurl                    = $backuppc::params::cgiurl,
    String  $rrdtoolpath               = $backuppc::params::rrdtoolpath,
    String  $language                  = $backuppc::params::language,
    String  $cgiuserhomepagecheck      = $backuppc::params::cgiuserhomepagecheck,
    String  $cgiuserurlcreate          = $backuppc::params::cgiuserurlcreate,
    Integer $cgidateformatmmdd         = $backuppc::params::cgidateformatmmdd,
    Integer $cginavbaradminallhosts    = $backuppc::params::cginavbaradminallhosts,
    Integer $cgisearchboxenable        = $backuppc::params::cgisearchboxenable,
    String  $cgiheaders                = $backuppc::params::cgiheaders,
    String  $cgiimagedir               = $backuppc::params::cgiimagedir,
    String  $cgiimagedirurl            = $backuppc::params::cgiimagedirurl,
    String  $cgicssfile                = $backuppc::params::cgicssfile,
    Integer $cgiuserconfigeditenable   = $backuppc::params::cgiuserconfigeditenable
)
inherits backuppc::params
{
    validate_legacy('String', 'validate_re', $ensure, ['^present', '^absent'])

    info ("Configuring backuppc (with ensure = ${ensure})")

    case $::operatingsystem {
        /(?i-mx:centos|fedora|redhat)/: { include ::backuppc::common::redhat }
        default: {
            fail("Module ${module_name} is not supported on ${::operatingsystem}")
        }
    }
}
