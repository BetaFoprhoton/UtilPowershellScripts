param($mode) #cannot run

function Display-Name {
    param (
        $nameToDisplay,
        $stringToOverride
    )

    Add-Type -assembly System.Windows.Forms
    $mainForm = New-Object System.Windows.Forms.Form
    $mainForm.Text ='GUI'
    $mainForm.Width = 600
    $mainForm.Height = 400

    $Label = New-Object System.Windows.Forms.Label
    $Label.Text = "语文演讲：" + $nameToDisplay
    # Set font family name and size
    $Label. Font = 'Microsoft Sans Serif,18'
    # Set element position based on pixels from left and top of form
    $Label.Location = New-Object System.Drawing.Point(0, 0)
    $Label.AutoSize = $true

    $mainForm.Controls.Add($Label)

    #$ws = New-Object -ComObject WSript.Shell

    $result = $mainForm.ShowDialog()
}

$today = Get-Date -Format "yyyy/dd/MM"

$lastDay = ""

$newNameList = ""

$nameList = Get-Content SR_name_list.txt

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
$selectedNum = 0
$hasSigned = $false
foreach ($_ in $nameList) {
    $name = ($_ -split " ")[0]

    $day = ($_ -split " ")[$dutyRow]

    if ($day -eq $null) {
        $dutyName = $name
        $logString += $_ + " " + $today + "`n"
        $selectedNum = 1
    } else {
       if ($day -eq $today) {
           $dutyName = $name
           $logString += $_  + "`n"
           $selectedNum = 1
           $hasSigned = $true
       } else {
           $logString += $_  + "`n"
       }
    }
}

#$logString
if ($mode -eq "") {
    Display-Name $dutyName $logString
}