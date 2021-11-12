
using namespace System.Management.Automation
using namespace System.Management.Automation.Language

Register-ArgumentCompleter -Native -CommandName 'lsd' -ScriptBlock {
  param($wordToComplete, $commandAst, $cursorPosition)

  $commandElements = $commandAst.CommandElements
  $command = @(
    'lsd'
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
      'lsd' {
        [CompletionResult]::new('-a', 'all', [CompletionResultType]::ParameterName, 'Do not ignore entries starting with .')
        [CompletionResult]::new('-all', 'all', [CompletionResultType]::ParameterName, 'Do not ignore entries starting with .')
        [CompletionResult]::new('-A', 'almostall', [CompletionResultType]::ParameterName, ' Do not list implied . and ..')
        [CompletionResult]::new('--almost-all', 'almostall', [CompletionResultType]::ParameterName, ' Do not list implied . and ..')
        [CompletionResult]::new('--classic', 'classic', [CompletionResultType]::ParameterName, 'Enable classic mode (no colors or icons)')
        [CompletionResult]::new('-L', 'dereference', [CompletionResultType]::ParameterName, 'When showing file information for a symbolic link, show information for the file the link references rather than for the link itself')
        [CompletionResult]::new('--dereference', 'dereference', [CompletionResultType]::ParameterName, 'When showing file information for a symbolic link, show information for the file the link references rather than for the link itself')
        [CompletionResult]::new('-d', 'directoryonly', [CompletionResultType]::ParameterName, 'Display directories themselves, and not their contents (recursively when used with --tree)')
        [CompletionResult]::new('--directory-only', 'directoryonly', [CompletionResultType]::ParameterName, 'Display directories themselves, and not their contents (recursively when used with --tree)')
        [CompletionResult]::new('-X', 'extensionsort', [CompletionResultType]::ParameterName, 'Sort by file extension')
        [CompletionResult]::new('--extensionsort', 'extensionsort', [CompletionResultType]::ParameterName, 'Sort by file extension')
        [CompletionResult]::new('-H', 'humanreadable', [CompletionResultType]::ParameterName, 'For ls compatibility purposes ONLY, currently set by default')
        [CompletionResult]::new('--human-readable', 'humanreadable', [CompletionResultType]::ParameterName, 'For ls compatibility purposes ONLY, currently set by default')
        [CompletionResult]::new('--ignore-config', 'ignoreconfig', [CompletionResultType]::ParameterName, 'ignore the configuration file')
        [CompletionResult]::new('-F', 'F', [CompletionResultType]::ParameterName, 'Append indicator (one of */=>@|) at the end of the file names')
        [CompletionResult]::new('--classify', 'classify', [CompletionResultType]::ParameterName, 'Append indicator (one of */=>@|) at the end of the file names')
        [CompletionResult]::new('-i', 'inode', [CompletionResultType]::ParameterName, 'Display the index number of each file')
        [CompletionResult]::new('--inode', 'inode', [CompletionResultType]::ParameterName, 'Display the index number of each file')
        [CompletionResult]::new('-l', 'long', [CompletionResultType]::ParameterName, 'Display extended file metadata as a table')
        [CompletionResult]::new('--long', 'long', [CompletionResultType]::ParameterName, 'Display extended file metadata as a table')
        [CompletionResult]::new('--no-symlink', 'nosymlink', [CompletionResultType]::ParameterName, 'Do not Display symlink target')
        [CompletionResult]::new('-1', 'oneline', [CompletionResultType]::ParameterName, 'Display one entry per line')
        [CompletionResult]::new('--oneline', 'oneline', [CompletionResultType]::ParameterName, 'Display one entry per line')
        [CompletionResult]::new('-R', 'recursive', [CompletionResultType]::ParameterName, 'Recurse into directories')
        [CompletionResult]::new('--recursive', 'recursive', [CompletionResultType]::ParameterName, 'Recurse into directories')
        [CompletionResult]::new('-r', 'reverse', [CompletionResultType]::ParameterName, 'Reverse the order of the sort')
        [CompletionResult]::new('--reverse', 'reverse', [CompletionResultType]::ParameterName, 'Reverse the order of the sort')
        [CompletionResult]::new('-S', 'sizesort', [CompletionResultType]::ParameterName, 'Sort by size')
        [CompletionResult]::new('--sizesort', 'sizesort', [CompletionResultType]::ParameterName, 'Sort by size')
        [CompletionResult]::new('-T', 'timesort', [CompletionResultType]::ParameterName, 'Sort by time modified')
        [CompletionResult]::new('--timesort', 'timesort', [CompletionResultType]::ParameterName, 'Sort by time modified')
        [CompletionResult]::new('--total-size', 'totalsize', [CompletionResultType]::ParameterName, 'Display the total size of directories')
        [CompletionResult]::new('--tree', 'tree', [CompletionResultType]::ParameterName, 'Recurse into directories and present the result as A tree')
        [CompletionResult]::new('-v', 'versionsort', [CompletionResultType]::ParameterName, 'Natural sort of (version) numbers within text')
        [CompletionResult]::new('--versionsort', 'versionsort', [CompletionResultType]::ParameterName, 'Natural sort of (version) numbers within text')
        [CompletionResult]::new('-V', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
        [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
        [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')

        break
      }
    })

  $completions.Where{ $_.CompletionText -like "$wordToComplete*" -and !(($commandAst.CommandElements | ? Value | select -Exp Value) -ccontains $_.CompletionText) }
}
