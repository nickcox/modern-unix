
using namespace System.Management.Automation
using namespace System.Management.Automation.Language

Register-ArgumentCompleter -Native -CommandName 'procs' -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)

    $commandElements = $commandAst.CommandElements
    $command = @(
        'procs'
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
        'procs' {
            [CompletionResult]::new('-W', 'W', [CompletionResultType]::ParameterName, 'Watch mode with custom interval')
            [CompletionResult]::new('--watch-interval', 'watch-interval', [CompletionResultType]::ParameterName, 'Watch mode with custom interval')
            [CompletionResult]::new('-i', 'i', [CompletionResultType]::ParameterName, 'Insert column to slot')
            [CompletionResult]::new('--insert', 'insert', [CompletionResultType]::ParameterName, 'Insert column to slot')
            [CompletionResult]::new('--only', 'only', [CompletionResultType]::ParameterName, 'Specified column only')
            [CompletionResult]::new('--sorta', 'sorta', [CompletionResultType]::ParameterName, 'Sort column by ascending')
            [CompletionResult]::new('--sortd', 'sortd', [CompletionResultType]::ParameterName, 'Sort column by descending')
            [CompletionResult]::new('-c', 'c', [CompletionResultType]::ParameterName, 'Color mode')
            [CompletionResult]::new('--color', 'color', [CompletionResultType]::ParameterName, 'Color mode')
            [CompletionResult]::new('--theme', 'theme', [CompletionResultType]::ParameterName, 'Theme mode')
            [CompletionResult]::new('-p', 'p', [CompletionResultType]::ParameterName, 'Pager mode')
            [CompletionResult]::new('--pager', 'pager', [CompletionResultType]::ParameterName, 'Pager mode')
            [CompletionResult]::new('--interval', 'interval', [CompletionResultType]::ParameterName, 'Interval to calculate throughput')
            [CompletionResult]::new('--completion', 'completion', [CompletionResultType]::ParameterName, 'Generate shell completion file')
            [CompletionResult]::new('-a', 'a', [CompletionResultType]::ParameterName, 'AND  logic for multi-keyword')
            [CompletionResult]::new('--and', 'and', [CompletionResultType]::ParameterName, 'AND  logic for multi-keyword')
            [CompletionResult]::new('-o', 'o', [CompletionResultType]::ParameterName, 'OR   logic for multi-keyword')
            [CompletionResult]::new('--or', 'or', [CompletionResultType]::ParameterName, 'OR   logic for multi-keyword')
            [CompletionResult]::new('-d', 'd', [CompletionResultType]::ParameterName, 'NAND logic for multi-keyword')
            [CompletionResult]::new('--nand', 'nand', [CompletionResultType]::ParameterName, 'NAND logic for multi-keyword')
            [CompletionResult]::new('-r', 'r', [CompletionResultType]::ParameterName, 'NOR  logic for multi-keyword')
            [CompletionResult]::new('--nor', 'nor', [CompletionResultType]::ParameterName, 'NOR  logic for multi-keyword')
            [CompletionResult]::new('-l', 'l', [CompletionResultType]::ParameterName, 'Show list of kind')
            [CompletionResult]::new('--list', 'list', [CompletionResultType]::ParameterName, 'Show list of kind')
            [CompletionResult]::new('--thread', 'thread', [CompletionResultType]::ParameterName, 'Show thread')
            [CompletionResult]::new('-t', 't', [CompletionResultType]::ParameterName, 'Tree view')
            [CompletionResult]::new('--tree', 'tree', [CompletionResultType]::ParameterName, 'Tree view')
            [CompletionResult]::new('-w', 'w', [CompletionResultType]::ParameterName, 'Watch mode with default interval (1s)')
            [CompletionResult]::new('--watch', 'watch', [CompletionResultType]::ParameterName, 'Watch mode with default interval (1s)')
            [CompletionResult]::new('--config', 'config', [CompletionResultType]::ParameterName, 'Generate configuration sample file')
            [CompletionResult]::new('--no-header', 'no-header', [CompletionResultType]::ParameterName, 'Suppress header')
            [CompletionResult]::new('--debug', 'debug', [CompletionResultType]::ParameterName, 'Show debug message')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information')
            break
        }
    })

    $completions.Where{ $_.CompletionText -like "$wordToComplete*" } |
        Sort-Object -Property ListItemText
}
