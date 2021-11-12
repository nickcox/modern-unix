@{
  RootModule        = 'modern-unix-win.psm1'
  ModuleVersion     = '0.0.7'
  GUID              = '67392771-078d-43db-89f6-94ea0fecefe8'

  Author            = 'Nick Cox'
  Description       = 'Modern unix tools for PowerShell'
  PowerShellVersion = '5.0'

  FunctionsToExport = '*-*'
  AliasesToExport   = '*'

  PrivateData       = @{
    PSData = @{
      ReleaseNotes = 'Make -ToolName parameter mandatory for muman.'
      Tags         = @(
        'bat', 'lsd', 'delta', 'dust', 'duf', 'broot', 'fd', 'rg', 'fzf', 'sd', 'cheat',
        'btm', 'hyperfine', 'gping', 'procs', 'curlie', 'xh', 'zoxide', 'dog'
      )
      LicenseUri   = 'https://github.com/nickcox/modern-unix-pwsh/blob/master/LICENSE'
      ProjectUri   = 'https://github.com/nickcox/modern-unix-pwsh'
    }
  }
}

