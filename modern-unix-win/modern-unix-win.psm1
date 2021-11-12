$binPath = Join-Path $PSScriptRoot 'bin'
$supportPath = Join-Path $PSScriptRoot 'support'
$env:Path += ";$binPath"

<#
.SYNOPSIS
List the installed tools.
#>
function Get-ModernUnixTools {
  [OutputType([String])]
  [CmdletBinding()] param([string] $Like = '*')
  (gci $supportPath -Directory).Name -like $Like
}

<#
.SYNOPSIS
Return the content of the man file from the support folder for the given tool, if it exists.
#>
function Get-ModernUnixManual {
  [OutputType([String])]
  [CmdletBinding()]
  param(
    [ArgumentCompleter( { Get-ModernUnixTools })]
    [Parameter(Mandatory)]
    [string] $ToolName)

  $manPath = Join-Path $supportPath $ToolName "$ToolName.1"
  if (Test-Path $manPath) { Get-Content $manPath }
  else { Write-Error "No man file found for '$ToolName'." }
}

<#
.SYNOPSIS
Enable command completion for the given tool, or for all of the installed tools if the argument is omitted.
#>
function Enable-ModernUnixCompletions {
  [OutputType([void])]
  [CmdletBinding()]
  param([ArgumentCompleter( { Get-ModernUnixTools })] [string] $ToolName)

  if (!$ToolName) {
    gci $supportPath -Directory | % { Enable-ModernUnixCompletions $_.Name -ErrorAction:SilentlyContinue }
  }

  else {
    $completionPath = Join-Path $supportPath $ToolName "_$ToolName.ps1"
    if (Test-Path $completionPath) { . $completionPath }
    elseif (!$SuppressError) { Write-Error "No completion file found for '$ToolName'." }
  }
}

<#
.SYNOPSIS
One off initialisation of `cheat`. Sets up a directory structure and downloads community cheatsheets.
#>
function Initialize-Cheat {
  $root = Join-Path $env:APPDATA 'cheat'
  $cheatSheets = Join-Path $root 'cheatsheets'
  $personal, $community = 'personal', 'community' | % { Join-Path $cheatSheets $_ }
  mkdir $personal, $community -Force
  $env:CHEAT_CONFIG_PATH = Join-Path $root 'config.yml'
  [Environment]::SetEnvironmentVariable('CHEAT_CONFIG_PATH', $env:CHEAT_CONFIG_PATH, [EnvironmentVariableTarget]::User)
  if (!(Test-Path $env:CHEAT_CONFIG_PATH)) {
    (
      cheat --init
    ).Replace('cheatsheets/community', $community).Replace('cheatsheets/personal', $personal) > $env:CHEAT_CONFIG_PATH
  }
  if (!(gci $community)) {
    git clone https://github.com/cheat/cheatsheets.git $community
  }
}

<#
.SYNOPSIS
PowerShell `broot` compatibility wrapper.
https://github.com/Canop/broot/issues/159#issue-549501252
#>
function Invoke-Broot {
  $tempFile = New-TemporaryFile
  try {
    $broot = if ($env:BROOT) { $env:BROOT } else { 'broot' }
    &$broot --outcmd $tempFile $args
    if ($LASTEXITCODE -ne 0) {
      Write-Error "$broot exited with code $LASTEXITCODE"
      return
    }
    $command = Get-Content $tempFile
    if ($command) {
      # broot returns extended-length paths but not all PowerShell/Windows
      # versions might handle this so strip the '\\?'
      Invoke-Expression $command.Replace("\\?\", "")
    }
  }
  finally {
    Remove-Item -force $tempFile
  }
}

Set-Alias br Invoke-Broot
Set-Alias mutools Get-ModernUnixTools
Set-Alias muman Get-ModernUnixManual
Set-Alias mucomplete Enable-ModernUnixCompletions

$MyInvocation.MyCommand.ScriptBlock.Module.OnRemove = {
  $env:Path = $env:Path.Replace(";$binPath", "")
}
