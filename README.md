# YNAB bank export converter for Estonian banks

## Requirements
This script is programmed for bash, following toolkits are required:
- csvkit (>= 1.0.2)
- jq (>= 1.6)

## Supported Banks
Currently following Estonian Banks are supported:
- LHV
- Swedbank

in order to use this tool, you have to switch the UI language within your internet banking first to english and then export your account statement in CSV.

## Usage
Basic usage is shown below, the output will always to to stdout()
```
converter.sh [lhv|swedbank] input.csv
```
This tool is targeted for manual import of bank account statements from the above listed supported banks to the [YNAB](https://www.youneedabudget.com/) accounts using the CSV import functionality.


```
importer.sh [lhv] input.csv
```
This tool will read the CSV and automatically imports the transactions into the defined budget using the YNAB API.
In order to have this tool working properly, following requirements need to fulfilled:
- Account name in YNAB contains the matching account IBAN
- Exported CSV from bank are in English language
- Export only dates back to last reconciliation date of the account
- `config.sample` is moved to `config` and filled with your personal details
- Currently only LHV is supported for direct import

**USE AT OWN RISK**
