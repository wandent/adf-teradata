. "$PSScriptRoot\environment.ps1"
$ls1json = $(Get-Content -Path ls1.json -Encoding UTF8 -Raw | Out-String)
#Write-Host $(Get-Content -Path ls1.json -Encoding UTF8 -Raw | Out-String)
az datafactory linked-service create --factory-name $adf --properties $ls1json --linked-service-name $ls1 --resource-group $rg 
