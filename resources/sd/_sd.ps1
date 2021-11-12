
using namespace System.Management.Automation
using namespace System.Management.Automation.Language

Register-ArgumentCompleter -Native -CommandName 'sd' -ScriptBlock {
  param($wordToComplete, $commandAst, $cursorPosition)

  $commandElements = $commandAst.CommandElements
  $command = @(
    'sd'
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
      'sd' {
        [CompletionResult]::new('-f', 'flags', [CompletionResultType]::ParameterName, 'Regex flags. May be combined (like `-f mc`).')
        [CompletionResult]::new('--flags', 'flags', [CompletionResultType]::ParameterName, 'Regex flags. May be combined (like `-f mc`).')
        [CompletionResult]::new('-s', 'stringmode', [CompletionResultType]::ParameterName, 'Treat expressions as non-regex strings')
        [CompletionResult]::new('--string-mode', 'stringmode', [CompletionResultType]::ParameterName, 'Treat expressions as non-regex strings')
        [CompletionResult]::new('-p', '--preview', [CompletionResultType]::ParameterName, 'Output result into stdout and do not modify files')
        [CompletionResult]::new('--preview', 'preview', [CompletionResultType]::ParameterName, 'Output result into stdout and do not modify files')
        [CompletionResult]::new('-V', '--version', [CompletionResultType]::ParameterName, 'Prints version information')
        [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
        [CompletionResult]::new('-h', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
        [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
        break
      }
    })

  $completions.Where{ $_.CompletionText -like "$wordToComplete*" -and !(($commandAst.CommandElements | ? Value | select -Exp Value) -ccontains $_.CompletionText) }
}
