#!/bin/bash
cd ~/code/ynab-importer
source ~/code/ynab-importer/config
source ~/code/ynab-importer/functions

OUTPUT=$outputFolder
CSV=$2
MODE=$1

testCSV

case $MODE in
	"lhv")
	       	lhvConvert $CSV
	;;
"swedbank")
		swedbankConvert $CSV
		;;
	*)
		convertUsage
		;;
esac

