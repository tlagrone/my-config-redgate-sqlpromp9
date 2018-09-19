[CmdletBinding()]
Param (
    [Parameter()]
    [string]
    [ValidateNotNullOrEmpty()]
    $SqlPromptHome = '..\',  # path that is either absolute or relative to invocation location

    [Parameter()]
    [string]
    [ValidateNotNullOrEmpty()]
    $SnippetsDirectory = 'Snippets'  # path that is relative to $SqlPromptHome
)

Get-ChildItem -Path (Join-Path $SqlPromptHome $SnippetsDirectory) |
    ForEach-Object 'Name' |
    ForEach-Object 'Trim' |
    Where-Object 'Length' -gt 0 |
    ForEach-Object {
        [System.Text.RegularExpressions.Regex]::
            new('([^.]+)\..*').
            Match($_).
            Groups[1].
            Value
    } |
    Sort-Object