#Start Windows Remote Management
Start-Service winrm

#Computer Info
$computerinfostart = ('===============Computer Information===============')
$computerinfo = (Get-ComputerInfo -Property CsSystemFamily, WindowsProductName, CsSystemType, OsInstallDate, OsUptime, LogonServer, CsProcessors, CsNetworkAdapters)

#Disk Info
$diskinfostart = ('===============Disk Information===============')
$diskinfo1 = (Get-WmiObject -Class Win32_LogicalDisk | Select-Object DeviceID, ProviderName, {$_.FreeSpace /1gb} | Format-List)
 
#Processor Info
$processorinfostart = ('===============Processor Info===============')
$processor1 = (Get-WmiObject win32_processor | Measure-Object -property LoadPercentage -Average | Select Average)
$processor2 = (get-wmiObject win32_processor | select loadpercentage)
get
#RAM Info
$ramstart = ('===============RAM Info===============')
$ram = (Get-WmiObject win32_physicalmemory | Select ConfiguredClockSpeed, {$_.Capacity /1gb})

#IP Info
$networkstart = ('===============Network Info===============')
$ipaddress = (Get-NetIPAddress -InterfaceAlias Ethernet*, Wi-fi* | Select InterfaceAlias, IpAddress)

$arr = @(
#Computer Info
$computerinfostart,
$computerinfo,

#Disk Info
$diskinfostart,
$diskinfo1,
$diskinfo2,

#Processor Info
$processorinfostart,
$processor1,
$processor2,

#RAM Info
$ramstart,
$ram,

#Network Info
$networkstart,
$ipaddress
)

foreach ($item in $arr){
    Write-Output ($item) >> "C:\Users\$($env:USERNAME)\Documents\SysInfo.txt"
} 