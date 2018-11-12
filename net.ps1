    cls
    echo "Net tools by M00se"
    echo ""
    echo "Type 1 to activate DHCP"
    echo "Type 2 to decativate DHCP"
    echo "Type 3 to release/renew DHCP"
    echo "Type 4 to change static ip"
    echo "Type 5 to turn off Windows Firewall"
    echo "Type 6 to turn on Windows Firewall"
    echo "Type 7 to internet connectivity"
    echo "Type 8 to ping a host"
    echo "Type 9 to run a tracert"
    $choice = Read-Host "Selection"


if($choice -eq 1){
    cls
    netsh interface ipv4 show interfaces
    $NIC = Read-Host 'Select NIC'
    Set-NetIPInterface -InterfaceIndex $NIC -Dhcp Enabled; ipconfig /renew
}


if($choice -eq 2){
    cls
    netsh interface ipv4 show interfaces
    $NIC = Read-Host 'Select NIC'
    Set-NetIPInterface -InterfaceIndex $NIC -Dhcp Disabled
	}

if($choice -eq 3){
    cls
    netsh interface ipv4 show interfaces
    $NIC = Read-Host 'Select NIC'
    Get-NetAdapter -ifIndex $NIC | Get-NetIPAddress | Remove-NetIPAddress *
    ipconfig /release
    ipconfig /renew
    cls
    ipconfig
    echo "Successfully renewed DHCP address"
}


if($choice -eq 4){
    cls
    netsh interface ipv4 show interfaces
    $NIC = Read-Host 'Select Which NIC to configure'
    $IP = Read-Host 'Enter your desired IP'
    $NM = Read-Host 'Enter the netmask lenght (eg. 16)'
    $GW = Read-Host 'Enter your networks gateway'

    route -f

    Set-NetIPInterface -InterfaceIndex $NIC -Dhcp Disabled
    Set-NetIPInterface -InterfaceIndex $NIC -Dhcp Enabled
    Set-NetIPInterface -InterfaceIndex $NIC -Dhcp Disabled

	Get-NetAdapter -ifIndex $NIC | Get-NetIPAddress | Remove-NetIPAddress *

	New-NetIPAddress -InterfaceIndex $NIC -IPAddress "$IP" -PrefixLength $NM -DefaultGateway $GW
	cls
    sleep(2)
    ipconfig
	cls
	sleep(2)
	ipconfig
}

if($choice -eq 5){
    cls
    netsh advfirewall set allprofiles state off
    echo "Windows Firewall sucessfully turned off"
}

if($choice -eq 6){
    cls
    netsh advfirewall set allprofiles state on
    echo "Windows Firewall sucessfully turned on"
}

if($choice -eq 7){
    cls
    ping 8.8.8.8
}

if($choice -eq 8){
    cls
    $pc = Read-Host "Enter host IP"
    ping $pc
}

if($choice -eq 9){
    cls
    $trac = Read-Host "Enter host IP"
    ping $trac
}
pause
powershell -ExecutionPolicy ByPass -noexit "& ""FULL LOCATION OF THE POWERSHELL SCRIPT"""