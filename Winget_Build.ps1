$pkgalias_winget = @(
    "VLC"
    "Discord"
    "EGS"
    "Steam"
    "QBittorrent"
    "Stremio"
    "Microsoft Visual C++"
    "7-Zip"
    "Spotify"
    "Surfshark"
)

$winget_packages = @(
    "VideoLAN.VLC",
    "Discord.Discord",
    "EpicGames.EpicGamesLauncher",
    "Valve.Steam",
    "qBittorrent.qBittorrent",
    "Stremio.Stremio",
    "Microsoft.VCRedist.2015+.x64",
    "7zip.7zip",
    "Spotify.Spotify",
    "Surfshark.Surfshark"
)
$browserpackages = @(
    "brave",
    "librewolf",
    "googlechrome"
)
$pkgbrowseralias = @(
    "Brave"
    "LibreWolf"
    "Google Chrome"
)


function InstallBrowser{
    $browsercontinue = $true
    while ($browsercontinue){
        Write-Host "Select Browser to install"

        for ($i = 0; $i -lt $pkgbrowseralias.Count; $i++) {
            Write-Host "$($i + 1). $($pkgbrowseralias[$i])"
            if ($i -ge 2) {
                break
            }
        }
        $choice = Read-Host "Enter the number of the Browser you want to install (e.g., 1 for Brave.Brave, or 'q' to quit): "
        if ($choice -eq 'q') {
            $browsercontinue = $false
            break
        }
        if ($choice -ge 1) {
            $selectedPackage = $browserpackages[$choice - 1]
            Write-Host "Installing $selectedPackage..."
            winget install $selectedPackage
        } else {
            Write-Host "Invalid choice. Please select a valid option."
        }
    }
}



function WingetInstallSoftware {
    $wingetinstall_software = $true
    while ($wingetinstall_software) {
        Write-Host "Select Software to Install"
        Write-Host "1. Install all software"
        
        for($i = 0; $i -lt $pkgalias_winget.Length; $i++){
            Write-Host ("{0}. {1}" -f ($i + 2), $pkgalias_winget[$i])
        }
        $choice = Read-Host "Enter the number of the software you want to install (e.g., 1 for all, 2 for Vlc.., or 'q' to quit): "

        if($choice -eq 'q'){
            $wingetinstall_software = $false
            break
        }
        if ($choice -eq 1) {
            foreach ($package in $winget_packages) {
                Write-Host "Installing $package..."
                winget install $package -h
            }
        }
        elseif ($choice -ge 2){
            $selectedPackage = $winget_packages[$choice - 2]
            Write-Host "Installing $selectedPackage..."
            winget install $selectedPackage -h
        }
        else {
            Write-Host "Invalid action. Please select a valid option."
        }
    }
}

function WingetUninstaller{
    $wingetuninstaller = $true
    while($wingetuninstaller) {
        Write-Host "Select Software to Install"

        for ($i = 0; $i -lt $pkgalias_winget.Count; $i++) {
            Write-Host "$($i + 1). $($pkgalias_winget[$i])"
        }

        $choice = Read-Host "Enter the number of the software you want to uninstall (e.g. 1. for Vlc.., or 'q' to quit): "

        if($choice -eq 'q'){
            $wingetuninstaller = $false
            break
        }
        if ($choice -ge 1) {
            $selectedPackage = $winget_packages[$choice - 1]
            Write-Host "Uninstalling $selectedPackage..."
            winget uninstall --id $selectedPackage -h
        } else {
            Write-Host "Invalid choice. Please select a valid option."
        }

    }
}


$continue = $true

while ($continue) {
    Write-Host "Select an action:"
    Write-Host "1. Install Software"
    Write-Host "2. Install Browser"
    Write-Host "3. Uninstall Software"
    Write-Host "4. Exit"

    $action = Read-Host "Enter the number of the action you want to perform (e.g., 1 for install, 4 to quit): "

    if ($action -eq '4') {
        $continue = $false
        continue
    }
    if ($action -eq '1') {
        WingetInstallSoftware
    } elseif ($action -eq '2') {
        InstallBrowser
    } elseif ($action -eq '3') {
        WingetUninstaller
    } else {
        Write-Host "Invalid action. Please select a valid option."
    }
}

Write-Host "Thank you for Using. Made with Love :)"
