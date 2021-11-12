
using namespace System.Management.Automation
using namespace System.Management.Automation.Language

Register-ArgumentCompleter -Native -CommandName 'gping' -ScriptBlock {
  param($wordToComplete, $commandAst, $cursorPosition)

  $commandElements = $commandAst.CommandElements
  $command = @(
    'gping'
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
      'gping' {
        [CompletionResult]::new('--cmd', 'cmd', [CompletionResultType]::ParameterName, 'Graph the execution time for a list of commands rather than pinging hosts')
        [CompletionResult]::new('-4', '4', [CompletionResultType]::ParameterName, 'Resolve ping targets to IPv4 address')
        [CompletionResult]::new('-6', '6', [CompletionResultType]::ParameterName, 'Resolve ping targets to IPv6 address')
        [CompletionResult]::new('-s', 'simplegraphics', [CompletionResultType]::ParameterName, 'Uses dot characters instead of braille')
        [CompletionResult]::new('--simple-graphics', 'simplegraphics', [CompletionResultType]::ParameterName, 'Uses dot characters instead of braille')
        [CompletionResult]::new('-b', 'buffer', [CompletionResultType]::ParameterName, 'Determines the number of seconds to display in the graph. [default: 30]')
        [CompletionResult]::new('--buffer', 'buffer', [CompletionResultType]::ParameterName, 'Determines the number of seconds to display in the graph. [default: 30]')
        [CompletionResult]::new('-n', 'watchinterval', [CompletionResultType]::ParameterName, 'Watch interval seconds (provide partial seconds like ''0.5'') [default: 0.5]')
        [CompletionResult]::new('--watch-interval', 'watchinterval', [CompletionResultType]::ParameterName, 'Watch interval seconds (provide partial seconds like ''0.5'') [default: 0.5]')
        [CompletionResult]::new('-V', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
        [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
        [CompletionResult]::new('-h', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
        [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')


        break
      }
    })

  $completions.Where{ $_.CompletionText -like "$wordToComplete*" -and !(($commandAst.CommandElements | ? Value | select -Exp Value) -ccontains $_.CompletionText) }
}
