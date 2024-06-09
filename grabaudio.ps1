param (
    [Parameter(Mandatory=$true, Position=0)]
    [string]$url,
    [Parameter(Mandatory=$false, Position=1)]
    [string]$filename
)

#take in input for $youtubeurl
$youtubeurl = $url

if ([string]::IsNullOrEmpty($filename)) {
    $filename = "output.mp3"
}

if (Test-Path $filename) {
    Remove-Item $filename -Force
    Write-Output "The file '$filename' existed and has been deleted."
}

#pass input into wsl
$output = wsl ./grabaudio.sh $youtubeurl $filename
Write-Output $output

# Convert it to a windows file path
$WindowsPath = wsl wslpath -w "$output"

# Output it back out for windows to use
Write-Output $WindowsPath
