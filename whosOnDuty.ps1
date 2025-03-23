function Display-Name {
    param (
        $nameToDisplay
    )

    
    $nameToDisplay

    Add-Type -assembly System.Windows.Forms
    $mainForm = New-Object System.Windows.Forms.Form
    $mainForm.Text ='GUI'
    $mainForm.Width = 600
    $mainForm.Height = 400

    $Label = New-Object System.Windows.Forms.Label
    $Label.Text = "on duty: " + $nameToDisplay
    # Set font family name and size
    $Label. Font = 'Microsoft Sans Serif,14'
    # Set element position based on pixels from left and top of form
    $Label.Location = New-Object System.Drawing.Point(0,10)
    $Label.AutoSize = $true

    $button = New-Object System.Windows.Forms.Button
    $button. Font = 'Microsoft Sans Serif,14'
    $button.Text = "Click to confirm"
    $button.Location = New-Object System.Drawing.Point(0,40)
    $button.AutoSize = $true
    $button.PerformClick()
    $mainForm.Controls.Add($Label)
    $mainForm.Controls.Add($button)

    $ws = New-Object -ComObject WSript.Shell


    $mainForm.ShowDialog()
}

$today = Get-Date -Format "yyyy/dd/MM"

$lastDay = ""

$newNameList = ""

$nameList = Get-Content name_list.txt

$dutyRow = ($nameList[0] -split " ").Lenth + 1

if ((($nameList[-1]  -split " ")[$dutyRow]) -eq $today) {
    Show (($nameList[0]  -split " ")[$dutyRow])
} else {
    if (($nameList[-1]  -split " ").Length -eq ($nameList[0]  -split " ").Length) {
        $dutyRow += 1
    }
}
$logString = ""
$dutyName = ""
$selectedFlag = $false
foreach ($_ in $nameList) {

    if ($selectedFlag -eq $true) {
        $logString += $_ + "`n"
    } else {

        $name = ($_ -split " ")[0]

        $day = ($_ -split " ")[$dutyRow]

        if ($day -eq $null) {
           $dutyName = $name
           $logString += $_ + " " + $today + "`n"
           $selectedFlag = $true
        } else {
           if ($day -eq $today) {
               $dutyName = $name
               $logString += $_  + "`n"
               $selectedFlag = $true
           } else {
               $logString += $_  + "`n"
           }
        }
    }
}

$logString

Display-Name $dutyName

