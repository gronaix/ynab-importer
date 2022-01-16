#!/bin/bash
#set -x
CSV=$1

# import CSV and delete opening balance, turnover and closing balance fields
echo '"Date";"Payee";"Memo";"Amount"'
jsondata=$(csvcut -d ";" -c 1-8 $CSV | csvjson -L et_EE.utf8 --date-format "%d.%m.%Y"  | jq '.[] | select(."Row type"==20)' | jq -sc) 
readarray -t my_array < <(echo $jsondata|jq -c '.[]')
for item in "${my_array[@]}"
do
	tdate=$( echo $item | jq .Date )
	tpayee=$( echo $item | jq '."Beneficiary/Payer"' )
	tmemo=$( echo $item | jq .Details )
	ttype=$( echo $item | jq '."Debit/Credit"' -r )
	if [ "$ttype" == "D" ]
	then
		tamount=$( echo "scale=2;$(echo $item | jq .Amount)*-1"|bc ) 
		
	else
		tamount=$( echo $item | jq .Amount ) 
	fi


	echo ''$tdate';'$tpayee';'$tmemo';'$tamount''
done


