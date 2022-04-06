# Get-VMRAM
Gets the total amount of RAM needed to start all VMs present on the target computer.

## Functions
`Get-VMRAM` is the only function in this script for now. It accepts a single argument for a computer name. If the computer name is omitted, localhost is used.
## Examples
Get VM info and RAM utilization for a remote computer:

    PS> Get-VMRAM -ComputerName host01


    Name            State   CPUUsage(%) MemoryAssigned(M) Uptime              Status             Version
    ----            -----   ----------- ----------------- ------              ------             -------
    VM01            Running 0           8192              85.21:45:40.3070000 Operating normally 8.0
    VM02            Off     0           0                 00:00:00            Operating normally 8.0
    VM03            Running 0           4096              27.15:20:42.0590000 Operating normally 9.0
    VM04            Running 0           2048              85.11:42:46.0180000 Operating normally 8.0
    VM05            Running 0           2048              84.11:26:05.1600000 Operating normally 9.0
    VM06            Running 0           16384             28.13:43:51.9810000 Operating normally 8.0
    VM07            Off     0           0                 00:00:00            Operating normally 8.0
    VM08            Running 0           8192              84.11:29:28.8470000 Operating normally 9.0
    VM09            Running 0           24576             84.10:51:27.4780000 Operating normally 8.0
    VM10            Running 0           8192              77.16:43:06.4480000 Operating normally 9.0
    VM11            Off     0           0                 00:00:00            Operating normally 8.0
    VM12            Running 0           6144              84.11:26:49.1440000 Operating normally 9.0
    VM13            Running 0           6144              28.15:22:59.7450000 Operating normally 9.0


    Total Allocated RAM:  114 GB
    Total Physical RAM:   128 GB

    Total Utilization:    89 %

# TODO List
- [ ] Add `Test-Connection` before each connection attempt to reduce waiting time and error output
- [ ] Add teh ability to query several servers at once
- [ ] Add parameter or function to get succinct output in table form or pipe to other functions