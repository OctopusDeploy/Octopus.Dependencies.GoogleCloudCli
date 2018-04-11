Add-Type -AssemblyName System.IO.Compression.FileSystem

# Grab the link to the latest version fom https://cloud.google.com/sdk/downloads#archive
# We bundle the "Windows 32-bit (x86) with Python bundled" package
$gcpSdkUrl = "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-197.0.0-windows-x86-bundled-python.zip"
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -UseBasicParsing -Uri $gcpSdkUrl -OutFile google-cloud-sdk.zip
Remove-Item "google-cloud-sdk" -Recurse -ErrorAction Ignore
$cwd = (Get-Item -Path ".\" -Verbose).FullName
[System.IO.Compression.ZipFile]::ExtractToDirectory("$cwd\google-cloud-sdk.zip", $cwd)

$gcpSdkUrl -match "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-(\d+\.+\d+\.\d+)"
$version = $Matches[1]

(Get-Content gcpsdk.nuspec).replace('#{GCPSDKVersion}', $version) | Set-Content gcpsdk-processed.nuspec