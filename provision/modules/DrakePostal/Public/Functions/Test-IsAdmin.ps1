
Function Test-IsAdmin
{
    $windowsId = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $windowsPrincipal = New-Object System.Security.Principal.WindowsPrincipal($windowsId)

    $adminRole = [System.Security.Principal.WindowsBuiltInRole]::Administrator

    return $windowsPrincipal.IsInRole($adminRole)
    
}