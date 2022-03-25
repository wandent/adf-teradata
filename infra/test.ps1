. "$PSScriptRoot\environment.ps1"
# get my public ip to add as a firewall rule
$pubip = (Invoke-WebRequest -uri "http://ifconfig.me/ip").Content
Write-host $pubip



# setup firewall for azure services
az sql server firewall-rule create -g $rg -s $sql -n myrule --start-ip-address 0.0.0.0 --end-ip-address 0.0.0.0 --output $output
az sql server firewall-rule create -g $rg -s $sql -n myclient --start-ip-address $pubip --end-ip-address $pubip --output $output

&sqlcmd.exe -S tcp:sqltestteradata1.database.windows.net,1433 -d dbtest001 -U $sqladmin -P $sqlpass -i create-sample-data.sql
&sqlcmd.exe -S tcp:sqltestteradata1.database.windows.net,1433 -d dbtest002 -U $sqladmin -P $sqlpass -i create-dest-schema.sql