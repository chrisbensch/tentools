function Remove-TNReport {
    <#
    .SYNOPSIS
        Removes a list of reports

    .DESCRIPTION
        Removes a list of reports

    .PARAMETER SessionObject
        Optional parameter to force using specific SessionObjects. By default, each command will connect to all connected servers that have been connected to using Connect-TNServer

    .PARAMETER ReportId
        The ID of the target report

    .PARAMETER EnableException
        By default, when something goes wrong we try to catch it, interpret it and give you a friendly warning message.
        This avoids overwhelming you with 'sea of red' exceptions, but is inconvenient because it basically disables advanced scripting.
        Using this switch turns this 'nice by default' feature off and enables you to catch exceptions with your own try/catch.

    .EXAMPLE
        PS C:\> Get-TNReport | Remove-TNReport

        Removes a list of reports

#>
    [CmdletBinding()]
    param
    (
        [Parameter(ValueFromPipelineByPropertyName)]
        [object[]]$SessionObject = (Get-TNSession),
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias("Id")]
        [int32[]]$ReportId,
        [switch]$EnableException
    )
    process {
        foreach ($session in $SessionObject) {
            foreach ($id in $ReportId) {
                Write-PSFMessage -Level Verbose -Message "Deleting report with id $id"
                Invoke-TNRequest -SessionObject $session -EnableException:$EnableException -Path "/reportDefinition/$id" -Method Delete | ConvertFrom-TNRestResponse
                Write-PSFMessage -Level Verbose -Message 'Report deleted'
            }
        }
    }
}