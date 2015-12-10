param([String]$key)

$span = New-TimeSpan -Start 2010/1/1 -End (Get-Date)
$version = "rc1-update1-" + $span.Days.ToString() + ($span.Hours * 60 + $span.Minutes).ToString("0000")
$env:DNX_BUILD_VERSION = $version
& dnu restore
cd .\MusicBrainz.DNX
& dnu pack
$file = Get-Item "bin\Debug\*-$version.nupkg"
nuget push $file.FullName $key 
cd ./..