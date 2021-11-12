
using namespace System.Management.Automation
using namespace System.Management.Automation.Language

Register-ArgumentCompleter -Native -CommandName 'cheat' -ScriptBlock {
  param($wordToComplete, $commandAst, $cursorPosition)

  $commandElements = $commandAst.CommandElements
  $command = @(
    'cheat'
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
      'cheat' {
        [CompletionResult]::new('--init', 'init', [CompletionResultType]::ParameterName, ' Write A default config file to stdout')
        [CompletionResult]::new('-a', 'all', [CompletionResultType]::ParameterName, 'Search among all cheatpaths')
        [CompletionResult]::new('--all', 'all', [CompletionResultType]::ParameterName, 'Search among all cheatpaths')
        [CompletionResult]::new('-c', 'colorize', [CompletionResultType]::ParameterName, ' Colorize output')
        [CompletionResult]::new('--colorize', 'colorize', [CompletionResultType]::ParameterName, ' Colorize output')
        [CompletionResult]::new('-d', 'directories', [CompletionResultType]::ParameterName, 'List cheatsheet directories')
        [CompletionResult]::new('--directories', 'directories', [CompletionResultType]::ParameterName, 'List cheatsheet directories')
        [CompletionResult]::new('-e', 'edit', [CompletionResultType]::ParameterName, ' Edit <cheatsheet>')
        [CompletionResult]::new('--edit', 'edit', [CompletionResultType]::ParameterName, ' Edit <cheatsheet>')
        [CompletionResult]::new('-l', 'list', [CompletionResultType]::ParameterName, 'List cheatsheets')
        [CompletionResult]::new('--list', 'list', [CompletionResultType]::ParameterName, 'List cheatsheets')
        [CompletionResult]::new('-p', 'path', [CompletionResultType]::ParameterName, 'Return only sheets found on cheatpath <name>')
        [CompletionResult]::new('--path', 'path', [CompletionResultType]::ParameterName, 'Return only sheets found on cheatpath <name>')
        [CompletionResult]::new('-r', 'regex', [CompletionResultType]::ParameterName, 'Treat search <phrase> as a regex')
        [CompletionResult]::new('--regex', 'regex', [CompletionResultType]::ParameterName, 'Treat search <phrase> as a regex')
        [CompletionResult]::new('-s', 'search', [CompletionResultType]::ParameterName, 'Search cheatsheets for <phrase>')
        [CompletionResult]::new('--search', 'search', [CompletionResultType]::ParameterName, 'Search cheatsheets for <phrase>')
        [CompletionResult]::new('-t', 'tag', [CompletionResultType]::ParameterName, 'Return only sheets matching <tag>')
        [CompletionResult]::new('--tag', 'tag', [CompletionResultType]::ParameterName, 'Return only sheets matching <tag>')
        [CompletionResult]::new('-T', 'tags', [CompletionResultType]::ParameterName, 'List all tags in use')
        [CompletionResult]::new('--tags', 'tags', [CompletionResultType]::ParameterName, 'List all tags in use')
        [CompletionResult]::new('--rm', 'rm', [CompletionResultType]::ParameterName, 'Remove (delete) <cheatsheet>')
        [CompletionResult]::new('-v', 'v', [CompletionResultType]::ParameterName, 'Print the version number')
        [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Print the version number')

        break
      }
    })

  $completions.Where{ $_.CompletionText -like "$wordToComplete*" -and !(($commandAst.CommandElements | ? Value | select -Exp Value) -ccontains $_.CompletionText) }
}
