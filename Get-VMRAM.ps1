<#
.SYNOPSIS
    Gets the total amount of RAM needed to start all VMs present on the target computer.
.DESCRIPTION
    This script gets the total RAM required to start and run all virtual machines that are currently registered on the target 
    computer. That amount is then divided by the total system RAM for the target computer and the resulting percentage is 
    displayed color-coded. If more than 85%, the percentage will be Red, and over 70% will be yellow. This is useful during 
    migrations to keep an eye on how taxed the target system is, but can be used in productinos to make sure that server 
    sprawl isn't eating up all available RAM on a single host.
.NOTES
    Repository: https://github.com/CambridgeComputing/Get-VMRAM
    Author: Dennis McDonald
.LINK
    https://github.com/CambridgeComputing/Get-VMRAM
.EXAMPLE
    Get-VMRAM
#>

Function Get-VMRAM {
    Param (
        [string]$ComputerName
    )

    if ($ComputerName.Length -eq 0) {           # if no argument passed...
            $ComputerName = "localhost"         # get local info
    }

    # Get total physical RAM
    $PhyRAM = (Get-CimInstance -ComputerName $ComputerName Win32_PhysicalMemory | Measure-Object -Property capacity -Sum).sum /1gb

    # Get all VM's info from localhost
    $VMs = Get-VM -ComputerName $ComputerName
    $VMs | Format-Table

    # Total up the RAM set for startup of all VMs
    $TotalRAM = 0
    $VMs | ForEach-Object {
        $TotalRAM += ($_.MemoryStartup/1gb)
    }
    $RAMUtilization = [math]::Round(($TotalRAM/$PhyRAM)*100)

    # Color code thresholds
    $color = switch ($RAMUtilization){
        {$_ -gt 85} {"Red"; break}
        {$_ -gt 70} {"Yellow"; break}
        Default {"White"}
    }

    # Output results
    Write-Host  "Total Allocated RAM: "([math]::ceiling($TotalRAM)) GB
    Write-Host  "Total Physical RAM:  "([math]::floor($PhyRAM)) GB
    Write-Host  `n"Total Utilization:    " -NoNewline
    Write-Host ([math]::Round(($TotalRAM/$PhyRAM)*100))% -ForegroundColor $color
}