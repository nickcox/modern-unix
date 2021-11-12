
using namespace System.Management.Automation
using namespace System.Management.Automation.Language

Register-ArgumentCompleter -Native -CommandName 'duf' -ScriptBlock {
  param($wordToComplete, $commandAst, $cursorPosition)

  $commandElements = $commandAst.CommandElements
  $command = @(
    'duf'
    for ($i = 1; $i -lt $commandElements.Count; $i++) {
      $element = $commandElements[$i]
      if ($element -isnot [StringConstantExpressionAst] -or
        $element.StringConstantType -ne [StringConstantType]::BareWord -or
        $element.Value.StartsWith('-')) {
        break
      }
      $element.Value
    }) -join ';'

  $completions = @(switch ($command) {
      'duf' {
        [CompletionResult]::new('-all', 'all', [CompletionResultType]::ParameterName, 'include pseudo, duplicate, inaccessible file systems')
        [CompletionResult]::new('-hide', 'hide', [CompletionResultType]::ParameterName, 'hide specific devices, separated with commas: local, network, fuse, special, loops, binds')
        [CompletionResult]::new('-hide-fs string', 'hidefs string', [CompletionResultType]::ParameterName, 'hide specific filesystems, separated with commas')
        [CompletionResult]::new('-inodes', 'inodes', [CompletionResultType]::ParameterName, 'list inode information instead of block usage')
        [CompletionResult]::new('-json', 'json', [CompletionResultType]::ParameterName, 'output all devices in JSON format')
        [CompletionResult]::new('-only', 'only', [CompletionResultType]::ParameterName, 'show only specific devices, separated with commas: local, network, fuse, special, loops, binds')
        [CompletionResult]::new('-only-fs', 'onlyfs', [CompletionResultType]::ParameterName, 'only specific filesystems, separated with commas')
        [CompletionResult]::new('-output', 'output', [CompletionResultType]::ParameterName, 'output fields: mountpoint, size, used, avail, usage, inodes, inodes_used, inodes_avail, inodes_usage, type, filesystem')
        [CompletionResult]::new('-sort', 'sort', [CompletionResultType]::ParameterName, 'sort output by: mountpoint, size, used, avail, usage, inodes, inodes_used, inodes_avail, inodes_usage, type, filesystem (default "mountpoint")')
        [CompletionResult]::new('-style', 'style', [CompletionResultType]::ParameterName, 'style: unicode, ascii (default "unicode")')
        [CompletionResult]::new('-theme', 'theme', [CompletionResultType]::ParameterName, 'color themes: dark, light (default "dark")')
        [CompletionResult]::new('-version', 'version', [CompletionResultType]::ParameterName, 'display version')
        [CompletionResult]::new('-warnings', 'warnings', [CompletionResultType]::ParameterName, 'output all warnings to STDERR')
        [CompletionResult]::new('-width', 'width', [CompletionResultType]::ParameterName, 'max output width')

        break
      }
    })

  $completions.Where{ $_.CompletionText -like "$wordToComplete*" -and !(($commandAst.CommandElements | ? Value | select -Exp Value) -ccontains $_.CompletionText) }
}
