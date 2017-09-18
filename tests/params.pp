# File::      <tt>params.pp</tt>
# Author::    Hyacinthe Cartiaux (hyacinthe.cartiaux@uni.lu)
# Copyright:: Copyright (c) 2017 Hyacinthe Cartiaux
# License::   Apache-2.0
#
# ------------------------------------------------------------------------------
# You need the 'future' parser to be able to execute this manifest (that's
# required for the each loop below).
#
# Thus execute this manifest in your vagrant box as follows:
#
#      sudo puppet apply -t --parser future /vagrant/tests/params.pp
#
#

include '::backuppc::params'

$names = ['ensure', 'protocol', 'port', 'packagename']

notice("backuppc::params::ensure = ${backuppc::params::ensure}")
notice("backuppc::params::protocol = ${backuppc::params::protocol}")
notice("backuppc::params::port = ${backuppc::params::port}")
notice("backuppc::params::packagename = ${backuppc::params::packagename}")

#each($names) |$v| {
#    $var = "backuppc::params::${v}"
#    notice("${var} = ", inline_template('<%= scope.lookupvar(@var) %>'))
#}
