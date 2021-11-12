
using namespace System.Management.Automation
using namespace System.Management.Automation.Language

Register-ArgumentCompleter -Native -CommandName 'bat' -ScriptBlock {
  param($wordToComplete, $commandAst, $cursorPosition)

  $commandElements = $commandAst.CommandElements
  $command = @(
    'bat'
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
      'bat' {
        [CompletionResult]::new('-l', 'language', [CompletionResultType]::ParameterName, 'Set the language for syntax highlighting.')
        [CompletionResult]::new('--language', 'language', [CompletionResultType]::ParameterName, 'Set the language for syntax highlighting.')
        [CompletionResult]::new('--list-languages', 'listlanguages', [CompletionResultType]::ParameterName, 'Display all supported languages.')
        [CompletionResult]::new('-m', 'mapsyntax', [CompletionResultType]::ParameterName, 'Map a file extension or name to an existing syntax.')
        [CompletionResult]::new('--map-syntax', 'mapsyntax', [CompletionResultType]::ParameterName, 'Map a file extension or name to an existing syntax.')
        [CompletionResult]::new('--theme', 'theme', [CompletionResultType]::ParameterName, 'Set the color theme for syntax highlighting.')
        [CompletionResult]::new('--list-themes', 'listthemes', [CompletionResultType]::ParameterName, 'Display all supported highlighting themes.')
        [CompletionResult]::new('--style', 'style', [CompletionResultType]::ParameterName, 'Comma-separated list of style elements to display (*auto*, full, plain, changes, header, grid, numbers).')
        [CompletionResult]::new('-p', 'plain', [CompletionResultType]::ParameterName, 'Show plain style (alias for ''--style=plain'').')
        [CompletionResult]::new('--plain', 'plain', [CompletionResultType]::ParameterName, 'Show plain style (alias for ''--style=plain'').')
        [CompletionResult]::new('-n', 'showall', [CompletionResultType]::ParameterName, 'Show line numbers (alias for ''--style=numbers'').')
        [CompletionResult]::new('--number', 'number', [CompletionResultType]::ParameterName, 'Show line numbers (alias for ''--style=numbers'').')
        [CompletionResult]::new('-A', 'showall', [CompletionResultType]::ParameterName, 'Show non-printable characters (space, tab, newline, ..).')
        [CompletionResult]::new('--show-all', 'showall', [CompletionResultType]::ParameterName, 'Show non-printable characters (space, tab, newline, ..).')
        [CompletionResult]::new('-r', 'linerange', [CompletionResultType]::ParameterName, 'Only print the lines from N to M.')
        [CompletionResult]::new('--line-range', 'linerange', [CompletionResultType]::ParameterName, 'Only print the lines from N to M.')
        [CompletionResult]::new('-H', 'highlightline', [CompletionResultType]::ParameterName, 'Highlight the given line.')
        [CompletionResult]::new('--highlight-line', 'highlightline', [CompletionResultType]::ParameterName, 'Highlight the given line.')
        [CompletionResult]::new('--color', 'color', [CompletionResultType]::ParameterName, 'When to use colors (*auto*, never, always).')
        [CompletionResult]::new('--italic-text', 'italictext', [CompletionResultType]::ParameterName, 'Use italics in output (always, *never*)')
        [CompletionResult]::new('--decorations', 'decorations', [CompletionResultType]::ParameterName, 'When to show the decorations (*auto*, never, always).')
        [CompletionResult]::new('--paging', 'paging', [CompletionResultType]::ParameterName, 'Specify when to use the pager (*auto*, never, always).')
        [CompletionResult]::new('--wrap', 'wrap', [CompletionResultType]::ParameterName, 'Specify the text-wrapping mode (*auto*, never, character).')
        [CompletionResult]::new('--tabs', 'tabs', [CompletionResultType]::ParameterName, 'Set the tab width to T spaces.')
        [CompletionResult]::new('-h', 'help', [CompletionResultType]::ParameterName, 'Print short help message.')
        [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print tailed help message.')
        [CompletionResult]::new('-V', 'version', [CompletionResultType]::ParameterName, 'Show version information.')
        [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Show version information.')

        break
      }

      'bat;cache' {
        [CompletionResult]::new('-b', 'build', [CompletionResultType]::ParameterName, 'Initialize (or update) the syntax/theme cache.')
        [CompletionResult]::new('--build', 'build', [CompletionResultType]::ParameterName, 'Initialize (or update) the syntax/theme cache.')
        [CompletionResult]::new('-c', 'clear', [CompletionResultType]::ParameterName, 'Remove the cached syntax definitions and themes.')
        [CompletionResult]::new('--clear', 'clear', [CompletionResultType]::ParameterName, 'Remove the cached syntax definitions and themes.')
        [CompletionResult]::new('--source', 'source', [CompletionResultType]::ParameterName, 'Use a different directory to load syntaxes and themes from.')
        [CompletionResult]::new('--target', 'target', [CompletionResultType]::ParameterName, 'Use a different directory to store the cached syntax and theme set.')
        [CompletionResult]::new('--blank', 'blank', [CompletionResultType]::ParameterName, 'Create completely new syntax and theme sets (instead of appending to the default sets).')
        [CompletionResult]::new('-h', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
        [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')

        break
      }
    })

  $completions.Where{ $_.CompletionText -like "$wordToComplete*" -and !(($commandAst.CommandElements | ? Value | select -Exp Value) -ccontains $_.CompletionText) }
}
