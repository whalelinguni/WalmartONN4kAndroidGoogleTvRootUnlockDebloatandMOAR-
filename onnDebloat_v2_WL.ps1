param (
    [switch]$Debug  # Define a switch parameter for debugging
)
Clear-Host

# Initial setup
$origForegroundColor = $host.UI.RawUI.ForegroundColor
$origBackgroundColor = $host.UI.RawUI.BackgroundColor
$scriptDir = $PWD
$tmpDir = Join-Path -Path $scriptDirectory -ChildPath "tmp"
$fallbackAdbPath = Join-Path -Path $scriptDir -ChildPath "bin\platform-tools\adb.exe" -ErrorAction SilentlyContinue

# Self-elevate the script if required
cls
Write-Host "########-----     [ Detecting Elevation Status ]     -----########"
Write-Host "`nUser will be prompted by UAC if elevation is required.`n"
Write-Host "#################################################################`n"
Start-Sleep -Seconds 3

if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
        $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
        Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine -WindowStyle Hidden
        Exit
    }
}

$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "Green"
Clear-Host

function addMeDelay {
    Start-Sleep -Milliseconds 450
}

function Write-Message {
    param(
        [Parameter(Position = 0, Mandatory = $true)]
        [string]$InputString,

        [int]$SleepTime = 350,

        [switch]$Wide,

        [int]$LinePadding = 1
    )

    function Write-FormattedMessage {
        param(
            [string]$ForegroundColor,
            [string]$BackgroundColor,
            [string]$Prefix,
            [string]$Message,
            [int]$Padding
        )
        $paddingSpaces = " " * $Padding
        Write-Host -ForegroundColor $ForegroundColor -BackgroundColor $BackgroundColor -NoNewLine $Prefix
        Write-Host -ForegroundColor White "$paddingSpaces$Message"
    }

    function Goodbye {
        Read-Host "Press Enter to exit"
        exit
    }

    # Split the input string into symbol and message
    $parts = $InputString -split ';'
    if ($parts.Count -ne 2) {
        Write-Host "Invalid input format. Please use 'Symbol; Message'."
        return
    }
    $Symbol = $parts[0].Trim()
    $Message = $parts[1].Trim()

    # Validate the symbol
    $validSymbols = "+", "-", "ERROR", "#", "W", "TITLE", "SUBTITLE", "NOTIFY"
    if (-not $validSymbols -contains $Symbol) {
        Write-Host "Unsupported message type: $Symbol"
        return
    }

    # Set the symbols based on the mode
    $prefix = if ($Wide) { "[  $Symbol  ]" } else { "[$Symbol]" }

    if ($Symbol -eq "NOTIFY") {
        $prefix = if ($Wide) { "[--Attention!--]" } else { "[--Attention!--]" }
    }
    if ($Symbol -eq "W") {
        $prefix = if ($Wide) { "[--WARNING!--]" } else { "[--WARNING!--]" }
    }

    switch ($Symbol) {
        "+" {
            Write-FormattedMessage -ForegroundColor Black -BackgroundColor Green -Prefix $prefix -Message $Message -Padding $LinePadding
        }
        "-" {
            Write-FormattedMessage -ForegroundColor Black -BackgroundColor Blue -Prefix $prefix -Message $Message -Padding $LinePadding
        }
        "ERROR" {
            Write-FormattedMessage -ForegroundColor Black -BackgroundColor Red -Prefix $prefix -Message $Message -Padding $LinePadding
        }
        "#" {
            Write-FormattedMessage -ForegroundColor Black -BackgroundColor Cyan -Prefix $prefix -Message $Message -Padding $LinePadding
        }
        "W" {
            Write-FormattedMessage -ForegroundColor Black -BackgroundColor Yellow -Prefix $prefix -Message $Message -Padding $LinePadding
        }
        "TITLE" {
            Write-Host ""
            Write-Host "####--- $Message ---####" -BackgroundColor Green -ForegroundColor Black
        }
        "SUBTITLE" {
            Write-Host "--- $Message ---" -BackgroundColor White -ForegroundColor Black
        }
        "NOTIFY" {
            Write-Host -ForegroundColor Red -BackgroundColor Yellow -NoNewLine $prefix
            Write-Host " $Message" -BackgroundColor Black -ForegroundColor White
        }
        default {
            Write-Host "Unsupported message type: $Symbol"
        }
    }

    Start-Sleep -Milliseconds $SleepTime

    # Example usage of Goodbye within the function
    if ($Symbol -eq "ERROR") {
        Goodbye
    }
}

function Test-PathEx {
    param (
        [string]$Path
    )
    Write-Message "DEBUG" "Testing Path: $Path"
    if (Test-Path $Path) {
        Write-Message "DEBUG" "Path Valid: $Path"
    } else {
        Write-Message "ERROR" "Error. Path '$Path' does not exist.`nAborting. Exiting."
        Write-Host " "
        pause
        exit
    }
}

function loadButtholes {
    param (
        [string]$loadMsg
    )

    Write-Host $loadMsg -NoNewLine
    $Symbols = [string[]]('|','/','-','\')
    $SymbolIndex = [byte] 0
    $Job = Start-Job -ScriptBlock { Start-Sleep -Seconds 3 }
    while ($Job.'JobStateInfo'.'State' -eq 'Running') {
        if ($SymbolIndex -ge $Symbols.'Count') {$SymbolIndex = [byte] 0}
        Write-Host -NoNewline -Object ("{0}`b" -f $Symbols[$SymbolIndex++])
        Start-Sleep -Milliseconds 200
    }
}

function SplashMe {
    param([string]$Text)

    $Text.ToCharArray() | ForEach-Object {
        switch -Regex ($_){
            "`r" {
                break
            }
            "`n" {
                Write-Host " "; break
            }
            "[^ ]" {
                $writeHostOptions = @{
                    NoNewLine = $true
                }
                Write-Host $_ @writeHostOptions
                break
            }
            " " {
                Write-Host " " -NoNewline
            }
        } 
    }
}

function Write-HyphenToEnd {
    param (
        [string]$text = "",
        [int]$padding = 0
    )

    if ($text -eq "") {
        $consoleWidth = [Console]::WindowWidth
        Write-Host ("-" * $consoleWidth)
    } else {
        $textLength = $text.Length + ($padding * 2)
        Write-Host ("-" * $textLength)
    }
}

$splashLoad = @"

                      _____  _   _  _   _     _     _  _____  ___      _    __      
                     (  _  )( ) ( )( ) ( )   ( )   ( )(  _  )(  _ \  /  ) / __ \    
                     | ( ) ||  \| ||  \| |    \ \_/ / | ( ) || ( (_)(_  |(_)  ) )   
                     | | | ||     ||     |      \ /   | | | || |  _   | |   /  /    
                     | (_) || | \ || | \ |      | |   | (_) || (_( )  | | /  /( )   
                     (_____)(() (_)(() (_)      (_)   (_____)(____/   (_)(_____/    
                            (_)    (_)                                              
                                                                
  ___           _      _                  _                                     _____                _   
 (  _ \        ( )    (_ )               ( )_               _                  (_   _)              (_ ) 
 | | ) |   __  | |_    |(|    _      _ _ |  _)   __   _ __ (_)  ___     __     /|| |     _      _    |(| 
 | | | ) / __ \|  _ \  |()  / _ \  / _  )| |   / __ \(  __)| |/  _  \ / _  \  (_)| |   / _ \  / _ \  |() 
 | |_) |(  ___/| |_) ) | | ( (_) )( (_| || |_ (  ___/| |   | || ( ) |( (_) |     | |  ( (_) )( (_) ) | | 
 (____/  )\___)/( __/ ( (_) \ __/  \(_ _))\__) )\___)(()   ( )(() (_) \__  |     ( )   \ __/  \ __/ ( (_)
        (__)  (__)    (_)   /(     (_)  (__)  (__)   (_)   /( (_)    ( )_) |     /(    /(     /(    (_)  
                           (__)                           (__)        \___/     (__)  (__)   (__)        


"@

function Get-AdbPath {
	Write-Message "-; Checking enviorment for adb."

    # Test if adb command is available and working
    try {
        & adb.exe --version > $null 2>&1
        # If the command succeeds, return the command path
		Write-Message "+; ADB installed on host system."
		Write-Message "+; Enviorment is checked ok."
        return "adb.exe"
    } catch {
        Write-Message "ERROR; adb.exe not found or not working."
        Write-Message "ERROR; Would you like to use the fallback adb located in $fallbackAdbPath? (y/n)"
        $useFallback = Read-Host "[?] (y/n)"
        if ($useFallback.ToLower() -eq 'y') {
            if (-not (Test-Path $fallbackAdbPath)) {
				Write-Message "W; Enviorment check is fail. ADB is missing or kidnapped."
                Write-Message "ERROR; Fallback adb not found at $fallbackAdbPath."
				Write-Message "#; Cannot continue without adb.exe. Abortion. Exiting."
                pause
				exit
            }
            return $fallbackAdbPath
        } else {
			Write-Message "W; Enviorment check is fail. ADB is missing or kidnapped."
            Write-Message "ERROR; Abortion. adb is not available and fallback option was not accepted."
            Write-Message "#; Cannot continue without adb.exe. Abortion. Exiting."
            pause
			exit
        }
    }
}

<#
########################################################################################################################################################################

[ Main script start below -- WL ]            [ Main script start below -- WL ]            [ Main script start below -- WL ]            [ Main script start below -- WL ]

########################################################################################################################################################################
#>

#### [ STARTUP ] ####
#-------------------#

Write-Host "This script is still in development!"
Write-Host "While it may work, it has not been thoroughly tested. It doesn't look like there should be any issues to me."
Write-Host ""
Write-Host "Use at your own risk..."
Write-Host ""
$WARNING = Read-Host "Continue? [y/n]"

switch ($WARNING.ToLower()) {
    'y' {
        Write-Host "Continuing..."
		Write-Host ""
    }
    'n' {
        Write-Host "Abortion. Exiting."
		pause
        exit
    }
    default {
        Write-Host "Invalid response. Please enter 'y' or 'n'."
        # Optionally prompt the user again or exit
        # exit
    }
}


# Dictionary of pre-installed bloatware apps
$bloatware = @{
    'YouTube' = 'com.google.android.youtube.tv'
    'Apple TV' = 'com.apple.atve.androidtv.appletv'
    'Disney' = 'com.disney.disneyplus'
    'ESPN' = 'com.espn.score_center'
    'HULU' = 'com.hulu.livingroomplus'
    'MAX (formerly HBO MAX)' = 'com.wbd.stream'
    'Paramount+' = 'com.cbs.ott'
    'Prime Video' = 'com.amazon.amazonvideo.livingroom'
    'YouTube Music' = 'com.google.android.youtube.tvmusic'
    'Play Games' = 'com.google.android.play.games'
    'Default TV Launcher' = 'com.google.android.apps.tv.launcherx'
    'Play Movies & TV' = 'com.google.android.videos'
    'Netflix' = 'com.netflix.ninja'
    'Tubi' = 'com.tubitv'
    'YouTube TV' = 'com.google.android.youtube.tvunplugged'
}


function DebloatDevice {
    $adbPath = Get-AdbPath -scriptDir $scriptDir

    if (-not $adbPath) {
        Write-Message "ERROR; adb.exe is not available. Exiting."
        return
    }
	
	Write-Message "TITLE; Debloating"

    # Confirmation prompt
    Write-Output "This script will give you the option to remove, disable, or skip bloatware packages."
    $confirmation = Read-Host "Would you like to proceed now? (y/n)"
    if ($confirmation.ToLower() -ne 'y') {
        Write-Message "W; Abortion by user."
        return
    }

    foreach ($app in $bloatware.Keys) {
        $validInput = $false
        while (-not $validInput) {
            $action = Read-Host "Do you want to (r)emove or (d)isable $app ($($bloatware[$app]))? (r/d)"
            switch ($action.ToLower()) {
                'r' {
                    try {
                        Write-Message "-; Removing $app ..."
                        $result = & $adbPath shell "pm uninstall --user 0 $($bloatware[$app])"
                        if ($result -like "*Success*") {
                            Write-Message "+; Removed $app ($($bloatware[$app]))."
                        } else {
                            Write-Message "ERROR; Failed to remove $app ($($bloatware[$app])). Already removed/Not installed."
                        }
                    } catch {
                        Write-Message "ERROR; Error executing adb command."
                    }
                    $validInput = $true
                }
                'd' {
                    try {
                        Write-Message "-; Disabling $app ..."
                        $result = & $adbPath shell "pm disable-user --user 0 $($bloatware[$app])"
                        if ($result -like "*Success*") {
                            Write-Message "+; Disabled $app ($($bloatware[$app]))."
                        } else {
                            Write-Message "ERROR; Failed to disable $app ($($bloatware[$app])). Already disabled/Not installed."
                        }
                    } catch {
                        Write-Message "ERROR; Error executing adb command."
                    }
                    $validInput = $true
                }
                default {
                    Write-Message "ERROR; Invalid input. Please enter 'r' to remove or 'd' to disable."
                }
            }
        }
    }
}


SplashMe $splashLoad
Write-HyphenToEnd
write-output ""
Write-Message "#; Script loading ..."
Write-Message "-; Checking enviorment ..."

DebloatDevice
pause
