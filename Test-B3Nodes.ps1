$nodestotest = Get-Content "$PSScriptRoot\b3 nodes.txt"

$successes = @()
$failures = @()

# Loop through node list and test connection to each node on port 5647
Foreach ($node in $nodestotest)
{
    # Test connection
    Write-Verbose -Message "Testing connection to node $node" -Verbose
    $result = Test-NetConnection -ComputerName $node -Port 5647 -WarningAction SilentlyContinue

    # If it worked, put it in the working array
    if ($result.TcpTestSucceeded -eq $true)
    {
        $successes += "addnode=$node"
        Write-Verbose -Message "Adding $node to successes list" -Verbose
    }

    # Otherwise, put it in the non-working array
    elseif ($result.TcpTestSucceeded -eq $false)
    {
        $failures += $node
        Write-Verbose -Message "Adding $node to failures list" -Verbose
    }
}

# Export both to new text files
$successes | Out-File "$PSScriptRoot\b3 successes.txt"
$failures | Out-File "$PSScriptRoot\b3 failures.txt"