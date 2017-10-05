################################################################################
# Time-stamp: <Fri 2017-09-08 12:43:01 hcartiaux>
#
# File::      <tt>common/redhat.pp</tt>
# Author::    Hyacinthe Cartiaux (hyacinthe.cartiaux@uni.lu)
# Copyright:: Copyright (c) 2017 Hyacinthe Cartiaux
# License::   Apache-2.0
#
# ------------------------------------------------------------------------------
# = Class: backuppc::common::redhat
#
# Specialization class for Redhat systems
class backuppc::common::redhat inherits backuppc::common {

  yumrepo { 'hobbes1069-BackupPC':
    ensure              => $backuppc::ensure,
    name                => 'hobbes1069-BackupPC',
    baseurl             => 'https://copr-be.cloud.fedoraproject.org/results/hobbes1069/BackupPC/epel-7-$basearch/',
    skip_if_unavailable => true,
    gpgcheck            => true,
    gpgkey              => 'https://copr-be.cloud.fedoraproject.org/results/hobbes1069/BackupPC/pubkey.gpg',
    repo_gpgcheck       => true,
    enabled             => true,
    include             => 'https://copr.fedorainfracloud.org/coprs/hobbes1069/BackupPC/repo/epel-7/hobbes1069-BackupPC-epel-7.repo',
  }

}
