rem Disable UAC and Enhanced Security

rem Open the Command Prompt as Admin and execute:

rem  disable uac 
reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d "0x00000000" /f

rem  disable enhanced security
reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v FilterAdministratorToken /t REG_DWORD /d "0x00000001" /f

reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\UIPI /ve /t REG_SZ /d "0x00000001" /f

rem Enable Remote Desktop

rem Open the Command Prompt as Admin and execute:

rem # enable remote desktop
reg.exe ADD "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f

rem # open firewall for remote desktop
netsh.exe advfirewall firewall set rule group="remote desktop" new enable=Yes

rem Enable and configure WinRM

rem Set network location to Private:

rem Open secpol.msc and go to Network List Manager Policies > Network and set Network Location to Private.
secpol
Open the Command Prompt as Admin and execute:

winrm quickconfig -q
winrm set winrm/config/winrs @{MaxMemoryPerShellMB="300"}
winrm set winrm/config @{MaxTimeoutms="1800000"}
winrm set winrm/config/service @{AllowUnencrypted="true"}
winrm set winrm/config/service/auth @{Basic="true"}
sc config WinRM start=auto
