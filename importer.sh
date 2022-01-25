#!/bin/bash

#
# configuration
#
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source config
source functions
session=$( uuidgen )
temp=/tmp/${session}
#
# ARGS
#
MODE=$1
CSV=$2

#
# Init
#
mkdir -p $temp
getAccounts > $temp/accounts.json

#
# main
#
case $MODE in
	"lhv")
		transactions=$( lhvRead $CSV )
		importTransactions "$transactions"
		;;
	"swedbank")
		swedbankConvert $CSV
		;;
	*)
		importUsage 
		;;
esac


# 
# cleanup
#
rm -fr $temp
