
using namespace System.Management.Automation
using namespace System.Management.Automation.Language

Register-ArgumentCompleter -Native -CommandName 'dust' -ScriptBlock {
  param($wordToComplete, $commandAst, $cursorPosition)

  $commandElements = $commandAst.CommandElements
  $command = @(
    'dust'
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
      'dust' {
        [CompletionResult]::new('-f', 'filecount', [CompletionResultType]::ParameterName, 'Directory ''size'' is number of child files/dirs not disk size')
        [CompletionResult]::new('--filecount', 'filecount', [CompletionResultType]::ParameterName, 'Directory ''size'' is number of child files/dirs not disk size')
        [CompletionResult]::new('-s', 'apparentsize', [CompletionResultType]::ParameterName, 'Use file length instead of blocks')
        [CompletionResult]::new('--apparent-size', 'apparentsize', [CompletionResultType]::ParameterName, 'Use file length instead of blocks')
        [CompletionResult]::new('-p', 'fullpaths', [CompletionResultType]::ParameterName, 'Subdirectories will not have their path shortened')
        [CompletionResult]::new('--full-paths', 'fullpaths', [CompletionResultType]::ParameterName, 'Subdirectories will not have their path shortened')
        [CompletionResult]::new('-i', 'ignore_hidden', [CompletionResultType]::ParameterName, 'Do not display hidden files')
        [CompletionResult]::new('--ignore_hidden', 'ignore_hidden', [CompletionResultType]::ParameterName, 'Do not display hidden files')
        [CompletionResult]::new('-x', 'x', [CompletionResultType]::ParameterName, 'Only count the files and directories on the same filesystem as the supplied directory')
        [CompletionResult]::new('--limit-filesystem', 'limitfilesystem', [CompletionResultType]::ParameterName, 'Only count the files and directories on the same filesystem as the supplied directory')
        [CompletionResult]::new('-b', 'nopercentbars', [CompletionResultType]::ParameterName, 'No percent bars or percentages will be displayed')
        [CompletionResult]::new('--no-percent-bars', 'nopercentbars', [CompletionResultType]::ParameterName, 'No percent bars or percentages will be displayed')
        [CompletionResult]::new('-c', 'nocolors', [CompletionResultType]::ParameterName, 'No colors will be printed (normally largest directories are colored)')
        [CompletionResult]::new('--no-colors', 'nocolors', [CompletionResultType]::ParameterName, 'No colors will be printed (normally largest directories are colored)')
        [CompletionResult]::new('-r', 'reverse', [CompletionResultType]::ParameterName, 'Print tree upside down (biggest highest)')
        [CompletionResult]::new('--reverse', 'reverse', [CompletionResultType]::ParameterName, 'Print tree upside down (biggest highest)')
        [CompletionResult]::new('-V', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
        [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
        [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
        [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')

        break
      }
    })

  $completions.Where{ $_.CompletionText -like "$wordToComplete*" -and !(($commandAst.CommandElements | ? Value | select -Exp Value) -ccontains $_.CompletionText) }
}
