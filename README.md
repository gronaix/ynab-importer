# YNAB bank export converter for Estonian banks

## Requirements
This script is programmed for bash, following toolkits are required:
- csvkit (>= 1.0.2)
- jq (>= 1.6)

## Supported Banks
Currently following Estonian Banks are supported:
- LHV
- Swedbank

in order to use this tool, you have to switch the UI language within your internet banking first to english and the export your account statement in CSV.

## Usage
Basic usage is shown below, the output will always to to stdout()
```
converter.sh [lhv|swedbank] input.csv
```

This tool is targeted for manual import of bank account statements from the above listed supported banks to the [YNAB](https://www.youneedabudget.com/) accounts using the CSV import functionality.
There is no auto import using the YNAB API and it is purely designed to convert the bank outputs into a format, that is directly understood by YNAB

**USE AT OWN RISK**
