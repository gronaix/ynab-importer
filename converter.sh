#!/bin/bash

OUTPUT=/media/nextcloud/Documents/statements
CSV=$2
MODE=$1

usage() {
	echo "converter.sh [lhv|swedbank] input.csv"
}

swedbank() {
	filename="$( csvcut -c 1 -d";" $1 | head -n 2|tail -n1)_$(date "+%Y-%m-%d_%H-%M-%S").csv" 
	csvcut -d";" -c 3,2,4,5,6,8 $1 | csvjson -L et_EE.utf8 --date-format "%d.%m.%Y" | jq '.[]|select(."Row type"==20)'|jq 'if ."Debit/Credit" == "D" then .Amount = (.Amount*-1) else .Amount = .Amount end|del(."Row type",."Debit/Credit")|.["Memo"] = .Details|.["Payee"] = ."Beneficiary/Payer"|del(.Details, ."Beneficiary/Payer")'|jq -sc|in2csv -f json > $OUTPUT/$filename && echo "saved in $OUTPUT/$filename" && rm -v $CSV
}

lhv() {
	filename="$( csvcut -c 1 -d"," $1 | head -n 2|tail -n1)_$(date "+%Y-%m-%d_%H-%M-%S").csv" 
	csvcut -d"," -c 3,5,9,12 $1 | csvformat -U 2 |  csvjson | jq 'map(.Payee = ."Sender/receiver name" | .Memo = .Description | del(."Sender/receiver name", .Description))' | in2csv -f json > $OUTPUT/$filename && echo "saved in $OUTPUT/$filename" && rm -v $CSV
}

case $MODE in
	"lhv")
	       	lhv $CSV
	;;
"swedbank")
		swedbank $CSV
		;;
	*)
		usage
		;;
esac

