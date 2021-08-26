[CmdletBinding()]
param (
    [string] $ResourceGroupName = "bicepdeployed",
    [string] $TemplateParameters = "`@params.json",
    [string] $EnvironmentVariablePrefix = ""
)

Set-Location $PSScriptRoot

az group create --name $ResourceGroupName --location "West Europe"
$res = az deployment group create --resource-group $ResourceGroupName --template-file backtotech.bicep --parameters $TemplateParameters

if ($env:GITHUB_ENV) {
    $items = ($res | ConvertFrom-Json).properties.outputs

    $items | Get-Member -MemberType NoteProperty | ForEach-Object {
        $value = $items.($_.Name).value
        Write-Host "$($EnvironmentVariablePrefix)$($_.Name) ==> $($value)"
        "$($EnvironmentVariablePrefix)$($_.Name)=$($value)" | Add-Content -Path $env:GITHUB_ENV
    }
}