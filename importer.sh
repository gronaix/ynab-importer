#!/bin/bash

#
# configuration
#
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source config
source functions
session=$( uuidgen )
temp=/tmp/${session}
OUTPUT=$outputFolder
#
# ARGS
#
MODE=$1
CSV=$2

#
# Init
#
testCSV
mkdir -p $temp
getAccounts > $temp/accounts.json

#
# main
#
case $MODE in
	"lhv")
		transactions=$( lhvRead $CSV )
		importTransactions "$transactions" | jq .
		lhvConvert $CSV
		;;
	"swedbank")
		transactions=$( swedbankRead $CSV )
		importTransactions "$transactions" | jq .
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
