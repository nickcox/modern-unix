
using namespace System.Management.Automation
using namespace System.Management.Automation.Language

Register-ArgumentCompleter -Native -CommandName 'broot', 'br' -ScriptBlock {
  param($wordToComplete, $commandAst, $cursorPosition)

  $commandElements = $commandAst.CommandElements
  $command = @(
    'broot'
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
      'broot' {
        [CompletionResult]::new('--outcmd', 'outcmd', [CompletionResultType]::ParameterName, 'Where to write the produced cmd (if any)')
        [CompletionResult]::new('-c', 'c', [CompletionResultType]::ParameterName, 'Semicolon separated commands to execute')
        [CompletionResult]::new('--cmd', 'cmd', [CompletionResultType]::ParameterName, 'Semicolon separated commands to execute')
        [CompletionResult]::new('--color', 'color', [CompletionResultType]::ParameterName, 'Whether to have styles and colors (auto is default and usually OK)')
        [CompletionResult]::new('--conf', 'conf', [CompletionResultType]::ParameterName, 'Semicolon separated paths to specific config files')
        [CompletionResult]::new('--height', 'height', [CompletionResultType]::ParameterName, 'Height (if you don''t want to fill the screen or for file export)')
        [CompletionResult]::new('-o', 'o', [CompletionResultType]::ParameterName, 'Where to write the produced path (if any)')
        [CompletionResult]::new('--out', 'out', [CompletionResultType]::ParameterName, 'Where to write the produced path (if any)')
        [CompletionResult]::new('--set-install-state', 'set-install-state', [CompletionResultType]::ParameterName, 'Set the installation state (for use in install script)')
        [CompletionResult]::new('--print-shell-function', 'print-shell-function', [CompletionResultType]::ParameterName, 'Print to stdout the br function for a given shell')
        [CompletionResult]::new('--listen', 'listen', [CompletionResultType]::ParameterName, 'Listen for commands')
        [CompletionResult]::new('--send', 'send', [CompletionResultType]::ParameterName, 'send commands to a remote broot then quits')
        [CompletionResult]::new('-d', 'd', [CompletionResultType]::ParameterName, 'Show the last modified date of files and directories')
        [CompletionResult]::new('--dates', 'dates', [CompletionResultType]::ParameterName, 'Show the last modified date of files and directories')
        [CompletionResult]::new('-D', 'D', [CompletionResultType]::ParameterName, 'Don''t show last modified date')
        [CompletionResult]::new('--no-dates', 'no-dates', [CompletionResultType]::ParameterName, 'Don''t show last modified date')
        [CompletionResult]::new('-f', 'f', [CompletionResultType]::ParameterName, 'Only show folders')
        [CompletionResult]::new('--only-folders', 'only-folders', [CompletionResultType]::ParameterName, 'Only show folders')
        [CompletionResult]::new('-F', 'F', [CompletionResultType]::ParameterName, 'Show folders and files alike')
        [CompletionResult]::new('--no-only-folders', 'no-only-folders', [CompletionResultType]::ParameterName, 'Show folders and files alike')
        [CompletionResult]::new('--show-root-fs', 'show-root-fs', [CompletionResultType]::ParameterName, 'Show filesystem info on top')
        [CompletionResult]::new('-g', 'g', [CompletionResultType]::ParameterName, 'Show git statuses on files and stats on repo')
        [CompletionResult]::new('--show-git-info', 'show-git-info', [CompletionResultType]::ParameterName, 'Show git statuses on files and stats on repo')
        [CompletionResult]::new('-G', 'G', [CompletionResultType]::ParameterName, 'Don''t show git statuses on files')
        [CompletionResult]::new('--no-show-git-info', 'no-show-git-info', [CompletionResultType]::ParameterName, 'Don''t show git statuses on files')
        [CompletionResult]::new('--git-status', 'git-status', [CompletionResultType]::ParameterName, 'Only show files having an interesting git status, including hidden ones')
        [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Show hidden files')
        [CompletionResult]::new('--hidden', 'hidden', [CompletionResultType]::ParameterName, 'Show hidden files')
        [CompletionResult]::new('-H', 'H', [CompletionResultType]::ParameterName, 'Don''t show hidden files')
        [CompletionResult]::new('--no-hidden', 'no-hidden', [CompletionResultType]::ParameterName, 'Don''t show hidden files')
        [CompletionResult]::new('-i', 'i', [CompletionResultType]::ParameterName, 'Show files which should be ignored according to git')
        [CompletionResult]::new('--show-gitignored', 'show-gitignored', [CompletionResultType]::ParameterName, 'Show files which should be ignored according to git')
        [CompletionResult]::new('-I', 'I', [CompletionResultType]::ParameterName, 'Don''t show gitignored files')
        [CompletionResult]::new('--no-show-gitignored', 'no-show-gitignored', [CompletionResultType]::ParameterName, 'Don''t show gitignored files')
        [CompletionResult]::new('-p', 'p', [CompletionResultType]::ParameterName, 'Show permissions, with owner and group')
        [CompletionResult]::new('--permissions', 'permissions', [CompletionResultType]::ParameterName, 'Show permissions, with owner and group')
        [CompletionResult]::new('-P', 'P', [CompletionResultType]::ParameterName, 'Don''t show permissions')
        [CompletionResult]::new('--no-permissions', 'no-permissions', [CompletionResultType]::ParameterName, 'Don''t show permissions')
        [CompletionResult]::new('-s', 's', [CompletionResultType]::ParameterName, 'Show the size of files and directories')
        [CompletionResult]::new('--sizes', 'sizes', [CompletionResultType]::ParameterName, 'Show the size of files and directories')
        [CompletionResult]::new('-S', 'S', [CompletionResultType]::ParameterName, 'Don''t show sizes')
        [CompletionResult]::new('--no-sizes', 'no-sizes', [CompletionResultType]::ParameterName, 'Don''t show sizes')
        [CompletionResult]::new('--sort-by-count', 'sort-by-count', [CompletionResultType]::ParameterName, 'Sort by count (only show one level of the tree)')
        [CompletionResult]::new('--sort-by-date', 'sort-by-date', [CompletionResultType]::ParameterName, 'Sort by date (only show one level of the tree)')
        [CompletionResult]::new('--sort-by-size', 'sort-by-size', [CompletionResultType]::ParameterName, 'Sort by size (only show one level of the tree)')
        [CompletionResult]::new('-w', 'w', [CompletionResultType]::ParameterName, 'Sort by size, show ignored and hidden files')
        [CompletionResult]::new('--whale-spotting', 'whale-spotting', [CompletionResultType]::ParameterName, 'Sort by size, show ignored and hidden files')
        [CompletionResult]::new('--no-sort', 'no-sort', [CompletionResultType]::ParameterName, 'Don''t sort')
        [CompletionResult]::new('-t', 't', [CompletionResultType]::ParameterName, 'Trim the root too and don''t show a scrollbar')
        [CompletionResult]::new('--trim-root', 'trim-root', [CompletionResultType]::ParameterName, 'Trim the root too and don''t show a scrollbar')
        [CompletionResult]::new('-T', 'T', [CompletionResultType]::ParameterName, 'Don''t trim the root level, show a scrollbar')
        [CompletionResult]::new('--no-trim-root', 'no-trim-root', [CompletionResultType]::ParameterName, 'Don''t trim the root level, show a scrollbar')
        [CompletionResult]::new('--install', 'install', [CompletionResultType]::ParameterName, 'Install or reinstall the br shell function')
        [CompletionResult]::new('--get-root', 'get-root', [CompletionResultType]::ParameterName, 'Ask for the current root of the remote broot')
        [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
        [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
        [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
        break
      }
    })

  $completions.Where{ $_.CompletionText -like "$wordToComplete*" } |
  Sort-Object -Property ListItemText
}
