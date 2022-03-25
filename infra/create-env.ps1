. "$PSScriptRoot\environment.ps1"

az datafactory create --factory-name $adf --location $location --resource-group $rg --output $output

az sql server create --location $location --resource-group $rg --name $sql --admin-user $sqladmin --admin-password $sqlpass --enable-public-network true --output $output

# get my public ip to add as a firewall rule
$pubip = (Invoke-WebRequest -uri "http://ifconfig.me/ip").Content
Write-host $pubip



# setup firewall for azure services
az sql server firewall-rule create -g $rg -s $sql -n myrule --start-ip-address 0.0.0.0 --end-ip-address 0.0.0.0 --output $output
az sql server firewall-rule create -g $rg -s $sql -n myclient --start-ip-address $pubip --end-ip-address $pubip --output $output

az sql db create --resource-group $rg --server $sql --name $db1 --edition GeneralPurpose --family Gen5 --capacity 2 --compute-model Serverless --auto-pause-delay 120 --output $output
az sql db create --resource-group $rg --server $sql --name $db2 --edition GeneralPurpose --family Gen5 --capacity 2 --compute-model Serverless --auto-pause-delay 120 --output $output

Write-host "Use the following connection parameters to use the sqlcmd"
Write-Host $(az sql db show-connection-string --client sqlcmd --name $db1 --server $sql)

# Add the sqlcmd to Powershell path
$env:Path += ";C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\170\Tools\Binn\"

# & to signal we are running an external program
&sqlcmd.exe -S tcp:sqltestteradata1.database.windows.net,1433 -d dbtest001 -U $sqladmin -P $sqlpass -i create-sample-data.sql

&sqlcmd.exe -S tcp:sqltestteradata1.database.windows.net,1433 -d dbtest002 -U $sqladmin -P $sqlpass -i create-dest-schema.sql
