#!/bin/bash
source config
source functions

OUTPUT=$outputFolder
CSV=$2
MODE=$1

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

