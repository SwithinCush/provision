
Function Get-UNCFromPath
{
    param(
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true)]
        [String]
        $path)

    if ($path.Contains([io.path]::VolumeSeparatorChar)) {
        $psdrive = Get-PSDrive -Name $Path.Substring(0, 1) -PSProvider 'FileSystem'

        if ($psdrive.DisplayRoot) {
            $path = $path.Replace($psdrive.Name + [io.path]::VolumeSeparatorChar, $psdrive.DisplayRoot)
        }
    }

    return $path
}
