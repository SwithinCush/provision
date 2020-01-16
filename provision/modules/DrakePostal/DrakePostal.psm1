
#Get public and private function definition files
$PublicFun = @( Get-ChildItem -Path "$PSScriptRoot\Public\Functions\*.ps1" )
$PublicVar = @( Get-ChildItem -Path "$PSScriptRoot\Public\Variables\*.ps1" )
$Private = @( Get-ChildItem -Path "$PSScriptRoot\Private\*.ps1" )

#Dot source the files
ForEach($import in @($PublicFun + $PublicVar + $Private))
{
    Try {
        . $import.fullname
    }
    Catch {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

Export-ModuleMember -Function $PublicFun.Basename
Export-ModuleMember -Variable $PublicVar.Basename

